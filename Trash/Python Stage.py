# -*- coding: utf-8 -*-
"""
Created on Wed May 17 01:11:07 2017

@author: plantgroup
"""

import visa
rm = visa.ResourceManager()
visaName = 'ASRL7::INSTR'
a = rm.get_instrument(visaName)
a.baud_rate = 57600 # Sets baudrate
a.write('identify') #Asks for identification
print(a.read()+ ' [Model Name][Hardware Ver][Software Ver][Internal Use][Dip-Switch]')
print('Connected\n')
a.write('1 2 setaxis')
#velocity = 
#acceleration = 
#a.write(str(velocity)+' sv') #set velocity
#a.write('gv') #Get Velocity
#response = a.read()
#print('Velocity set to: '+response+' [units]/s\n')
#a.write(str(Acceleration)+' sa') #Set Acceleration
#a.write('ga')#Get Acceleration
#response = self.ser.read()
#print('Acceleration set to: '+response+' [units]/s^2\n')


a.close()
print('Connection closed\n')