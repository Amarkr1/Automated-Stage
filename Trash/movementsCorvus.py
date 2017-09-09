# -*- coding: utf-8 -*-
"""
Created on Tue May 23 22:01:24 2017

@author: amar.kumar@mail.mcgill.ca
"""

import wx
import sys
import CorvusEco
import visa

name = 'Stage: Corvus Eco'

#    
#def connect( par1,par2):
#    stage = CorvusEco.CorvusEcoClass()
#    stage.connect(par1,visa.ResourceManager(),5,500,par2)
##    print stage
#    type(stage)
#    return stage

def movements(obj,dirCode,distance):
    if(dirCode==1):
        obj.moveRelative(distance);
    if(dirCode==2):
        obj.moveRelative(-distance);
                      
if __name__ == '__main__':
    obj = CorvusEco(sys.argv[1])
    dirCode = int(sys.argv[2])
    distance = float(sys.argv[3])
    print obj,' ' ,dirCode,' ',distance
    movements(obj,dirCode,distance)