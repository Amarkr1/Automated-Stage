addpath('.\CT400\Library 1.4.0\Win64')  
% Load library from CT400 dll
if not(libisloaded('CT400_lib'))
    [warnings, notfound] = loadlibrary('CT400_lib','CT400_lib_dpatel.h');
end

YenistaTunicsCT400(0, 1550, 1630, 10, [1 3], 20, 1, 'test', 'test');