FROM redis:6

COPY redis.conf /etc/redis.conf
RUN chmod go+rx /etc/redis.conf

ENTRYPOINT ["redis-server"]
CMD ["/etc/redis.conf"]
