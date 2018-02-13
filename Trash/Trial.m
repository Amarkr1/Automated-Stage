% vs = visa('ni','ASRL7::INSTR')
vs = visa('agilent','ASRL7::INSTR')
out5 = instrhwinfo(vs);
vsdll = instrhwinfo(vs,'AdaptorDllName');
vs.BaudRate = 57600
fopen(vs)
vs.baud_rate = 57600
fclose(vs)
% vs.baud_rate = 57600
% visa.ResourceManager()
% connect('ASRL7::INSTR',visa.ResourceManager(),5,500,2)
%  connect(self,visaName,rm,Velocity,Acceleration,NumberOfAxis)