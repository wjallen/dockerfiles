#!/usr/bin/env python3
from random import random as r

def main():
    num_inside = 0
    num_tries = 100000000

    for i in range(num_tries):
        if (((r()**2)+(r()**2)) < 1):
            num_inside += 1

    print ('the pi estimate after %d points is %f' % (num_tries, 4.0*num_inside/num_tries))

if __name__ == '__main__':
    main()
