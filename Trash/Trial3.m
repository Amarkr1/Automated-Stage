% if count(py.sys.path,'') == 0
%     insert(py.sys.path,int32(0),'');
% end
clear classes
N = py.list({'Jones','Johnson','James'});
% N = 'Hello'
names = py.mymod.MyClass().search(N)
% N
% names2= py.mymod.theend(N)
% N
% a = py.int(2);
% b = py.int(3);
% sums = py.mymod.MyClass().sumTwo(a,b)

%modifying and reloading the module
% clear classes
% mod = py.importlib.import_module('mymod');
% py.reload(mod);
% msg = py.mymod.display() %this is the new function in the upladed module
% a = py.CorvusEcoParameters.connect('ASRL7::INSTR',2)