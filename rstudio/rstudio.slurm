#!/bin/bash
#-----------------------------------------------------------------------------
#
#SBATCH -J rstudio                    # Job name
#SBATCH -o rstudio.out                # Name of stdout output file (%j expands to jobId)
#SBATCH -p v100                       # Queue name
#SBATCH -N 1                          # Total number of nodes requested (16 cores/node)
#SBATCH -n 1                          # Total number of mpi tasks requested
#SBATCH -t 04:00:00                   # Run time (hh:mm:ss) - 2 hours

module load tacc-singularity
RSTUDIO_DIR="/scratch/projects/rstudio"
RSTUDIO_IMG="${RSTUDIO_DIR}/rstudio_1.4.1717.sif"

#--------------------------------------------------------------------------
# ---- You normally should not need to edit anything below this point -----
#--------------------------------------------------------------------------

# gather username from environment
USERNAME=$(whoami)

# gather node name for this job
NODE_HOSTNAME=`hostname -s`
NODE_HOSTNAME_DOMAIN=`hostname -d`

# unload xalt to avoid error messages
module unload xalt

# make .rstudio dir for temp files, clean up after old run
RSTUDIO_SERVERDIR=$HOME/.rstudio
mkdir -p $RSTUDIO_SERVERDIR
rm -f $RSTUDIO_SERVERDIR/.rstudio_address \
      $RSTUDIO_SERVERDIR/.rstudio_port \
      $RSTUDIO_SERVERDIR/.rstudio_status \
      $RSTUDIO_SERVERDIR/.rstudio_job_id \
      $RSTUDIO_SERVERDIR/.rstudio_job_start \
      $RSTUDIO_SERVERDIR/.rstudio_job_duration

# make dirs to bind mount
BIND_ROOT=$HOME/.rstudio/var
mkdir -p $BIND_ROOT/run/rstudio-server 
mkdir -p $BIND_ROOT/lock/rstudio-server
mkdir -p $BIND_ROOT/log/rstudio-server 
mkdir -p $BIND_ROOT/lib/rstudio-server 

echo "TACC: job $SLURM_JOB_ID execution at: `date`"
echo "TACC: using Rstudio image $RSTUDIO_IMG"
echo "TACC: running on node $NODE_HOSTNAME"
echo "TACC: cleaning temp dir at $HOME/.rstudio"

# launch rstudio
LOCAL_PORT=8787
RSTUDIO_PASSWORD=`uuidgen`
export SINGULARITYENV_PASSWORD=$RSTUDIO_PASSWORD 

echo "TACC: starting Rstudio server in singularity:"
echo ""
echo "singularity exec -B $BIND_ROOT/run/rstudio-server:/var/run/rstudio-server \ "
echo "                 -B $BIND_ROOT/run/rstudio-server:/var/lock/rstudio-server \ "
echo "                 -B $BIND_ROOT/run/rstudio-server:/var/log/rstudio-server \ "
echo "                 -B $BIND_ROOT/run/rstudio-server:/var/lib/rstudio-server \ "
echo "                 $RSTUDIO_IMG rserver \ "
echo "                 --www-address=0.0.0.0 \ "
echo "                 --www-port=${LOCAL_PORT} \ "
echo "                 --auth-none=0 \ "
echo "                 --auth-pam-helper-path=/usr/local/bin/pam-helper >> rstudio.log 2>&1 & "
echo ""

nohup singularity exec -B $BIND_ROOT/run/rstudio-server:/var/run/rstudio-server \
                       -B $BIND_ROOT/lock/rstudio-server:/var/lock/rstudio-server \
                       -B $BIND_ROOT/log/rstudio-server:/var/log/rstudio-server \
                       -B $BIND_ROOT/lib/rstudio-server:/var/lib/rstudio-server \
                       $RSTUDIO_IMG rserver \
                       --www-address=0.0.0.0 \
                       --www-port=${LOCAL_PORT} \
                       --auth-none=0 \
                       --auth-pam-helper-path=/usr/local/bin/pam-helper >> rstudio.log 2>&1 &
RSTUDIO_PID=$!
echo "$NODE_HOSTNAME $RSTUDIO_PID" > $RSTUDIO_SERVERDIR/.rstudio_lock
sleep 20

# mapping uses node number then rack number for mapping
LOGIN_PORT=`echo $NODE_HOSTNAME | perl -ne 'print (($2.$1)+50000) if /c\d\d(\d)-\d(\d\d)/;'`

# create reverse tunnel port to login nodes (one for each login1 and login2)
for i in `seq 2`; do
    ssh -q -f -g -N -R $LOGIN_PORT:$NODE_HOSTNAME:$LOCAL_PORT login$i
done

echo "TACC: Rstudio launched at $(date)"
echo "TACC: got login node rstudio port $LOGIN_PORT"
echo "TACC: created reverse ports on Longhorn logins"
echo "TACC: Your Rstudio server is now running!"

# Warn the user when their session is about to close
TACC_RUNTIME=`squeue -l -j $SLURM_JOB_ID | grep $SLURM_QUEUE | awk '{print $7}'` # squeue returns HH:MM:SS
if [ x"$TACC_RUNTIME" == "x" ]; then
        TACC_Q_RUNTIME=`sinfo -p $SLURM_QUEUE | grep -m 1 $SLURM_QUEUE | awk '{print $3}'`
        if [ x"$TACC_Q_RUNTIME" != "x" ]; then
                TACC_RUNTIME=$TACC_Q_RUNTIME
        fi
fi

if [ "x$TACC_RUNTIME" != "x" ]; then
  # there's a runtime limit, so warn the user when the session will die
  # give 5 minute warning for runtimes > 5 minutes
        H=`echo $TACC_RUNTIME | awk -F: '{print $1}'`
        M=`echo $TACC_RUNTIME | awk -F: '{print $2}'`
        S=`echo $TACC_RUNTIME | awk -F: '{print $3}'`
        if [ "x$S" != "x" ]; then
            # full HH:MM:SS present
            H=$(($H * 3600))
            M=$(($M * 60))
            TACC_RUNTIME_SEC=$(($H + $M + $S))
        elif [ "x$M" != "x" ]; then
            # only HH:MM present, treat as MM:SS
            H=$(($H * 60))
            TACC_RUNTIME_SEC=$(($H + $M))
        else
            TACC_RUNTIME_SEC=$S
        fi
fi

# provide login instructions
echo ""
echo "Your instance is now running at http://$NODE_HOSTNAME_DOMAIN:$LOGIN_PORT"
echo "After navigating to that address in your local web browser, authenticate using"
echo "your TACC username the password '$RSTUDIO_PASSWORD'"
echo ""

# info for TACC Visualization Portal
echo "$LOGIN_PORT/?$RSTUDIO_TOKEN" > $RSTUDIO_SERVERDIR/.rstudio_port
echo "$SLURM_JOB_ID" > $RSTUDIO_SERVERDIR/.rstudio_job_id
date +%s > $RSTUDIO_SERVERDIR/.rstudio_job_start
echo "$TACC_RUNTIME_SEC" > $RSTUDIO_SERVERDIR/.rstudio_job_duration
sleep 1
echo "success" > $RSTUDIO_SERVERDIR/.rstudio_status

# spin on .rstudio_lockfile to keep job alive
while [ -f $RSTUDIO_SERVERDIR/.rstudio_lock ]; do
  sleep 10
done

# wait a brief moment so ipython can clean up after itself
sleep 1
echo "TACC: job $SLURM_JOB_ID execution finished at: `date`"

