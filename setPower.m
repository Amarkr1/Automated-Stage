function [data] = setPower(laserInputPort,wavelength,power)

powermW = 10^(power/10); % CT400 uses power in mW, convert from dBm
Instrument_Addresses; % GPIB addresses
% makedirs;

if ((wavelength >= 1260) && (wavelength <= 1360))
    % Dealing with O-band laser
    Yenista_BoardIndex = Yenista1310_BoardIndex;
    Yenista_PrimaryAddress = Yenista1310_PrimaryAddress;
    Yenista_Laser_min = 1260; 
    Yenista_Laser_max = 1360; 
else
    Yenista_Laser_min = 1500; 
    Yenista_Laser_max = 1630;  
end

%{
addpath('.\CT400\Library 1.4.0\Win64')  
% Load library from CT400 dll
if not(libisloaded('CT400_lib'))
    [warnings, notfound] = loadlibrary('CT400_lib','CT400_lib_dpatel.h');
end
%}

% Initialize
pierror = libpointer('int32Ptr', zeros(1,1));
uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);
if (uiHandle < 0)
    error('Handle could not be obtained. Please check the USB connection, windows device manger/driver, or restart the CT400.');
end

% verify connection
connectionVerify = calllib('CT400_lib', 'CT400_CheckConnected', uiHandle);
if(connectionVerify == 0)
    error('Could not connect to CT400. Please check the USB connection, windows device manger/driver, or restart the CT400.');
end
calllib('CT400_lib', 'CT400_SetLaser', uiHandle, laserInputPort, 'ENABLE', Yenista_PrimaryAddress, 'LS_TunicsT100s_HP', 1260, 1360, 10);
calllib('CT400_lib', 'CT400_CmdLaser', uiHandle, laserInputPort, 'ENABLE', wavelength,power);

% % set laser settings 
% calllib('CT400_lib', 'CT400_SetLaser', uiHandle, laserInputPort, 'ENABLE', Yenista_PrimaryAddress, 'LS_TunicsT100s_HP', Yenista_Laser_min, Yenista_Laser_max, scanMotorSpeed);
% 
% % set the laser input port to use
% calllib('CT400_lib', 'CT400_SwitchInput', uiHandle, laserInputPort);
% 
% % set resolution, power, and start and stop wavelength for scan
% calllib('CT400_lib', 'CT400_SetSamplingResolution', uiHandle, resolution);
% calllib('CT400_lib', 'CT400_SetScan', uiHandle, powermW, startWavelength, endWavelength);

% close connection
% calllib('CT400_lib', 'CT400_Close', uiHandle);
%unloadlibrary('CT400_lib');

