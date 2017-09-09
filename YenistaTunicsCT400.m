function [data] = YenistaTunicsCT400(power, startWavelength, endWavelength, resolution, PMports, scanMotorSpeed, laserInputPort, diename, devicename)
%   David Patel [david.patel@mail.mcgill.ca], (Oscar) Yun Wang, Yannick D'Mello, Amar Kumar
%   v0: March 22, 2017
%   Example usage:

% YenistaTunicsCT400(0, 1500, 1600, 10, [1 3], 20, 1, 'test', 'test')

%   Script uses the CT400 detector with the Tunics 1000S laser. The header
%   and loadable library files (dll) for the CT400 are expected to be in
%   the .\CT400\Library 1.4.0\Win64 directory. The laser should be
%   connected via GPIB and the CT400 via USB. No BNC trigger connections
%   are necesary. Please use my header file, not the one provided by
%   Yenista. Do NOT unload library. If you do, you will have to restart
%   MATLAB to get CT400 to work again. You MUST load library before
%   launching this function. Use 

% Parameters
%   power: laser power in dBm. NOTE: CT400 MAX POWER IS 7 dBm!!!
%   startWavelength: Starting wavelength in nm, in resolution of 1 pm
%   endWavelength: Ending wavelength in nm, in resolution of 1 pm
%   resolution: resolution in pm. Note: resolution will decrease to
%   accomodate for limitation in number of samples
%   PMports: channels to be measured on power meter (CT400)
%   scanMotorSpeed: laser scanning motor speed in nm/s
    % Yenista motor speed options are [nm,/s]:
    % [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 20, 22,
    % 25, 29, 33, 40, 50, 67, 100]
%   laserInputPort: input port of the CT400 to use for scanning
%   diename: folder
%   devicename: filename prefix

maxPoints = 250000; % maximum points that can be scanned, for buffer size
powermW = 10^(power/10); % CT400 uses power in mW, convert from dBm
Instrument_Addresses; % GPIB addresses
makedirs;

if ((startWavelength >= 1260) && (endWavelength <= 1360))
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

% set laser settings 
calllib('CT400_lib', 'CT400_SetLaser', uiHandle, laserInputPort, 'ENABLE', Yenista_PrimaryAddress, 'LS_TunicsT100s_HP', Yenista_Laser_min, Yenista_Laser_max, scanMotorSpeed);

% set the laser input port to use
calllib('CT400_lib', 'CT400_SwitchInput', uiHandle, laserInputPort);

% set resolution, power, and start and stop wavelength for scan
calllib('CT400_lib', 'CT400_SetSamplingResolution', uiHandle, resolution);
calllib('CT400_lib', 'CT400_SetScan', uiHandle, powermW, startWavelength, endWavelength);

% set which ports of the power meter to measure
% remove any detector parameter that is > 4
PMports = PMports(PMports < 5);
% first detector is always on, cannot turn it off, remove i
detectorsTemp = PMports(PMports > 1);
detectorsTemp = detectorsTemp - 1;
% build the command
detArray = {'DISABLE' 'DISABLE' 'DISABLE' 'DISABLE'};
detArray(detectorsTemp) = {'ENABLE'};
detArraystr = ['''' detArray{1} ''', ' '''' detArray{2} ''', ' '''' detArray{3} ''', ' '''' detArray{4} ''''];
command = sprintf('calllib(''CT400_lib'', ''CT400_SetDetectorArray'', uiHandle, %s);', detArraystr);
eval(command);

% make sure external triggering is  set to off
calllib('CT400_lib', 'CT400_SetExternalSynchronizationIN', uiHandle, 'DISABLE');

%Action!
calllib('CT400_lib', 'CT400_ScanStart', uiHandle);

% Wait till scan is done and collet errors, if any
perrorMsg = libpointer('int8Ptr', zeros(1024,1));
errorInd = calllib('CT400_lib', 'CT400_ScanWaitEnd', uiHandle, perrorMsg);
% if(errorInd ~= 0)
%     error('%s', perrorMsg.value)
% end

% get the number of points scanned and the wavelenght
pWavelength = libpointer('doublePtr', zeros(maxPoints, 1));
PointsNumber = calllib('CT400_lib', 'CT400_ScanGetWavelengthSyncArray', uiHandle, pWavelength, maxPoints);

data = zeros(PointsNumber, length(PMports) + 1);
data(:,1) = pWavelength.value(1:PointsNumber);

% get the data from each powere meter
for k=1:length(PMports)
    pdata = libpointer('doublePtr', zeros(maxPoints, 1));
    PointsNumberData = calllib('CT400_lib', 'CT400_ScanGetDetectorArray', uiHandle, PMports(k), pdata, maxPoints);
    data(:, k+1) = pdata.value(1:PointsNumberData);
end

% Plot the data
% figure; hold all;
% ylabel('Measured power [dBm]'); xlabel('Wavelength [nm]');
% title({['Transmission Spectrum - ' devicename]; datestr(now,0)});
% grid on;
% GraphLegend = cell(length(PMports), 1);
% set(gca, 'LineStyleOrder', '-|--|:|-.');
% for k = 1:length(PMports)
%     plot(data(:, 1), data(:, k+1));
%     GraphLegend{k} = sprintf('Output %d', PMports(k)); 
% end
% legend(GraphLegend);

% Plot and save figures with data and time
filename = [devicename '_power_' num2str(power)];
% savedata;

% close connection
calllib('CT400_lib', 'CT400_Close', uiHandle);
%unloadlibrary('CT400_lib');

%{
% For debugging
pPout = libpointer('doublePtr', zeros(1, 1));
pP1 = libpointer('doublePtr', zeros(1, 1));
pP2 = libpointer('doublePtr', zeros(1, 1));
pP3 = libpointer('doublePtr', zeros(1, 1));
pP4 = libpointer('doublePtr', zeros(1, 1));
pVext = libpointer('doublePtr', zeros(1, 1));

while(1)
calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, pPout, pP1, pP2, pP3, pP4, pVext);
fprintf('Pout: %2.2f, P1: %2.2f, P2: %2.2f, P3: %2.2f, P4: %2.2f\n', pPout.Value, pP1.Value, pP2.Value, pP3.Value, pP4.Value);
pause(0.1)
end
%}

