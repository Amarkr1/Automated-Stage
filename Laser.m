function varargout = Laser(varargin)
% AMAR [amar.kumar@mail.mcgill.ca]
% Yannick.DMello@mail.McGill.ca
% Test path: C:\Users\plantgroup\Desktop\ANT_06-12\ANT_2017_06_12_Group_MergedLayout_Yannick.txt
% Save path: C:\Users\plantgroup\Desktop\Yannick\Measurements\meas_20170912
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Laser_OpeningFcn, ...
                   'gui_OutputFcn',  @Laser_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
guipath = fileparts(mfilename('fullpath'));
addpath(genpath(guipath)); cd(guipath);
% End initialization code - DO NOT EDIT


% --- Executes just before Laser is made visible.
function Laser_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Laser (see VARARGIN)

% Choose default command line output for Laser
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Laser wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Laser_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in laserSlot.
function laserSlot_Callback(hObject, eventdata, handles)
% hObject    handle to laserSlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns laserSlot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from laserSlot


% --- Executes during object creation, after setting all properties.
function laserSlot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to laserSlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in offLaser.
function offLaser_Callback(hObject, eventdata, handles)
% hObject    handle to offLaser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Laser.
function Laser_Callback(hObject, eventdata, handles)
% hObject    handle to Laser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pierror; global uiHandle;
if get(handles.Laser,'Value'), 
    set(handles.Laser,'String','OFF');
%     pierror = libpointer('int32Ptr', zeros(1,1));
    uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);
else set(handles.Laser,'String','ON');
%     pierror = libpointer('int32Ptr', zeros(1,1));
    uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);
    offLaser;
    calllib('CT400_lib', 'CT400_Close', uiHandle);
end




function powerVal_Callback(hObject, eventdata, handles)
% hObject    handle to powerVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of powerVal as text
%        str2double(get(hObject,'String')) returns contents of powerVal as a double


% --- Executes during object creation, after setting all properties.
function powerVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to powerVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wavelengthVal_Callback(hObject, eventdata, handles)
% hObject    handle to wavelengthVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wavelengthVal as text
%        str2double(get(hObject,'String')) returns contents of wavelengthVal as a double


% --- Executes during object creation, after setting all properties.
function wavelengthVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wavelengthVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in setPower.
function setPower_Callback(hObject, eventdata, handles)
% hObject    handle to setPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pierror; global uiHandle;

pierror = libpointer('int32Ptr', zeros(1,1));
uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);
%flushing out the memory
calllib('CT400_lib', 'CT400_Close', uiHandle);

%creating new handles
% pierror = libpointer('int32Ptr', zeros(1,1));
uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);

contents = cellstr(get(handles.laserSlot,'String'));
choice = contents{get(handles.laserSlot,'Value')};
inputPort = str2num(choice);
power = str2num(get(handles.powerVal,'String'));
wavelength = str2num(get(handles.wavelengthVal,'String'));
if(wavelength<=1400)
    calllib('CT400_lib', 'CT400_SetLaser', uiHandle, inputPort, 'ENABLE', 10, 'LS_TunicsT100s_HP', 1260, 1360, 10);
    calllib('CT400_lib', 'CT400_CmdLaser', uiHandle, inputPort, 'ENABLE', wavelength,power);
    set(handles.startWave,'String',1260);
    set(handles.stopWave,'String',1360);
    
else
    
    calllib('CT400_lib', 'CT400_SetLaser', uiHandle, inputPort, 'ENABLE', 01, 'LS_TunicsT100s_HP', 1500, 1630, 10);
    calllib('CT400_lib', 'CT400_CmdLaser', uiHandle, inputPort, 'ENABLE', wavelength,power);
    set(handles.startWave,'String',1500);
    set(handles.stopWave,'String',1600);
    
end

% --- Executes on button press in setWavelength.
function setWavelength_Callback(hObject, eventdata, handles)
% hObject    handle to setWavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in loadLib.
function loadLib_Callback(hObject, eventdata, handles)
% hObject    handle to loadLib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
YenistaTunicsCT400Launcher;



function axis1_Callback(hObject, eventdata, handles)
% hObject    handle to axis1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of axis1 as text
%        str2double(get(hObject,'String')) returns contents of axis1 as a double


% --- Executes during object creation, after setting all properties.
function axis1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axis1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function axis2_Callback(hObject, eventdata, handles)
% hObject    handle to axis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of axis2 as text
%        str2double(get(hObject,'String')) returns contents of axis2 as a double


% --- Executes during object creation, after setting all properties.
function axis2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function startWave_Callback(hObject, eventdata, handles)
% hObject    handle to startWave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startWave as text
%        str2double(get(hObject,'String')) returns contents of startWave as a double


% --- Executes during object creation, after setting all properties.
function startWave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startWave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stopWave_Callback(hObject, eventdata, handles)
% hObject    handle to stopWave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stopWave as text
%        str2double(get(hObject,'String')) returns contents of stopWave as a double


% --- Executes during object creation, after setting all properties.
function stopWave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stopWave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function resolution_Callback(hObject, eventdata, handles)
% hObject    handle to resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of resolution as text
%        str2double(get(hObject,'String')) returns contents of resolution as a double


% --- Executes during object creation, after setting all properties.
function resolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sweepButton.
function sweepButton_Callback(hObject, eventdata, handles)
% hObject    handle to sweepButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
performSweep(handles)
setPower_Callback(hObject, eventdata, handles);
guidata(hObject,handles);


function performSweep(handles)
contents = cellstr(get(handles.laserSlot,'String'));
choice = contents{get(handles.laserSlot,'Value')};
input = str2num(choice);
power = str2num(get(handles.sweepPower,'String'));
startWavelength = str2num(get(handles.startWave,'String'));
stopWavelength = str2num(get(handles.stopWave,'String'));
resol = str2num(get(handles.resolution,'String'));
% set(handles.wavelengthVal,'String',stopWavelength);
contents2 = cellstr(get(handles.sweepSpeed,'String'));
choice2 = contents2{get(handles.sweepSpeed,'Value')};
sweepSpeed = str2num(choice2);
sweepData = YenistaTunicsCT400(power, startWavelength, stopWavelength, resol, [1 2 3 4], sweepSpeed, input, 'test', 'test');

save('sweepingData.mat','sweepData');
axes(handles.axes1);


xlabel('Wavelength (nm)');
ylabel('Power');
val1 = get(handles.detec1,'Value');
val2 = get(handles.detec2,'Value');
val3 = get(handles.detec3,'Value');
val4 = get(handles.detec4,'Value');
if(get(handles.overplot,'Value')==1)
    hold on;
else
    hold off;
end
if(val1==1)
    plot(sweepData(:,1),sweepData(:,2));
    hold on;
end

if(val2==1)
    plot(sweepData(:,1),sweepData(:,3));
    hold on;
end

if(val3==1)
    plot(sweepData(:,1),sweepData(:,4));
    hold on;
end

if(val4==1)
    plot(sweepData(:,1),sweepData(:,5));
    hold on;
end






function sweepPower_Callback(hObject, eventdata, handles)
% hObject    handle to sweepPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweepPower as text
%        str2double(get(hObject,'String')) returns contents of sweepPower as a double


% --- Executes during object creation, after setting all properties.
function sweepPower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweepPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sweepSpeed.
function sweepSpeed_Callback(hObject, eventdata, handles)
% hObject    handle to sweepSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sweepSpeed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sweepSpeed


% --- Executes during object creation, after setting all properties.
function sweepSpeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweepSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


 
function d2_Callback(hObject, eventdata, handles)
% hObject    handle to d2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d2 as text
%        str2double(get(hObject,'String')) returns contents of d2 as a double


% --- Executes during object creation, after setting all properties.
function d2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d3_Callback(hObject, eventdata, handles)
% hObject    handle to d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d3 as text
%        str2double(get(hObject,'String')) returns contents of d3 as a double


% --- Executes during object creation, after setting all properties.
function d3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d1_Callback(hObject, eventdata, handles)
% hObject    handle to d1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d1 as text
%        str2double(get(hObject,'String')) returns contents of d1 as a double


% --- Executes during object creation, after setting all properties.
function d1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d4_Callback(hObject, eventdata, handles)
% hObject    handle to d4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d4 as text
%        str2double(get(hObject,'String')) returns contents of d4 as a double


% --- Executes during object creation, after setting all properties.
function d4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in powerMeter.
function powerMeter_Callback(hObject, eventdata, handles)
% hObject    handle to powerMeter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pierror; global uiHandle;
if get(handles.powerMeter,'Value'), set(handles.powerMeter,'String','OFF');set(handles.detector_checkConnected,'backgroundcolor','g'); % g is reserved for green color
else set(handles.powerMeter,'String','ON'); calllib('CT400_lib', 'CT400_Close', uiHandle);set(handles.detector_checkConnected,'backgroundcolor','r');
end



while get(handles.powerMeter,'Value')
    % pierror = libpointer('int32Ptr', zeros(1,1));
    uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);
    pPout = libpointer('doublePtr', zeros(1, 1));
    pP1 = libpointer('doublePtr', zeros(1, 1));
    pP2 = libpointer('doublePtr', zeros(1, 1));
    pP3 = libpointer('doublePtr', zeros(1, 1));
    pP4 = libpointer('doublePtr', zeros(1, 1));
    pVext = libpointer('doublePtr', zeros(1, 1));
    calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, pPout, pP1, pP2, pP3, pP4, pVext);
    set(handles.d1,'String',num2str(pP1.Value));
    set(handles.d2,'String',num2str(pP2.Value));
    set(handles.d3,'String',num2str(pP3.Value));
    set(handles.d4,'String',num2str(pP4.Value));
    set(handles.outputPower,'String',num2str(pPout.Value));
    pause(0.1)
end

% --- Executes on button press in pauseMeasuring.
function pauseMeasuring_Callback(hObject, eventdata, handles)
% hObject    handle to pauseMeasuring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pauseMeasuring



function outputPower_Callback(hObject, eventdata, handles)
% hObject    handle to outputPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outputPower as text
%        str2double(get(hObject,'String')) returns contents of outputPower as a double


% --- Executes during object creation, after setting all properties.
function outputPower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outputPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function axis3_Callback(hObject, eventdata, handles)
% hObject    handle to axis3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of axis3 as text
%        str2double(get(hObject,'String')) returns contents of axis3 as a double


% --- Executes during object creation, after setting all properties.
function axis3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axis3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in axis1Minus.
function axis1Minus_Callback(hObject, eventdata, handles)
if(handles.stage.Connected==1)
    handles.stage.move_x(-1*str2num(get(handles.axis1,'String')));
end
guidata(hObject,handles)

% --- Executes on button press in axis1Plus.
function axis1Plus_Callback(hObject, eventdata, handles)
if(handles.stage.Connected==1)
    handles.stage.move_x(str2num(get(handles.axis1,'String')));
end
guidata(hObject,handles)

% --- Executes on button press in axis2Minus.
function axis2Minus_Callback(hObject, eventdata, handles)
if(handles.stage.Connected==1)
    handles.stage.move_y(-1*str2num(get(handles.axis2,'String')));
end
guidata(hObject,handles)

% --- Executes on button press in axis2Plus.
function axis2Plus_Callback(hObject, eventdata, handles)
if(handles.stage.Connected==1)
    handles.stage.move_y(str2num(get(handles.axis2,'String')));
end
guidata(hObject,handles)

% --- Executes on button press in axis3Minus.
function axis3Minus_Callback(hObject, eventdata, handles)
if(handles.stage.Connected==1)
    handles.stage.move_z(-1*str2num(get(handles.axis3,'String')));
end
guidata(hObject,handles)


% --- Executes on button press in axis3Plus.
function axis3Plus_Callback(hObject, eventdata, handles)
if(handles.stage.Connected==1)
    handles.stage.move_z(str2num(get(handles.axis3,'String')));
end
guidata(hObject,handles)

% --- Executes on button press in StageCorvus.
function StageCorvus_Callback(hObject, eventdata, handles)
% hObject    handle to StageCorvus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.StageCorvus,'Value'), 
    set(handles.StageCorvus,'String','OFF');
    handles.stage = CorvusEco;
    handles.stage.Param.COMPort = str2num(get(handles.address,'String'));
    handles.stage.connect();
    set(handles.stage_checkConnected,'backgroundcolor','g'); % g is reserved for green color
    guidata(hObject,handles)
else
    set(handles.StageCorvus,'String','ON');
    set(handles.stage_checkConnected,'backgroundcolor','r'); % r is reserved for red color
    handles.stage.disconnect();
end

% --- Executes on button press in fineAlign.
function fineAlign_Callback(hObject, eventdata, handles)
% hObject    handle to fineAlign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('parFineAlign.mat');
set(handles.wavelengthVal,'String',param_align.wavelength);
optimize_alignment(handles);
% Align(handles) 
guidata(hObject,handles)

function optimize_alignment(handles)
warning('off','all');
global pierror; global uiHandle;
uiHandle = calllib('CT400_lib', 'CT400_Init', libpointer('int32Ptr', zeros(1,1)));
det.pPout = libpointer('doublePtr', zeros(1, 1));
det.pP1 = libpointer('doublePtr', zeros(1, 1));
det.pP2 = libpointer('doublePtr', zeros(1, 1));
det.pP3 = libpointer('doublePtr', zeros(1, 1));
det.pP4 = libpointer('doublePtr', zeros(1, 1));
det.pVext = libpointer('doublePtr', zeros(1, 1));
load('parFineAlign.mat');
if(param_align.wavelength>=1500)
    calllib('CT400_lib', 'CT400_SetLaser', uiHandle, 1, 'ENABLE', 01, 'LS_TunicsT100s_HP', 1500, 1630, 10);
    calllib('CT400_lib', 'CT400_CmdLaser', uiHandle, 1, 'ENABLE', param_align.wavelength,param_align.power);
else
    calllib('CT400_lib', 'CT400_SetLaser', uiHandle, 1, 'ENABLE', 10, 'LS_TunicsT100s_HP', 1260, 1360, 10);
    calllib('CT400_lib', 'CT400_CmdLaser', uiHandle, 1, 'ENABLE', param_align.wavelength,param_align.power);
end

IL_opt = measure_det_FA(handles,uiHandle,param_align,det); 
[ori_x, ori_y, ~] = handles.stage.getPosition();
N = ceil(param_align.window/param_align.step+1);
step = param_align.window/N;
waitbar_handle = waitbar(0.1,'Fine Align');
waitbar(0.1, waitbar_handle,'Fine Align: Coarse Alignment');
dim_now = 'x'; inc = 0; IL_opt_old = -70;
while inc<3 || ( (IL_opt-IL_opt_old)>.2 && inc<10 ) % either less than 3 iterations, or [ less than 10 and inconsistent values]
    IL_opt_old = IL_opt;   
    
    % Initialize
    [x_now, y_now, ~] = handles.stage.getPosition(); inc = inc+1;
    if dim_now == 'x', 
        dim_now = 'y'; pos0 = ori_y; pos_now = y_now;
    else dim_now = 'x'; pos0 = ori_x; pos_now = x_now;
    end
    poss = linspace(pos0-param_align.window/2,pos0+param_align.window/2,N);
    eval(['handles.stage.move_',dim_now,'(',num2str( pos0-param_align.window/2-pos_now-2 ),');']); % move to start of window in this dimension
    % Sweep
    for i_pos = 1:N
        eval(['handles.stage.move_',dim_now,'(',num2str(step),');']);
        ILs(i_pos) = measure_det_FA(handles,uiHandle,param_align,det);
    end
    p = polyfit(poss,ILs,2); % figure; plot(poss,[ILs;polyval(p,poss)]);
    pos_opt = fminbnd(@(pos) -polyval(p,pos),pos0-param_align.window/2,pos0+param_align.window/2,optimset('Display','off'));
    eval(['handles.stage.move_',dim_now,'(',num2str(pos_opt-(pos0+param_align.window/2)),');']);
    IL_opt = max([IL_opt_old,measure_det_FA(handles,uiHandle,param_align,det)]);
end

% % two 1D interpolations don't seem to work
% [init_x, init_y, ~] = handles.stage.getPosition();
% % y_opt goes first because it's easier to optimize in y (wider gaussian)
% y_opt = fminbnd(@(y) objf_alignment(handles,uiHandle,param_align,det,y,'y'),init_y-param_align.window/2,init_y+param_align.window/2,optimset('MaxFunEvals',10,'TolX',.2));
% [init_x, init_y, ~] = handles.stage.getPosition(); handles.stage.move_y(y_opt-init_y);
% % set y, optimize x
% x_opt = fminbnd(@(x) objf_alignment(handles,uiHandle,param_align,det,x,'x'),init_x-param_align.window/2,init_x+param_align.window/2,optimset('MaxFunEvals',25,'TolX',.2));
% [init_x, init_y, ~] = handles.stage.getPosition(); handles.stage.move_x(x_opt-init_x);
% % verify y if necessary
% y_opt = fminbnd(@(y) objf_alignment(handles,uiHandle,param_align,det,y,'y'),init_y-param_align.window/2,init_y+param_align.window/2,optimset('MaxFunEvals',25,'TolX',.2));
% [init_x, init_y, ~] = handles.stage.getPosition(); handles.stage.move_y(y_opt-init_y);

warning('on','all');

num_of_iterations=40;
[init_x, init_y, ~] = handles.stage.getPosition();


%Read fine align parameters
delta_x = param_align.window;
dx=param_align.step;  %step size is 1um
dy=param_align.step;
th = param_align.threshold;
detectorNum = str2double(param_align.det_main);
pwr = [];
DEBUG = 0;
peakflag = 0;  %set to 1 if found peak (max output)
calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
ILs = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
if(isnan(detectorNum))
    [pwr detectorNum] = max(ILs);
else
    pwr  = ILs(detectorNum);
end
triedAltDetector = 0;

calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value]
pwr=powers(detectorNum)
if(pwr < th)
    [curr_x, curr_y, init_z] = handles.stage.getPosition();
    handles.stage.move_y((ori_y-curr_y));
    handles.stage.move_x((ori_x-curr_x));
end
% %Alternate alignment code for getting less than GC
% N=ceil(delta_x/dx);
% X = N;
% Y = N;
% x = 0;
% y = 0;
% dx = 0;
% dy = -dy;
% powerMatrix = zeros(N*N,8);
% index = 1;
% 
% prev_x = 0;
% prev_y = 0;
% for i = 1:max(X, Y)^2
%     if (-X/2 < x <= X/2) && (-Y/2 < y <= Y/2)
% %         fprintf(fileID,'%f %f\n',x,y); 
%         moveX = x - prev_x;
%         moveY = y - prev_y;
%         %moving the stage
%         handles.stage.move_x(moveX);
%         handles.stage.move_y(moveY);
%         calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
%         powerMatrix(index,1) = x;
%         powerMatrix(index,2) = y;
%         powerMatrix(index,3) = moveX;
%         powerMatrix(index,4) = moveY;
%         powerMatrix(index,5) = det.pP1.Value;
%         powerMatrix(index,6) = det.pP2.Value;
%         powerMatrix(index,7) = det.pP3.Value;
%         powerMatrix(index,8) = det.pP4.Value; 
%     end
%     if (x == y) || (x < 0 && x == -y) || (x > 0 && x == 2-y)
%         temp = dx;
%         dx = -dy;
%         dy = temp;
%     end
%     prev_x = x;
%     prev_y = y;
%     x = x+dx;
%     y = y+dy;
%     waitbar(0.2 + index/(N*N), waitbar_handle,'Fine Align: Meshing');
%     index = index+1;
% end
% 
% % fclose(fileID);
% save('PositionpowerMatrix.mat','powerMatrix');
% load('PositionpowerMatrix.mat');
% powerDetector1 = detectorNum + 4;
% [M,I]=max(powerMatrix(:,powerDetector1))
%%Alternate code ends

if pwr < th && ~triedAltDetector 
    %not on GC or wrong detector or wrong wavelength
    %DEBUG: could add algorithm to change detector and try again , or
    %chagne wavelength and try again.
    %     disp('currently not on GC; or wrong detector: searching... ');
    
   
    best_detector = 1;
    best_power = pwr;
    %do a spiral 
    for det_num = 1:4
    detectorNum = det_num;
    kk=1;
    N=ceil(delta_x/dx);  %this determins the window size
    [init_x, init_y, ~] = handles.stage.getPosition();
        while (pwr<=th && kk<N)
            flag_found = 0;
        
            %main loop for spiral
            if ~triedAltDetector 
                waitbar(0.2+(0.7*kk/N), waitbar_handle,['Fine Align: searching on detector ' num2str(detectorNum)]);
            else
                waitbar(0.2+(0.7*kk/N), waitbar_handle,'Fine Align: Alt detector searching ...');
            end
            if mod(kk,2) %back and forth scanning along a single axis
                s = 1;
            else
                s =-1;
            end




            %UBC code : this can be avoided since we get all the powers from  4 detectors at once
            for ll=1:1:kk
                handles.stage.move_x(s*dx);
                calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
                powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
                pwr=powers(detectorNum);
                if pwr>th
                    pwr
                    disp('Threshold found in x');
                    flag_found = 1;
                    break;
                end
            end
            for ll=1:1:kk
                handles.stage.move_y(s*dy);
                calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
                powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
                pwr=powers(detectorNum);
                if pwr>th
                    pwr
                    disp('Threshold found in y');
                    flag_found = 1;
                    break;
                end
            end
          %UBC code ends
         kk=kk+1;
        if(flag_found)
            break;
        end
        
        
        
    %         triedAltDetector=1;  % temp fix to shut off alt detector for align
    %         
    %         % try alternate detector (if enabled)
    %         if kk==N && ~triedAltDetector
    %             detectorNum=1;
    %             triedAltDetector = 1; % set flag
    %             if detectorNum > 0 % if AltDetector feature is enabled
    %                 disp('Fine Align: No GC found: Switch to alternative detector');
    %                 [curr_x, curr_y, init_z] = handles.stage.getPosition();
    %                 handles.stage.move_y((init_y-curr_y));   %check for the correct signs
    %                 handles.stage.move_x((init_x-curr_x));
    %                 kk=1;
    %             end
    %         end
        end
        if(pwr>best_power)
            best_detector = det_num;
            
        end
        if(flag_found)
            break;
        end
        %return back to the initial position
        [curr_x, curr_y, ~] = handles.stage.getPosition();
        handles.stage.move_y((ori_y-curr_y));
        handles.stage.move_x((ori_x-curr_x));
        
        
    end
    detectorNum = best_detector;
%     if kk==N 
%         disp(['Fine Align: No GC found for detector ' num2str(detectorNum) ': moving to init position']);
%         [curr_x, curr_y, init_z] = handles.stage.getPosition();
%         handles.stage.move_y((init_y-curr_y));
%         handles.stage.move_x((init_x-curr_x));
%         h= waitbar(1, waitbar_handle,'Fine Align: No GC FOUND !');
% 
% %         delete(h);
%     else
%         %disp('found GC...');
%         disp('Fine align: GC detected'); 
%         
%     end
    
end
pwr_coraseAlign = pwr;
[coraseAlign_posx coraseAlign_posy ~] = handles.stage.getPosition();
%step 2 of fine alignment, once an optimized position is found we go for
%gradient search 
if pwr > th;
    %sitting on GC

    pwr = -100*ones(2*num_of_iterations+2);
    ii=num_of_iterations+1;
    jj=num_of_iterations+1;
    for pp=-1:1:1  %reading power of neighboring points
        for qq=-1:1:1
            handles.stage.move_y(dy); pause(0.1); %make sure the measurement is finished.
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii+pp,jj+qq)=powers(detectorNum);
        end
        handles.stage.move_y(-3*dy); pause(0.1); %make sure the measurement is finished.
        handles.stage.move_x(dx); pause(0.1); %make sure the measurement is finished.
    end
    handles.stage.move_y(dy); pause(0.1); %make sure the measurement is finished.
    handles.stage.move_x(-2*dx); pause(0.1); %make sure the measurement is finished.
    uu=0;
    
%     disp('Debug gradient');
%     disp('pwr: ');
%     pwr(ii-1:1:ii+1,jj-1:1:jj+1)
    
    while (uu < num_of_iterations)
        waitbar(0.2+(0.7*uu/num_of_iterations), waitbar_handle,'Fine Align: Gradient method');
        if DEBUG
            disp(['iteration: ' num2str(uu)]);
            disp(['power: ' num2str(pwr(ii,jj))]);
            pwr(ii-1:1:ii+1,jj-1:1:jj+1)
        end
        %now decide what to do
        if (pwr(ii,jj) > pwr(ii-1,jj)) && (pwr(ii,jj) > pwr(ii+1,jj)) && (pwr(ii,jj) > pwr(ii,jj-1)) && (pwr(ii,jj) > pwr(ii,jj+1))
            %disp('found max');
            peakflag = peakflag+1;
            if peakflag==2 %set to 2 since there are sometimes false positives due to fibrations
                break; %peak is reached
            else
                %need to get power again
                calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
                powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
                pwr(ii,jj)=powers(detectorNum);
                
                handles.stage.move_x(dx);
                calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
                powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
                pwr(ii+1,jj)=powers(detectorNum);
                
                handles.stage.move_x(-2*dx);
                calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
                powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
                pwr(ii-1,jj)=powers(detectorNum);
                
                handles.stage.move_x(dx);
                handles.stage.move_y(-dy);
                calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
                powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
                pwr(ii,jj-1)=powers(detectorNum);
                
                handles.stage.move_y(2*dy);
                calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
                powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
                pwr(ii,jj+1)=powers(detectorNum);
                
                handles.stage.move_y(-dy);
            end
        elseif pwr(ii,jj)>pwr(ii,jj-1) && pwr(ii,jj)>pwr(ii,jj+1)  %max in y-direction (jj)
            %only move one direction
            %disp('max in y-direction');
            d=sign(pwr(ii+1,jj)-pwr(ii-1,jj));
            handles.stage.move_x(d*2*dx);
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii+d*2,jj)=powers(detectorNum);
            
            handles.stage.move_x(-1*d*dx);
            handles.stage.move_y(-dy);
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii+d,jj-1)=powers(detectorNum);
            
            handles.stage.move_y(dy);
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii+d,jj)=powers(detectorNum);
            
            handles.stage.move_y(dy);
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii+d,jj+1)=powers(detectorNum);
            handles.stage.move_y(-dy);
            ii=ii+d;
        elseif pwr(ii,jj)>pwr(ii-1,jj) && pwr(ii,jj)>pwr(ii+1,jj)
            %only move one direction
            %disp('max in x-direction');
            d=sign(pwr(ii,jj+1)-pwr(ii,jj-1));
            handles.stage.move_y(d*2*dy);
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii,jj+d*2)=powers(detectorNum);
            
            handles.stage.move_y(-1*d*dy);
            handles.stage.move_x(-1*dx);
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii-1,jj+d*1)=powers(detectorNum);
            
            handles.stage.move_x(dx);
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii,jj+d*1)=powers(detectorNum);
            
            handles.stage.move_x(dx);
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii+1,jj+d*1)=powers(detectorNum);
            
            handles.stage.move_x(-dx);
            jj=jj+d;
        else %on a slop with no maximums
            %disp('no max');
            d1=sign(pwr(ii+1,jj)-pwr(ii-1,jj));
            d2=sign(pwr(ii,jj+1)-pwr(ii,jj-1));
            handles.stage.move_y(d2*dy);
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii,jj+d2)=powers(detectorNum);
            
            handles.stage.move_x(d1*dx);
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii+d1,jj+d2)=powers(detectorNum);
            
            handles.stage.move_x(d1*dx);
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii+2*d1,jj+d2)=powers(detectorNum);
            
            handles.stage.move_y(d2*dy);
            handles.stage.move_x(-d1*dx);
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii+d1,jj+2*d2)=powers(detectorNum);
            
            handles.stage.move_y(-d2*dy);
            handles.stage.move_y(-d2*dy);
            calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
            powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
            pwr(ii+d1,jj)=powers(detectorNum);
            
            handles.stage.move_y(d2*dy);
            ii=ii+d1; jj=jj+d2;
        end
        uu=uu+1;
    end
%     peakflag=2; %overwriting the peak flag case
    if peakflag==2 %set to 2 since there are sometimes false positives due to vibrations
        %Do cross hair fine aling: same as old on: now it is on GC for
        %sure.
        waitbar(0.9, waitbar_handle,'Fine Align: Crosshair method');
        pwr = [];
%         disp('Fine align: Crosshair method');
        
        Nx=26;
        Ny=26;
        dy = 1;
        dx = 1;
        try
            handles.stage.move_y(-dy*ceil(Ny/2)); %go to start position
        [x, y, z] = handles.stage.getPosition();
        catch ME
            rethrow(ME);
        end
        pause(0.2);
        for ii=1:1:Ny
            try
                calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
                powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
                pwr(ii) = powers(detectorNum);
            catch ME
                rethrow(ME);
            end
            pause(0.5)
            handles.stage.move_y(dy);
         
            pause(0.5);
        end
        
        [pmax, pind] = max(pwr);
        handles.stage.move_y(-(Ny-pind(1)+1)*dy);
        if DEBUG
            disp(strcat('max power (moving in y): ',num2str(pmax),' at index: ',num2str(pind)));
            figure; hold on
            plot(pwr);
            plot(pind,pmax, '-xr');
            hold off
        end
        pwr=[];
        
        try
            handles.stage.move_x(-dx*ceil(Nx/2)); %go to start position
        [x, y, z] = handles.stage.getPosition();
        catch ME
            rethrow(ME);
        end
        pause(0.1);
        for ii=1:1:Nx
            try
                calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
                powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
                pwr(ii) = powers(detectorNum);
                if(ii>1 & pwr(ii)<pwr(ii-1))
                    handles.stage.move_x(-dx);
                    break;
                end
                    
            catch ME
                rethrow(ME);
            end
            pause(0.5)
            handles.stage.move_x(dx);
%             calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
%             powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value]
%             disp(['move: ' num2str(ii)]);
%             calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
%             powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value]
%             disp(['Iteration ' num2str(ii) 'ends'])
            
            pause(0.5)
        end
%         [pmax, pind] = max(pwr);
%         handles.stage.move_x(-(Nx-pind(1)+1)*dx);
%         calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
%         powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
%         prev = powers(detectorNum);
%         if(pmax>powers(detectorNum)) %check if a maximum value exists in the matrix
%             while (abs(pmax-powers(detectorNum))>0.2)
%                 handles.stage.move_x(-dx);
%                 pause(0.8)
%                 calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
%                 powers = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
%             end
% 
%         end
        if DEBUG
            disp(strcat('max power (moving in x ): ',num2str(pmax),' at index: ',num2str(pind)));
            figure;hold on
            plot(pwr); 
            plot(pind,pmax, '-xr');
            hold off
        end
        
    end
end
calllib('CT400_lib', 'CT400_Close', uiHandle);
h = waitbar(1,waitbar_handle,'Fine Alignment : Done');
delete(h); % deleting the waitbar once its fine alignment is completed

% %Yannick's code starts here
% IL_opt = measure_det_FA(handles,uiHandle,param_align,det); 
% [ori_x, ori_y, ~] = handles.stage.getPosition();
% N = ceil(param_align.window/param_align.step+1);
% step = param_align.window/N;
% 
% dim_now = 'x'; inc = 0; IL_opt_old = -70;
% while inc<3 || ( (IL_opt-IL_opt_old)>.2 && inc<10 ) % either less than 3 iterations, or [ less than 10 and inconsistent values]
%     IL_opt_old = IL_opt;   
%     
%     % Initialize
%     [x_now, y_now, ~] = handles.stage.getPosition(); inc = inc+1;
%     if dim_now == 'x', 
%         dim_now = 'y'; pos0 = ori_y; pos_now = y_now;
%     else dim_now = 'x'; pos0 = ori_x; pos_now = x_now;
%     end
%     poss = linspace(pos0-param_align.window/2,pos0+param_align.window/2,N);
%     eval(['handles.stage.move_',dim_now,'(',num2str( pos0-param_align.window/2-pos_now-2 ),');']); % move to start of window in this dimension
%     % Sweep
%     for i_pos = 1:N
%         eval(['handles.stage.move_',dim_now,'(',num2str(step),');']);
%         ILs(i_pos) = measure_det_FA(handles,uiHandle,param_align,det);
%     end
%     p = polyfit(poss,ILs,2); % figure; plot(poss,[ILs;polyval(p,poss)]);
%     pos_opt = fminbnd(@(pos) -polyval(p,pos),pos0-param_align.window/2,pos0+param_align.window/2,optimset('Display','off'));
%     eval(['handles.stage.move_',dim_now,'(',num2str(pos_opt-(pos0+param_align.window/2)),');']);
%     IL_opt = max([IL_opt_old,measure_det_FA(handles,uiHandle,param_align,det)]);
% end
% 
% % % two 1D interpolations don't seem to work
% % [init_x, init_y, ~] = handles.stage.getPosition();
% % % y_opt goes first because it's easier to optimize in y (wider gaussian)
% % y_opt = fminbnd(@(y) objf_alignment(handles,uiHandle,param_align,det,y,'y'),init_y-param_align.window/2,init_y+param_align.window/2,optimset('MaxFunEvals',10,'TolX',.2));
% % [init_x, init_y, ~] = handles.stage.getPosition(); handles.stage.move_y(y_opt-init_y);
% % % set y, optimize x
% % x_opt = fminbnd(@(x) objf_alignment(handles,uiHandle,param_align,det,x,'x'),init_x-param_align.window/2,init_x+param_align.window/2,optimset('MaxFunEvals',25,'TolX',.2));
% % [init_x, init_y, ~] = handles.stage.getPosition(); handles.stage.move_x(x_opt-init_x);
% % % verify y if necessary
% % y_opt = fminbnd(@(y) objf_alignment(handles,uiHandle,param_align,det,y,'y'),init_y-param_align.window/2,init_y+param_align.window/2,optimset('MaxFunEvals',25,'TolX',.2));
% % [init_x, init_y, ~] = handles.stage.getPosition(); handles.stage.move_y(y_opt-init_y);
% 
% warning('on','all');
% %Yannick's code ends here

function IL_max = measure_det_FA(handles,uiHandle,param_align,det) % measurement for fine alignment
calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
ILs = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
if strcmp(param_align.det_main,'All'), det_main = 1:4;
else det_main = str2num(param_align.det_main);
end
IL_max=max(ILs(det_main));

function IL_max = objf_alignment(handles,uiHandle,param_align,det,pos,dirn) % objective function for alignment optimization
[init_x, init_y, ~] = handles.stage.getPosition();
if strcmp(dirn,'x'),        handles.stage.move_x(pos-init_x);
elseif strcmp(dirn,'y'),    handles.stage.move_y(pos-init_y);
end
calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, det.pPout, det.pP1, det.pP2, det.pP3, det.pP4, det.pVext);
ILs = [det.pP1.Value, det.pP2.Value, det.pP3.Value, det.pP4.Value];
if strcmp(param_align.det_main,'All'), det_main = 1:4;
else det_main = str2num(param_align.det_main);
end
IL_max=max(ILs(det_main));


% function Align(handles) % Amar clean this up and implement 2D Gaussian interpolation
% load('parFineAlign.mat');
% N = ceil(param_align.window/param_align.step);
% powerMatrix = zeros(N,N);
% 
% pierror = libpointer('int32Ptr', zeros(1,1));
% uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);
% 
% contents = cellstr(get(handles.laserSlot,'String'));
% choice = contents{get(handles.laserSlot,'Value')};
% inputPort = str2num(choice); %input port for the laser
% 
% if(param_align.wavelength<=1400)
%     calllib('CT400_lib', 'CT400_SetLaser', uiHandle, inputPort, 'ENABLE', 10, 'LS_TunicsT100s_HP', 1260, 1360, 10);
%     calllib('CT400_lib', 'CT400_CmdLaser', uiHandle, inputPort, 'ENABLE', param_align.wavelength,param_align.power);
% else    
%     calllib('CT400_lib', 'CT400_SetLaser', uiHandle, inputPort, 'ENABLE', 01, 'LS_TunicsT100s_HP', 1550, 1630, 10);
%     calllib('CT400_lib', 'CT400_CmdLaser', uiHandle, inputPort, 'ENABLE', param_align.wavelength,param_align.power);
% end
% %reading the power
% pPout = libpointer('doublePtr', zeros(1, 1));
% pP1 = libpointer('doublePtr', zeros(1, 1));
% pP2 = libpointer('doublePtr', zeros(1, 1));
% pP3 = libpointer('doublePtr', zeros(1, 1));
% pP4 = libpointer('doublePtr', zeros(1, 1));
% pVext = libpointer('doublePtr', zeros(1, 1));
% 
% %get initial motor position
% [init_x, init_y, ~] = handles.stage.getPosition();
% X = N;
% Y = N;
% x = 0;
% y = 0;
% dx = 0;
% dy = -param_align.step;
% powerMatrix = zeros(N*N,8);
% index = 1;
% % fileID = fopen('exp.txt','w');
% bar=waitbar(0,'Fine Aligning...');
% 
% prev_x = 0;
% prev_y = 0;
% for i = 1:max(X, Y)^2
%     if (-X/2 < x <= X/2) && (-Y/2 < y <= Y/2)
% %         fprintf(fileID,'%f %f\n',x,y); 
%         moveX = x - prev_x;
%         moveY = y - prev_y;
%         %moving the stage
%         handles.stage.move_x(moveX);
%         handles.stage.move_y(moveY);
%         calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, pPout, pP1, pP2, pP3, pP4, pVext);
%         powerMatrix(index,1) = x;
%         powerMatrix(index,2) = y;
%         powerMatrix(index,3) = moveX;
%         powerMatrix(index,4) = moveY;
%         powerMatrix(index,5) = pP1.Value;
%         powerMatrix(index,6) = pP2.Value;
%         powerMatrix(index,7) = pP3.Value;
%         powerMatrix(index,8) = pP4.Value; 
%     end
%     if (x == y) || (x < 0 && x == -y) || (x > 0 && x == 2-y)
%         temp = dx;
%         dx = -dy;
%         dy = temp;
%     end
%     prev_x = x;
%     prev_y = y;
%     x = x+dx;
%     y = y+dy;
%     waitbar(index/(N*N),bar);
%     index = index+1;
% end
% close(bar);
% % fclose(fileID);
% save('PositionpowerMatrix.mat','powerMatrix');
% load('PositionpowerMatrix.mat');
% if strcmp(param_align.det_main,'All'), det_main = 1:4;
% else det_main = str2num(param_align.det_main);
% end
% [IL_max_dets,i_max_row]=max(powerMatrix(:,det_main+4));
% [IL_max,i_max_det]=max(IL_max_dets);
% % figure; scatter3(powerMatrix(:,1),powerMatrix(:,2),powerMatrix(:,5));
% 
% %new threshold calc technique
% if IL_max>param_align.threshold   
%     max_x_pos = powerMatrix(i_max_row(i_max_det),1);
%     max_y_pos = powerMatrix(i_max_row(i_max_det),2);
%     current_x_pos = powerMatrix(end,1);
%     current_y_pos = powerMatrix(end,2);
%     %return the stage to the origin position
%     handles.stage.move_x(-current_x_pos+max_x_pos);
%     handles.stage.move_y(-current_y_pos+max_y_pos);
% else
%      warndlg({strcat('For this threshold it''s not possible to align to either of detectors:  ',num2str(param_align.det_main))},'Detecting very Low power detected');
% end
%-----------------------------------------------------------------------------------
% guidata(handles)


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fineSettings.
function fineSettings_Callback(hObject, eventdata, handles)
% hObject    handle to fineSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FineAllignment



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function pathGds_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pathGds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in opengds.
function opengds_Callback(hObject, eventdata, handles)
% hObject    handle to opengds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.txt'},'Choose file');
set(handles.pathGds,'String',strcat(pathname, filename));
guidata(hObject,handles)

% --- Executes on button press in loadDevices.
function loadDevices_Callback(hObject, eventdata, handles)
% hObject    handle to loadDevices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    if isempty(get(handles.pathGds,'String')), 
        [filename pathname] = uigetfile({'*.txt'},'Choose file');
        set(handles.pathGds,'String',strcat(pathname, filename));
    end
    if isempty(get(handles.pathGds,'String')), return; end
    fileID = fopen(get(handles.pathGds,'String'));
    devices = textscan(fileID,'%s %s %s %s %s %s %s','Delimiter',',');
    handles.matrixOfChip = [devices{1},devices{2},devices{3},devices{4},devices{5},devices{6},devices{7}];
    handles.n_devs = length(handles.matrixOfChip)-1;
    handles.devs_all_names = {};
    for i_dev = 2:handles.n_devs+1
        handles.devs_all_names{i_dev-1} = [strjoin(handles.matrixOfChip(i_dev,[6,3,4]),', ')];
    end
    fclose(fileID);
    set(handles.list_devs_usel,'String',handles.devs_all_names);    
    set(handles.list_devs_moveto,'String',handles.devs_all_names); % filling all the individual device names in the dropdown list box
    set(handles.disp_devs_usel,'String',handles.n_devs);
    set(handles.disp_devs_sel,'String',0);
    set(handles.deviceSearchText,'String',[]);
    set(handles.list_devs_sel,'String',[]);
    guidata(hObject,handles)
catch ex
   warndlg(ex.message,'Device File Missing');
end

% --- Executes on button press in searchDevices.
function searchDevices_Callback(hObject, eventdata, handles)  % load from C:\Users\plantgroup\Desktop\ANT_06-12\ANT_2017_06_12_Group_MergedLayout.txt
% Example: 'Align & 1310 & TE, Yannick & 1310 & TE' 
% Whitespaces are not considered
filt_sections = strsplit(strrep(get(handles.deviceSearchText,'String'),' ',''),','); 
unselectAll_Callback(hObject, eventdata, handles);

inds_match = [];
for i_sec = 1:length(filt_sections)
    filt_terms = strsplit(filt_sections{i_sec},'&'); 
    for i_term = 1:length(filt_terms)
        if i_term == 1 
            n_terms = find(~cellfun('isempty', strfind(handles.devs_all_names,filt_terms{i_term}) )); % devices matching the search term
        else % only keep indices that already exist
            n_terms = intersect(n_terms, find(~cellfun('isempty', strfind(handles.devs_all_names,filt_terms{i_term}) ))); % devices matching the search term
        end
    end
    inds_match = union(inds_match,n_terms);
end
inds_umatch = setdiff(1:handles.n_devs,inds_match); % leftovers

set(handles.list_devs_sel,'String',handles.devs_all_names(inds_match));
set(handles.disp_devs_sel,'String',length(inds_match));
set(handles.list_devs_usel,'String',handles.devs_all_names(inds_umatch));
set(handles.disp_devs_usel,'String',length(inds_umatch));
guidata(hObject,handles)

% --- Executes on button press in unselectAll.
function unselectAll_Callback(hObject, eventdata, handles)
try
    set(handles.list_devs_sel,'String',[]);
    set(handles.disp_devs_sel,'String',0);
    set(handles.list_devs_usel,'String',handles.devs_all_names);
    set(handles.disp_devs_usel,'String',handles.n_devs);
    guidata(hObject,handles)
catch
    warndlg({'Unable to unselect devices';'Probably none of the devices are selected'},'Devices Not Available');
end

% --- Executes on button press in selectAll.
function selectAll_Callback(hObject, eventdata, handles)
try
    set(handles.list_devs_sel,'String',handles.devs_all_names);
    set(handles.disp_devs_sel,'String',handles.n_devs);
    set(handles.list_devs_usel,'String',[]);
    set(handles.disp_devs_usel,'String',0);
    guidata(hObject,handles)
catch
    warndlg({'Unable to select devices';'Probably missing coordinate file'},'Devices Not Available');
end

% --- Executes on button press in selectTE_O.
function selectTE_O_Callback(hObject, eventdata, handles)
filt_str = get(handles.deviceSearchText,'String');
if isempty(filt_str), set(handles.deviceSearchText,'String','TE&1310');
else set(handles.deviceSearchText,'String',[filt_str,',TE&1310']);
end
searchDevices_Callback(hObject, eventdata, handles)

% --- Executes on button press in selectTM_O.
function selectTM_O_Callback(hObject, eventdata, handles)
filt_str = get(handles.deviceSearchText,'String');
if isempty(filt_str), set(handles.deviceSearchText,'String','TM&1310');
else set(handles.deviceSearchText,'String',[filt_str,',TM&1310']);
end
searchDevices_Callback(hObject, eventdata, handles)

% --- Executes on button press in selectTE_C.
function selectTE_C_Callback(hObject, eventdata, handles)
filt_str = get(handles.deviceSearchText,'String');
if isempty(filt_str), set(handles.deviceSearchText,'String','TE&1550');
else set(handles.deviceSearchText,'String',[filt_str,',TE&1550']);
end
searchDevices_Callback(hObject, eventdata, handles)

% --- Executes on button press in selectTM_C.
function selectTM_C_Callback(hObject, eventdata, handles)
filt_str = get(handles.deviceSearchText,'String');
if isempty(filt_str), set(handles.deviceSearchText,'String','TM&1550');
else set(handles.deviceSearchText,'String',[filt_str,',TM&1550']);
end
searchDevices_Callback(hObject, eventdata, handles)


% --- Executes on selection change in list_devs_sel.
function list_devs_sel_Callback(hObject, eventdata, handles)
devs_sel_names = get(hObject,'String');
i_dev_now = get(hObject,'Value');
i_devs_sel = setdiff(1:length(devs_sel_names),i_dev_now);
devs_usel_names = get(handles.list_devs_usel,'String');

set(handles.list_devs_sel,'String',devs_sel_names(i_devs_sel));
set(handles.disp_devs_sel,'String',str2double(get(handles.disp_devs_sel,'String'))-1);
set(handles.list_devs_sel,'Value',1);
if isempty(devs_sel_names), set(handles.list_devs_usel,'String',devs_sel_names(i_dev_now));
else set(handles.list_devs_usel,'String',{devs_usel_names{:},devs_sel_names{i_dev_now}});
end
set(handles.disp_devs_usel,'String',str2double(get(handles.disp_devs_usel,'String'))+1);
guidata(hObject,handles)

% --- Executes on selection change in list_devs_usel.
function list_devs_usel_Callback(hObject, eventdata, handles)
devs_usel_names = get(hObject,'String');
i_dev_now = get(hObject,'Value');
i_devs_usel = setdiff(1:length(devs_usel_names),i_dev_now);
devs_sel_names = get(handles.list_devs_sel,'String');

set(handles.list_devs_usel,'String',devs_usel_names(i_devs_usel));
set(handles.disp_devs_usel,'String',str2double(get(handles.disp_devs_usel,'String'))-1);
set(handles.list_devs_usel,'Value',1);
if isempty(devs_sel_names), set(handles.list_devs_sel,'String',devs_usel_names(i_dev_now));
else set(handles.list_devs_sel,'String',{devs_sel_names{:},devs_usel_names{i_dev_now}});
end
set(handles.disp_devs_sel,'String',str2double(get(handles.disp_devs_sel,'String'))+1);
guidata(hObject,handles)

% --- Executes on button press in shift2Select.
function shift2Select_Callback(hObject, eventdata, handles)
% hObject    handle to shift2Select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in shift2Unselect.
function shift2Unselect_Callback(hObject, eventdata, handles)
% hObject    handle to shift2Unselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function list_devs_usel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_devs_usel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function motorDev1x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motorDev1x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function motorDev2x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motorDev2x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function motorDev3x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motorDev3x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function motorDev4x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motorDev4x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function motorDev5x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motorDev5x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function motorDev1y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motorDev1y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function motorDev2y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motorDev2y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function motorDev3y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motorDev3y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function motorDev4y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motorDev4y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function motorDev5y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motorDev5y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function gdsDev1x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gdsDev1x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function gdsDev2x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gdsDev2x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function gdsDev3x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gdsDev3x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function gdsDev4x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gdsDev4x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function gdsDev5x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gdsDev5x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function gdsDev1y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gdsDev1y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function gdsDev2y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gdsDev2y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function gdsDev3y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gdsDev3y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function gdsDev4y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gdsDev4y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function gdsDev5y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gdsDev5y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in getPosDev1.
function getPosDev1_Callback(hObject, eventdata, handles)
try
    [xpos,ypos,~] = handles.stage.getPosition();
    set(handles.motorDev1x,'String',xpos);
    set(handles.motorDev1y,'String',ypos);
    guidata(hObject,handles)
catch
    warndlg({'Please check motor connections !'},'Motor not connected');
end

% --- Executes on button press in getPosDev2.
function getPosDev2_Callback(hObject, eventdata, handles)
try
    [xpos,ypos,~] = handles.stage.getPosition();
    set(handles.motorDev2x,'String',xpos);
    set(handles.motorDev2y,'String',ypos);
    guidata(hObject,handles)
catch
    warndlg({'Please check motor connections !'},'Motor not connected');
end

% --- Executes on button press in getPosDev3.
function getPosDev3_Callback(hObject, eventdata, handles)
try
    [xpos,ypos,~] = handles.stage.getPosition();
    set(handles.motorDev3x,'String',xpos);
    set(handles.motorDev3y,'String',ypos);
    guidata(hObject,handles)
catch
    warndlg({'Please check motor connections !'},'Motor not connected');
end


% --- Executes on button press in getPosDev4.
function getPosDev4_Callback(hObject, eventdata, handles)
try
    [xpos,ypos,~] = handles.stage.getPosition();
    set(handles.motorDev4x,'String',xpos);
    set(handles.motorDev4y,'String',ypos);
    guidata(hObject,handles)
catch
    warndlg({'Please check motor connections !'},'Motor not connected');
end

% --- Executes on button press in getPosDev5.
function getPosDev5_Callback(hObject, eventdata, handles)
try
    [xpos,ypos,~] = handles.stage.getPosition();
    set(handles.motorDev5x,'String',xpos);
    set(handles.motorDev5y,'String',ypos);
    guidata(hObject,handles)
catch
    warndlg({'Please check motor connections !'},'Motor not connected');
end

% --- Executes on button press in calculatePositions.
function calculatePositions_Callback(hObject, eventdata, handles)
for i_marker = 1:3
    if ~isempty(eval(['get(handles.gdsDev',num2str(i_marker),'x,''String'')']))
        pos_refs.gds(i_marker,1) = eval(['str2num(get(handles.gdsDev',num2str(i_marker),'x,''String''))']);
        pos_refs.gds(i_marker,2) = eval(['str2num(get(handles.gdsDev',num2str(i_marker),'y,''String''))']);
        pos_refs.mtr(i_marker,1) = eval(['str2num(get(handles.motorDev',num2str(i_marker),'x,''String''))']);
        pos_refs.mtr(i_marker,2) = eval(['str2num(get(handles.motorDev',num2str(i_marker),'y,''String''))']);
    end
end

gds_allX = pos_refs.gds(:,1); gds_allY = pos_refs.gds(:,2);
motor_allX = pos_refs.mtr(:,1); motor_allY = pos_refs.mtr(:,2);
save('gds_allX.mat','gds_allX'); save('gds_allY.mat','gds_allY');
save('motor_allX.mat','motor_allX'); save('motor_allY.mat','motor_allY');
save('ReferencePositions.mat','pos_refs')
if isempty(pos_refs.mtr),     warndlg({'Positions not acquired from the motor coordinates';'Please align it manually or motor might not be connected!'},'Missing Motor Coordinates');
elseif isempty(pos_refs.gds), warndlg({'Positions not entered for the gds coordinates';'Please enter it manually  !'},'Missing GDS Coordinates');
else    
    devs_sel_names = get(handles.list_devs_sel,'String'); % list of selected devices from chip
    % matrixOfChip = [X-coord Y-coord Polarization wavelength type deviceID comment];
    
    devs_all_names = handles.matrixOfChip(2:end,6); % list of all devices from chip
    devs_sel={};
    for i=1:length(devs_sel_names)
        dev_now = strsplit(strrep(devs_sel_names{i},' ',''),',');
        dev_id_now = dev_now{1};
%         i_dev = find(~cellfun('isempty', strfind(devs_all_names,dev_id_now)));
        i_dev = find(strcmp(devs_all_names,dev_id_now));
        [r c]=size(i_dev)
        if(r>1)
            warndlg({ strcat('Multiple copies exists for the device')},'Fatal error');
        end
        devs_sel(i,:) = handles.matrixOfChip(i_dev+1,:);        
        pos_devs.gds(i,:) = [str2num(devs_sel{i,1}) str2num(devs_sel{i,2})];
        save_NameFiles(i) = (handles.matrixOfChip(i_dev+1,6));
    end
    handles.all_save_NameFiles = save_NameFiles;
   
    pos_devs.mtr = mapMotorCoordinates(pos_refs.gds,pos_refs.mtr,pos_devs.gds);
    handles.p_all_X = pos_devs.mtr(:,1);
    handles.p_all_Y = pos_devs.mtr(:,2);
end
guidata(hObject,handles)

% --- Executes on button press in startAutoMeasurement.
function startAutoMeasurement_Callback(hObject, eventdata, handles)
% hObject    handle to startAutoMeasurement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pierror; global uiHandle;
hfig = figure; hax = axes('Parent',hfig);
hw = waitbar(0,'Performing automated testing...');
for i=1:60
    folderPath = handles.savePath.String;
    fileName = handles.all_save_NameFiles(i);
    
    waitbar(i/60,hw,sprintf(['Performing automated testing : ' num2str(i) '/' num2str(length(handles.p_all_X)) ]));
    
    % Move to the correct position
    [xpos,ypos,~] = handles.stage.getPosition();
    diff_x = handles.p_all_X(i) - xpos;
    handles.stage.move_x(diff_x);
    diff_y = handles.p_all_Y(i) - ypos;
    handles.stage.move_y(diff_y);
    optimize_alignment(handles);
    
    % Analysis
    performSweep(handles);
    pause(2);
%     if(mod(i,40)==0)
        % Initialize
%         disp([num2str(i) ' : FLUSHING MEMORY']);
%         YenistaTunicsCT400Launcher;
%     end

    pathToSave = [folderPath,'\',fileName,'.mat'];
    if isempty(folderPath), warndlg({ strcat('Please enter a valid path to save the files')},'No file Path');
    else
        load('sweepingData.mat');
        str_path=cell2mat(pathToSave);
        save(str_path,'sweepData');
        plot(hax,sweepData(:,1),sweepData(:,2:end)); axis(hax,'tight'); ylim(hax,[-70 0]);
        xlabel(hax,'Wavelength (nm)'); ylabel(hax,'IL (dB)'); title(hax,strrep(fileName,'_',' ')); legend(hax,'Port 1','Port 2','Port 3','Port 4');
        saveas(hfig,strrep(str_path,'.mat','.png'),'png');
%         uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);
%         calllib('CT400_lib', 'CT400_Close', uiHandle);
    end
end
pause(5);
for i=i+1:length(handles.p_all_X)
    folderPath = handles.savePath.String;
    fileName = handles.all_save_NameFiles(i);
    
    waitbar(i/length(handles.p_all_X),hw,sprintf(['Performing automated testing : ' num2str(i) '/' num2str(length(handles.p_all_X)) ]));
    
    % Move to the correct position
    [xpos,ypos,~] = handles.stage.getPosition();
    diff_x = handles.p_all_X(i) - xpos;
    handles.stage.move_x(diff_x);
    diff_y = handles.p_all_Y(i) - ypos;
    handles.stage.move_y(diff_y);
    optimize_alignment(handles);
    
    % Analysis
    performSweep(handles);
    pause(2);
%     if(mod(i,40)==0)
%         % Initialize
%         disp([num2str(i) ' : FLUSHING MEMORY']);
%         YenistaTunicsCT400Launcher;
%     end

    pathToSave = [folderPath,'\',fileName,'.mat'];
    if isempty(folderPath), warndlg({ strcat('Please enter a valid path to save the files')},'No file Path');
    else
        load('sweepingData.mat');
        str_path=cell2mat(pathToSave);
        save(str_path,'sweepData');
        plot(hax,sweepData(:,1),sweepData(:,2:end)); axis(hax,'tight'); ylim(hax,[-70 0]);
        xlabel(hax,'Wavelength (nm)'); ylabel(hax,'IL (dB)'); title(hax,strrep(fileName,'_',' ')); legend(hax,'Port 1','Port 2','Port 3','Port 4');
        saveas(hfig,strrep(str_path,'.mat','.png'),'png');
%         uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);
%         calllib('CT400_lib', 'CT400_Close', uiHandle);
    end
end
close(hfig); close(hw);

guidata(hObject,handles)

function savePath_Callback(hObject, eventdata, handles)
% hObject    handle to savePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of savePath as text
%        str2double(get(hObject,'String')) returns contents of savePath as a double

% --- Executes during object creation, after setting all properties.
function savePath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to savePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in saveFiles.
function saveFiles_Callback(hObject, eventdata, handles)
% hObject    handle to saveFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathname = uigetdir;
fullpathname = strcat(pathname);
handles.pathSaveFile=fullpathname;
set(handles.savePath,'String',handles.pathSaveFile);
guidata(hObject,handles)

% --- Executes on selection change in list_devs_moveto.
function list_devs_moveto_Callback(hObject, eventdata, handles)
% hObject    handle to list_devs_moveto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_devs_moveto contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_devs_moveto

% --- Executes during object creation, after setting all properties.
function list_devs_moveto_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_devs_moveto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function list_devs_sel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_devs_sel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function selectionFilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectionFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function deviceSearchText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in resetMotorPositions.
function resetMotorPositions_Callback(hObject, eventdata, handles)
for i_marker = 1:5
    eval(['set(handles.motorDev',num2str(i_marker),'x,''String'','' '')'])
    eval(['set(handles.motorDev',num2str(i_marker),'y,''String'','' '')'])
end

% --- Executes on button press in resetGdsPositions.
function resetGdsPositions_Callback(hObject, eventdata, handles)
for i_marker = 1:5
    eval(['set(handles.gdsDev',num2str(i_marker),'x,''String'','' '')'])
    eval(['set(handles.gdsDev',num2str(i_marker),'y,''String'','' '')'])
end

% --- Executes on button press in detec1.
function detec1_Callback(hObject, eventdata, handles)
% hObject    handle to detec1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('sweepingData.mat');
val = get(handles.detec1,'Value');
if(val==1)
   handles.axesPlot1 = plot(sweepData(:,1),sweepData(:,2));
else
    set(handles.axesPlot1,'Visible','off');
end

% Hint: get(hObject,'Value') returns toggle state of detec1
guidata(hObject,handles)


% --- Executes on button press in detec2.
function detec2_Callback(hObject, eventdata, handles)
% hObject    handle to detec2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('sweepingData.mat');
val = get(handles.detec2,'Value');
if(val==1)
    handles.axesPlot2 = plot(sweepData(:,1),sweepData(:,3));
else
    set(handles.axesPlot2,'Visible','off');
end
% Hint: get(hObject,'Value') returns toggle state of detec2
guidata(hObject,handles)


% --- Executes on button press in detec3.
function detec3_Callback(hObject, eventdata, handles)
% hObject    handle to detec3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('sweepingData.mat');
val = get(handles.detec3,'Value');
if(val==1)
    handles.axesPlot3 = plot(sweepData(:,1),sweepData(:,4));
else
    set(handles.axesPlot3,'Visible','off');
end
% Hint: get(hObject,'Value') returns toggle state of detec3
guidata(hObject,handles)


% --- Executes on button press in detec4.
function detec4_Callback(hObject, eventdata, handles)
% hObject    handle to detec4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('sweepingData.mat');
val = get(handles.detec4,'Value');
if(val==1)
    handles.axesPlot4 = plot(sweepData(:,1),sweepData(:,5));
else
    set(handles.axesPlot4,'Visible','off');
end
% Hint: get(hObject,'Value') returns toggle state of detec4
guidata(hObject,handles)


% --- Executes on button press in loadPrevSet.
function loadPrevSet_Callback(hObject, eventdata, handles)
% hObject    handle to loadPrevSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('gds_allX.mat');
load('gds_allY.mat');
load('motor_allX.mat');
load('motor_allY.mat');
try
    set(handles.motorDev1x,'String',motor_allX(1));
catch
    set(handles.motorDev1x,'String','');
end
try
    set(handles.motorDev1y,'String',motor_allY(1));
catch
    set(handles.motorDev1y,'String','');
end
try
    set(handles.motorDev2x,'String',motor_allX(2));
catch
    set(handles.motorDev2x,'String','');
end
try
    set(handles.motorDev2y,'String',motor_allY(2));
catch
    set(handles.motorDev2y,'String','');
end
try
    set(handles.motorDev3x,'String',motor_allX(3));
catch
    set(handles.motorDev3x,'String','');
end
try
    set(handles.motorDev3y,'String',motor_allY(3));
catch
    set(handles.motorDev3y,'String','');
end
try
    set(handles.motorDev4x,'String',motor_allX(4));
catch
    set(handles.motorDev4x,'String','');
end
try
    set(handles.motorDev4y,'String',motor_allY(4));
catch
    set(handles.motorDev4y,'String','');
end
try
    set(handles.motorDev5x,'String',motor_allX(5));
catch
    set(handles.motorDev5x,'String','');
end
try
    set(handles.motorDev5y,'String',motor_allY(5));
catch
    set(handles.motorDev5y,'String','');
end
try
    set(handles.gdsDev1x,'String',gds_allX(1));
catch
    set(handles.gdsDev1x,'String','');
end
try
    set(handles.gdsDev1y,'String',gds_allY(1));
catch
    set(handles.gdsDev1y,'String','');
end
try
    set(handles.gdsDev2x,'String',gds_allX(2));
catch
    set(handles.gdsDev2x,'String','');
end
try
    set(handles.gdsDev2y,'String',gds_allY(2));
catch
    set(handles.gdsDev2y,'String','');
end
try
    set(handles.gdsDev3x,'String',gds_allX(3));
catch
    set(handles.gdsDev3x,'String','');
end
set(handles.gdsDev3y,'String',gds_allY(3));
try
    set(handles.gdsDev4x,'String',gds_allX(4));
catch
    set(handles.gdsDev4x,'String','');
end
try
    set(handles.gdsDev4y,'String',gds_allY(4));
catch
    set(handles.gdsDev4y,'String','');
end
try
    set(handles.gdsDev5x,'String',gds_allX(5));
catch
    set(handles.gdsDev5x,'String','');
end
try
    set(handles.gdsDev5y,'String',gds_allY(5));
catch
    set(handles.gdsDev5y,'String','');
end
guidata(hObject,handles)


% --- Executes on button press in clearPlotFig.
function clearPlotFig_Callback(hObject, eventdata, handles)
% hObject    handle to clearPlotFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    delete(handles.axesPlot1)
end

try
    delete(handles.axesPlot2)
end

try
    delete(handles.axesPlot3)
end

try
    delete(handles.axesPlot4)
end
try
    cla(handles.axes1,'reset');
end
guidata(hObject,handles)
   


% --- Executes during object creation, after setting all properties.
function detec1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to detec2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function detec2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to detec2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in saveGraph.
function saveGraph_Callback(hObject, eventdata, handles)
% hObject    handle to saveGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folderPath = handles.savePath.String;
[r c]=size(folderPath);
if (c==0)
    warndlg({ strcat('Please enter a valid path to save the files')},'No file Path');
else
    load('sweepingData.mat');
%     [folderPath,'\',handles.name.String]
    save([folderPath,'\',handles.name.String],'sweepData');
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function moveMotorX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to moveMotorX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function moveMotorY_Callback(hObject, eventdata, handles)
% hObject    handle to moveMotorY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of moveMotorY as text
%        str2double(get(hObject,'String')) returns contents of moveMotorY as a double

% --- Executes during object creation, after setting all properties.
function moveMotorY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to moveMotorY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in moveMotorXY.
function moveMotorXY_Callback(hObject, eventdata, handles)
% hObject    handle to moveMotorXY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
moveInX = str2num(get(handles.moveMotorX,'String'));
moveInY = str2num(get(handles.moveMotorY,'String'));
[xpos,ypos,~] = handles.stage.getPosition();
disp(strcat('Before moving: x = ',num2str(xpos),' y= ',num2str(ypos)))
diff_x = moveInX - xpos
diff_y = moveInY - ypos
handles.stage.move_x(diff_x);
handles.stage.move_y(diff_y);
[xpos,ypos,~] = handles.stage.getPosition();
disp(strcat('After moving: x = ',num2str(xpos),' y= ',num2str(ypos)))

% --- Executes during object creation, after setting all properties.
function address_CreateFcn(hObject, eventdata, handles)
% hObject    handle to address (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global pierror; global uiHandle;
if get(handles.StageCorvus,'Value'), handles.stage.disconnect(); end
try
    if get(handles.Laser,'Value')
        uiHandle = calllib('CT400_lib', 'CT400_Init', libpointer('int32Ptr', zeros(1,1)));
        offLaser;
        calllib('CT400_lib', 'CT400_Close', uiHandle);
    end
catch ex, warning(ex.message);
end
delete(hObject);

function pathGds_KeyPressFcn(hObject, eventdata, handles)
function pathGds_Callback(hObject, eventdata, handles)
function deviceSearchText_KeyPressFcn(hObject, eventdata, handles)
function deviceSearchText_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function startAutoMeasurement_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startAutoMeasurement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in goIndividualDevices.
function goIndividualDevices_Callback(hObject, eventdata, handles)
% hObject    handle to goIndividualDevices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents2 = cellstr(get(handles.list_devs_moveto,'String'));
dev_now = strsplit(strrep(contents2{get(handles.list_devs_moveto,'Value')},' ',''),',');
% devs_sel(1,:) = handles.matrixOfChip(find(~cellfun('isempty', strfind(handles.devs_all_names,dev_now(1))))+1,:) ; %matches the substring of name
devs_all_names = handles.matrixOfChip(2:end,6); % list of all devices from chip
devs_sel(1,:) = handles.matrixOfChip(find(strcmp(devs_all_names,dev_now{1}))+1,:);
pos_dev.gds(1,:) = [str2num(devs_sel{1,1}) str2num(devs_sel{1,2})];
load('ReferencePositions.mat');
motor_pos_dev = mapMotorCoordinates(pos_refs.gds,pos_refs.mtr,pos_dev.gds);
% Move to the correct position
[xpos,ypos,~] = handles.stage.getPosition();
diff_x = motor_pos_dev(1) - xpos;
handles.stage.move_x(diff_x);
diff_y = motor_pos_dev(2) - ypos;
handles.stage.move_y(diff_y);
optimize_alignment(handles);

% --- Executes on button press in goWAlign.
function goWAlign_Callback(hObject, eventdata, handles)
% go to the specific device without aligning
contents2 = cellstr(get(handles.list_devs_moveto,'String'));
dev_now = strsplit(strrep(contents2{get(handles.list_devs_moveto,'Value')},' ',''),',');
% devs_sel(1,:) = handles.matrixOfChip(find(~cellfun('isempty', strfind(handles.devs_all_names,dev_now(1))))+1,:) ; %matches the substring of name
devs_all_names = handles.matrixOfChip(2:end,6); % list of all devices from chip
devs_sel(1,:) = handles.matrixOfChip(find(strcmp(devs_all_names,dev_now{1}))+1,:);
pos_dev.gds(1,:) = [str2num(devs_sel{1,1}) str2num(devs_sel{1,2})];
load('ReferencePositions.mat');
motor_pos_dev = mapMotorCoordinates(pos_refs.gds,pos_refs.mtr,pos_dev.gds);
% Move to the correct position
[xpos,ypos,~] = handles.stage.getPosition();
diff_x = motor_pos_dev(1) - xpos;
handles.stage.move_x(diff_x);
diff_y = motor_pos_dev(2) - ypos;
handles.stage.move_y(diff_y);



% --- Executes on button press in stage_checkConnected.
function stage_checkConnected_Callback(hObject, eventdata, handles)
% hObject    handle to stage_checkConnected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in detector_checkConnected.
function detector_checkConnected_Callback(hObject, eventdata, handles)
% hObject    handle to detector_checkConnected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in overplot.
function overplot_Callback(hObject, eventdata, handles)
% hObject    handle to overplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of overplot
