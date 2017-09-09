#amar.kumar@mail.mcgill.ca

import wx
import sys
import CorvusEco
import visa

# Panel in the Connect Instruments window which contains the connection settings for the Corvus Eco.
#class CorvusEcoParameters(wx.Panel):
name = 'Stage: Corvus Eco'
#def __init__(self, parent, **kwargs):
#    super(CorvusEcoParameters, self).__init__(parent)
    
def connect( par1,par2):
    stage = CorvusEco.CorvusEcoClass()
    stage.connect(par1,visa.ResourceManager(),5,500,par2)
    stage.moveRelative(-1000.0);
#    def disconnect(self, event):
#        self.stage.disconnect()
#        if self.stage in self.connectPanel.instList:
#            self.connectPanel.instList.remove(self.stage)
#        self.disconnectBtn.Disable()
#        self.connectBtn.Enable()        
if __name__ == '__main__':
    param1 = str(sys.argv[1])
    param2 = int(sys.argv[2])
    print param1,' ',param2
#    type(sys.argv[1])
#    try:
#        print sys.argv[2]
#        param2 = int(sys.argv[2])
#        
#    except ValueError:
#        pass
#    sys.stdout.write(connect(param1,param2))
    connect(param1,param2)