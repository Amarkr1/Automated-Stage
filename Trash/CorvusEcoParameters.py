#amar.kumar@mail.mcgill.ca

import wx
import sys
import CorvusEco

# Panel in the Connect Instruments window which contains the connection settings for the Corvus Eco.
#class CorvusEcoParameters(wx.Panel):
name = 'Stage: Corvus Eco'
#def __init__(self, parent, **kwargs):
#    super(CorvusEcoParameters, self).__init__(parent)
    
def connect( par1,par2):
    stage = CorvusEco.CorvusEcoClass()
    stage.connect(par1,par2)
#    print stage
#    type(stage)
    return stage

def movements(obj,dirCode,distance):
    if(dirCode==1):
        obj.moveRelative(distance);
    if(dirCode==2):
        obj.moveRelative(-distance);
                      
if __name__ == '__main__':
    param1 = str(sys.argv[1])
    param2 = int(sys.argv[2])
    code = int(sys.argv[3]) # 1- for connection and 2-for movements
    distance = float(sys.argv[4])
    
    if (code==1):
#        print 'in main'
        obj = sys.argv[5]
    else:
        print 'code is',code
        obj = (sys.argv[5])
#    print 'Values are: ',param1,' ',param2,' ',code,' ',distance,' ',obj
#    print 'code is',code
    if(code==1):
        sys.stdout.write(str(connect(param1,param2)))
    if(code==2):
        print param1,' ',param2,' ',code,' ',distance,' ',obj
        sys.stdout.write(str(movements(obj,code,distance)))