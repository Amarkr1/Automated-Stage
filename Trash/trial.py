# -*- coding: utf-8 -*-
"""
Created on Thu May 18 02:10:11 2017

@author: plantgroup
"""

import sys
import visa
def squared(a,omtrek):
    b = (omtrek/2)+a
    return b
def sum(a):
    print 'here'
    return a+6

if __name__ == '__main__':
    x = float(sys.argv[1])
    y = float(sys.argv[2])
    sys.stdout.write(str(squared(x,y)))
    sys.stdout.write('\n')
    sys.stdout.write(str(sum(x)))
    sys.stdout.write('\n')