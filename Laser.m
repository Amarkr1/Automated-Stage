function varargout = Laser(varargin)
%AMAR [amar.kumar@mail.mcgill.ca]
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
pierror = libpointer('int32Ptr', zeros(1,1));
uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);
offLaser;
calllib('CT400_lib', 'CT400_Close', uiHandle);


% --- Executes on button press in onLaser.
function onLaser_Callback(hObject, eventdata, handles)
% hObject    handle to onLaser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pierror = libpointer('int32Ptr', zeros(1,1));
uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);




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
pierror = libpointer('int32Ptr', zeros(1,1));
uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);

contents = cellstr(get(handles.laserSlot,'String'));
choice = contents{get(handles.laserSlot,'Value')};
inputPort = str2num(choice);
power = str2num(get(handles.powerVal,'String'));
wavelength = str2num(get(handles.wavelengthVal,'String'));
if(wavelength<=1400)
    calllib('CT400_lib', 'CT400_SetLaser', uiHandle, inputPort, 'ENABLE', 10, 'LS_TunicsT100s_HP', 1260, 1360, 10);
    calllib('CT400_lib', 'CT400_CmdLaser', uiHandle, inputPort, 'ENABLE', wavelength,power);
else
    
    calllib('CT400_lib', 'CT400_SetLaser', uiHandle, inputPort, 'ENABLE', 01, 'LS_TunicsT100s_HP', 1500, 1630, 10);
    calllib('CT400_lib', 'CT400_CmdLaser', uiHandle, inputPort, 'ENABLE', wavelength,power);
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
guidata(hObject,handles);

function performSweep(handles)
contents = cellstr(get(handles.laserSlot,'String'));
choice = contents{get(handles.laserSlot,'Value')};
input = str2num(choice);
power = str2num(get(handles.sweepPower,'String'));
startWavelength = str2num(get(handles.startWave,'String'));
stopWavelength = str2num(get(handles.stopWave,'String'));
resol = str2num(get(handles.resolution,'String'));

contents2 = cellstr(get(handles.sweepSpeed,'String'));
choice2 = contents2{get(handles.sweepSpeed,'Value')};
sweepSpeed = str2num(choice2);
sweepData = YenistaTunicsCT400(power, startWavelength, stopWavelength, resol, [1 2 3 4], sweepSpeed, input, 'test', 'test');
save('sweepingData.mat','sweepData');
axes(handles.axes1);

hold on;
% plot(data(:,1),data(:,3));
xlabel('Wavelength (nm)');
ylabel('Power');
val1 = get(handles.detec1,'Value');
val2 = get(handles.detec2,'Value');
val3 = get(handles.detec3,'Value');
val4 = get(handles.detec4,'Value');
if(val1==1)
    plot(sweepData(:,1),sweepData(:,2));
end

if(val2==1)
    plot(sweepData(:,1),sweepData(:,3));
end

if(val3==1)
    plot(sweepData(:,1),sweepData(:,4));
end

if(val4==1)
    plot(sweepData(:,1),sweepData(:,5));
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
pierror = libpointer('int32Ptr', zeros(1,1));
uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);
pPout = libpointer('doublePtr', zeros(1, 1));
pP1 = libpointer('doublePtr', zeros(1, 1));
pP2 = libpointer('doublePtr', zeros(1, 1));
pP3 = libpointer('doublePtr', zeros(1, 1));
pP4 = libpointer('doublePtr', zeros(1, 1));
pVext = libpointer('doublePtr', zeros(1, 1));

while(1)
    calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, pPout, pP1, pP2, pP3, pP4, pVext);
    set(handles.d1,'String',num2str(pP1.Value));
    set(handles.d2,'String',num2str(pP2.Value));
    set(handles.d3,'String',num2str(pP3.Value));
    set(handles.d4,'String',num2str(pP4.Value));
    set(handles.outputPower,'String',num2str(pPout.Value));
    val = get(handles.pauseMeasuring,'Value');
    if(val==1)
        break;
    end
%     fprintf('Pout: %2.2f, P1: %2.2f, P2: %2.2f, P3: %2.2f, P4: %2.2f\n', pPout.Value, pP1.Value, pP2.Value, pP3.Value, pP4.Value);
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

function address_Callback(hObject, eventdata, handles)
% hObject    handle to address (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of address as text
%        str2double(get(hObject,'String')) returns contents of address as a double


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



function axes_Callback(hObject, eventdata, handles)
% hObject    handle to axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of axes as text
%        str2double(get(hObject,'String')) returns contents of axes as a double


% --- Executes during object creation, after setting all properties.
function axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in connectCorvus.
function connectCorvus_Callback(hObject, eventdata, handles)
% hObject    handle to connectCorvus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.stage = CorvusEco;
handles.stage.Param.COMPort = str2num(get(handles.address,'String'));
handles.stage.connect();
if(handles.stage.Connected == 1)
   set(handles.statusCorvus,'backgroundcolor','g'); % g is reserved for green color
end
guidata(hObject,handles)




% --- Executes on button press in disconnectCorvus.
function disconnectCorvus_Callback(hObject, eventdata, handles)
% hObject    handle to disconnectCorvus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.stage.Connected == 1)
    handles.stage.disconnect();
    set(handles.statusCorvus,'backgroundcolor','r'); % g is reserved for green color
end



% --- Executes on button press in statusCorvus.
function statusCorvus_Callback(hObject, eventdata, handles)
% hObject    handle to statusCorvus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in fineAllign.
function fineAllign_Callback(hObject, eventdata, handles)
% hObject    handle to fineAllign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
doFineAllignment(handles)
guidata(hObject,handles)

function doFineAllignment(handles)
load('parFineAllign.mat');
wavelength = array(1);
power = array(2);
step = array(3);
threshold = array(4);
window = array(5);
detector1 = array(6); %the detector1 which is reading the power
detector2 = array(7); %the detector1 which is reading the power

N = ceil(window/step);
powerMatrix = zeros(N,N);

pierror = libpointer('int32Ptr', zeros(1,1));
uiHandle = calllib('CT400_lib', 'CT400_Init', pierror);

contents = cellstr(get(handles.laserSlot,'String'));
choice = contents{get(handles.laserSlot,'Value')};
inputPort = str2num(choice); %input port for the laser

if(wavelength<=1400)
    calllib('CT400_lib', 'CT400_SetLaser', uiHandle, inputPort, 'ENABLE', 10, 'LS_TunicsT100s_HP', 1260, 1360, 10);
    calllib('CT400_lib', 'CT400_CmdLaser', uiHandle, inputPort, 'ENABLE', wavelength,power);
else
    
    calllib('CT400_lib', 'CT400_SetLaser', uiHandle, inputPort, 'ENABLE', 01, 'LS_TunicsT100s_HP', 1550, 1630, 10);
    calllib('CT400_lib', 'CT400_CmdLaser', uiHandle, inputPort, 'ENABLE', wavelength,power);
end
%reading the power
pPout = libpointer('doublePtr', zeros(1, 1));
pP1 = libpointer('doublePtr', zeros(1, 1));
pP2 = libpointer('doublePtr', zeros(1, 1));
pP3 = libpointer('doublePtr', zeros(1, 1));
pP4 = libpointer('doublePtr', zeros(1, 1));
pVext = libpointer('doublePtr', zeros(1, 1));

%get initial motor position
[init_x, init_y, ~] = handles.stage.getPosition();
X = N;
Y = N;
x = 0;
y = 0;
dx = 0;
dy = -step;
powerMatrix = zeros(N*N,8);
index = 1;
% fileID = fopen('exp.txt','w');
bar=waitbar(0,'Fine Alligning...');

prev_x = 0;
prev_y = 0;
for i = 1:max(X, Y)^2
    if (-X/2 < x <= X/2) && (-Y/2 < y <= Y/2)
%         fprintf(fileID,'%f %f\n',x,y); 
        moveX = x - prev_x;
        moveY = y - prev_y;
        %moving the stage
        handles.stage.move_x(moveX);
        handles.stage.move_y(moveY);
        calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, pPout, pP1, pP2, pP3, pP4, pVext);
        powerMatrix(index,1) = x;
        powerMatrix(index,2) = y;
        powerMatrix(index,3) = moveX;
        powerMatrix(index,4) = moveY;
        powerMatrix(index,5) = pP1.Value;
        powerMatrix(index,6) = pP2.Value;
        powerMatrix(index,7) = pP3.Value;
        powerMatrix(index,8) = pP4.Value; 
    end
    if (x == y) || (x < 0 && x == -y) || (x > 0 && x == 2-y)
        temp = dx;
        dx = -dy;
        dy = temp;
    end
    prev_x = x;
    prev_y = y;
    x = x+dx;
    y = y+dy;
    waitbar(index/(N*N),bar);
    index = index+1;
end
close(bar);
% fclose(fileID);
save('PositionpowerMatrix.mat','powerMatrix');
load('PositionpowerMatrix.mat');
powerDetector1 = detector1 + 4;
powerDetector2 = detector2 + 4;
[M1,I1]=max(powerMatrix(:,powerDetector1))
[M2,I2]=max(powerMatrix(:,powerDetector2))

% %--------------prev threshold calc technique-----------------
% if(max(powerMatrix(:,powerDetector1))<threshold)
%     warndlg({'For this threshold its not possible to allign to Detector 1'},'Detecting very Low power detected');
% else
%     
%     req_row = powerMatrix(I1,:);
%     max_x_pos = req_row(1);
%     max_y_pos = req_row(2);
%     [row column] = size(powerMatrix);
%     current_x_pos = powerMatrix(row,1);
%     current_y_pos = powerMatrix(row,2);
%     [curr_x, curr_y, ~] = handles.stage.getPosition()
%     %return the stage to the origin position
%     handles.stage.move_x(-current_x_pos);
%     handles.stage.move_y(-current_y_pos);
%     [init_x, init_y, ~] = handles.stage.getPosition()
%     %now move the stage to the optimized position
%     handles.stage.move_x(max_x_pos);
%     handles.stage.move_y(max_y_pos);
%     [optim_x, optim_y, ~] = handles.stage.getPosition()
% end
% %-----------------------------------------------------------------------------------
%new threshold calc technique
if(max(powerMatrix(:,powerDetector1))>threshold)
    
    req_row = powerMatrix(I1,:);
    max_x_pos = req_row(1);
    max_y_pos = req_row(2);
    [row column] = size(powerMatrix);
    current_x_pos = powerMatrix(row,1);
    current_y_pos = powerMatrix(row,2);
    [curr_x, curr_y, ~] = handles.stage.getPosition()
    %return the stage to the origin position
    handles.stage.move_x(-current_x_pos);
    handles.stage.move_y(-current_y_pos);
    [init_x, init_y, ~] = handles.stage.getPosition()
    %now move the stage to the optimized position
    handles.stage.move_x(max_x_pos);
    handles.stage.move_y(max_y_pos);
    [optim_x, optim_y, ~] = handles.stage.getPosition()
elseif (max(powerMatrix(:,powerDetector2))>threshold)
    req_row = powerMatrix(I2,:);
    max_x_pos = req_row(1);
    max_y_pos = req_row(2);
    [row column] = size(powerMatrix);
    current_x_pos = powerMatrix(row,1);
    current_y_pos = powerMatrix(row,2);
    [curr_x, curr_y, ~] = handles.stage.getPosition()
    %return the stage to the origin position
    handles.stage.move_x(-current_x_pos);
    handles.stage.move_y(-current_y_pos);
    [init_x, init_y, ~] = handles.stage.getPosition()
    %now move the stage to the optimized position
    handles.stage.move_x(max_x_pos);
    handles.stage.move_y(max_y_pos);
    [optim_x, optim_y, ~] = handles.stage.getPosition() 
else
     warndlg({strcat('For this threshold its not possible to allign to either of detectors:  ',num2str(detector1),'  /  ',num2str(detector2))},'Detecting very Low power detected');
    
end
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



function pathGds_Callback(hObject, eventdata, handles)
% hObject    handle to pathGds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pathGds as text
%        str2double(get(hObject,'String')) returns contents of pathGds as a double


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
fullpathname = strcat(pathname, filename);
handles.pathname=fullpathname;
set(handles.pathGds,'String',fullpathname);
guidata(hObject,handles)


% --- Executes on button press in unselectAll.
function unselectAll_Callback(hObject, eventdata, handles)
try
    set(handles.selectedDevices,'String',[]); %empty the entire selected devices
    set(handles.allDevices,'String',handles.devicesOnChip_Copy); %fill the all device list
    handles.devicesOnChip = handles.devicesOnChip_Copy;
    handles.noOfSelectedDevices = 0;
    handles.allSelectedDevices = [];
    set(handles.dispSelectedDevices,'String',handles.noOfSelectedDevices);
    guidata(hObject,handles)
catch
    warndlg({'Unable to unselect devices';'Probably none of the devices are selected'},'Devices Not Available');
end

% --- Executes on button press in selectAll.
function selectAll_Callback(hObject, eventdata, handles)
try
    set(handles.allDevices,'String',[]);
    set(handles.selectedDevices,'String',handles.devicesOnChip_Copy);
    [row column] = size(handles.matrixOfChip(:,6));
    handles.noOfSelectedDevices = row-1;
    set(handles.dispSelectedDevices,'String',handles.noOfSelectedDevices);
    guidata(hObject,handles)
catch
    warndlg({'Unable to select devices';'Probably missing coordinate file'},'Devices Not Available');
end
% --- Executes on selection change in allDevices.
function allDevices_Callback(hObject, eventdata, handles)

contents = cellstr(get(hObject,'String'));
curr_selected = contents{get(hObject,'Value')};
if(handles.noOfSelectedDevices==0)
    handles.allSelectedDevices = {curr_selected};
else
    handles.allSelectedDevices = [curr_selected;handles.allSelectedDevices];
end
set(handles.selectedDevices,'String',handles.allSelectedDevices);
handles.availableDevicesForSelection = contents;
[rn,cn]=find(strcmp(handles.availableDevicesForSelection,curr_selected)); %get the index of that device from the entire chip list
handles.noOfSelectedDevices = handles.noOfSelectedDevices+1;
[r1 c1] = size(contents);
if(rn==r1)
    handles.availableDevicesForSelection(rn)=[]; % make that specific index to null and then update the list present
else
    handles.availableDevicesForSelection(rn)=[]; % make that specific index to null and then update the list present
end

set(handles.allDevices,'String',handles.availableDevicesForSelection);
set(handles.dispSelectedDevices,'String',handles.noOfSelectedDevices);
guidata(hObject,handles)


% --- Executes on selection change in selectedDevices.
function selectedDevices_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));
curr_selected = contents{get(hObject,'Value')};
currentSelectedDevices = contents;
[rn,cn]=find(strcmp(currentSelectedDevices,curr_selected)); %get the index of that device from the entire chip list
handles.availableDevicesForSelection = [curr_selected;handles.availableDevicesForSelection];
currentSelectedDevices(rn)=[]; % make that specific index to null and then update the list present
handles.noOfSelectedDevices = handles.noOfSelectedDevices-1; %as devices are getting removed 1 is subtracted
set(handles.dispSelectedDevices,'String',handles.noOfSelectedDevices);
set(handles.allDevices,'String',handles.availableDevicesForSelection);
set(handles.selectedDevices,'String',currentSelectedDevices);
guidata(hObject,handles)



% --- Executes during object creation, after setting all properties.
function allDevices_CreateFcn(hObject, eventdata, handles)
% hObject    handle to allDevices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


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



function motorDev1x_Callback(hObject, eventdata, handles)
% hObject    handle to motorDev1x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motorDev1x as text
%        str2double(get(hObject,'String')) returns contents of motorDev1x as a double


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



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


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



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit33 as text
%        str2double(get(hObject,'String')) returns contents of edit33 as a double


% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit34_Callback(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit34 as text
%        str2double(get(hObject,'String')) returns contents of edit34 as a double


% --- Executes during object creation, after setting all properties.
function edit34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit35_Callback(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit35 as text
%        str2double(get(hObject,'String')) returns contents of edit35 as a double


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



function edit36_Callback(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit36 as text
%        str2double(get(hObject,'String')) returns contents of edit36 as a double


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



function motorDev2x_Callback(hObject, eventdata, handles)
% hObject    handle to motorDev2x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motorDev2x as text
%        str2double(get(hObject,'String')) returns contents of motorDev2x as a double


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



function motorDev3x_Callback(hObject, eventdata, handles)
% hObject    handle to motorDev3x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motorDev3x as text
%        str2double(get(hObject,'String')) returns contents of motorDev3x as a double


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



function motorDev4x_Callback(hObject, eventdata, handles)
% hObject    handle to motorDev4x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motorDev4x as text
%        str2double(get(hObject,'String')) returns contents of motorDev4x as a double


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



function motorDev5x_Callback(hObject, eventdata, handles)
% hObject    handle to motorDev5x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motorDev5x as text
%        str2double(get(hObject,'String')) returns contents of motorDev5x as a double


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



function motorDev1y_Callback(hObject, eventdata, handles)
% hObject    handle to motorDev1y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motorDev1y as text
%        str2double(get(hObject,'String')) returns contents of motorDev1y as a double


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



function motorDev2y_Callback(hObject, eventdata, handles)
% hObject    handle to motorDev2y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motorDev2y as text
%        str2double(get(hObject,'String')) returns contents of motorDev2y as a double


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



function motorDev3y_Callback(hObject, eventdata, handles)
% hObject    handle to motorDev3y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motorDev3y as text
%        str2double(get(hObject,'String')) returns contents of motorDev3y as a double


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



function motorDev4y_Callback(hObject, eventdata, handles)
% hObject    handle to motorDev4y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motorDev4y as text
%        str2double(get(hObject,'String')) returns contents of motorDev4y as a double


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



function motorDev5y_Callback(hObject, eventdata, handles)
% hObject    handle to motorDev5y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motorDev5y as text
%        str2double(get(hObject,'String')) returns contents of motorDev5y as a double


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



function gdsDev1x_Callback(hObject, eventdata, handles)
% hObject    handle to gdsDev1x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gdsDev1x as text
%        str2double(get(hObject,'String')) returns contents of gdsDev1x as a double


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



function gdsDev2x_Callback(hObject, eventdata, handles)
% hObject    handle to gdsDev2x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gdsDev2x as text
%        str2double(get(hObject,'String')) returns contents of gdsDev2x as a double


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



function gdsDev3x_Callback(hObject, eventdata, handles)
% hObject    handle to gdsDev3x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gdsDev3x as text
%        str2double(get(hObject,'String')) returns contents of gdsDev3x as a double


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



function gdsDev4x_Callback(hObject, eventdata, handles)
% hObject    handle to gdsDev4x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gdsDev4x as text
%        str2double(get(hObject,'String')) returns contents of gdsDev4x as a double


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



function gdsDev5x_Callback(hObject, eventdata, handles)
% hObject    handle to gdsDev5x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gdsDev5x as text
%        str2double(get(hObject,'String')) returns contents of gdsDev5x as a double


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



function gdsDev1y_Callback(hObject, eventdata, handles)
% hObject    handle to gdsDev1y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gdsDev1y as text
%        str2double(get(hObject,'String')) returns contents of gdsDev1y as a double


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



function gdsDev2y_Callback(hObject, eventdata, handles)
% hObject    handle to gdsDev2y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gdsDev2y as text
%        str2double(get(hObject,'String')) returns contents of gdsDev2y as a double


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



function gdsDev3y_Callback(hObject, eventdata, handles)
% hObject    handle to gdsDev3y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gdsDev3y as text
%        str2double(get(hObject,'String')) returns contents of gdsDev3y as a double


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



function gdsDev4y_Callback(hObject, eventdata, handles)
% hObject    handle to gdsDev4y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gdsDev4y as text
%        str2double(get(hObject,'String')) returns contents of gdsDev4y as a double


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



function gdsDev5y_Callback(hObject, eventdata, handles)
% hObject    handle to gdsDev5y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gdsDev5y as text
%        str2double(get(hObject,'String')) returns contents of gdsDev5y as a double


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
gds1x = str2num(get(handles.gdsDev1x,'String'));
gds1y = str2num(get(handles.gdsDev1y,'String'));

gds2x = str2num(get(handles.gdsDev2x,'String'));
gds2y = str2num(get(handles.gdsDev2y,'String'));

gds3x = str2num(get(handles.gdsDev3x,'String'));
gds3y = str2num(get(handles.gdsDev3y,'String'));

gds4x = str2num(get(handles.gdsDev4x,'String'));
gds4y = str2num(get(handles.gdsDev4y,'String'));

gds5x = str2num(get(handles.gdsDev5x,'String'));
gds5y = str2num(get(handles.gdsDev5y,'String'));

arr_x = [gds1x;gds2x;gds3x;gds4x;gds5x];
arr_y = [gds1y;gds2y;gds3y;gds4y;gds5y];

[row_arr_x column_arr_x] = size(arr_x);
[row_arr_y column_arr_y] = size(arr_y);

motor1x = str2num(get(handles.motorDev1x,'String'));
motor1y = str2num(get(handles.motorDev1y,'String'));

motor2x = str2num(get(handles.motorDev2x,'String'));
motor2y = str2num(get(handles.motorDev2y,'String'));

motor3x = str2num(get(handles.motorDev3x,'String'));
motor3y = str2num(get(handles.motorDev3y,'String'));

motor4x = str2num(get(handles.motorDev4x,'String'));
motor4y = str2num(get(handles.motorDev4y,'String'));

motor5x = str2num(get(handles.motorDev5x,'String'));
motor5y = str2num(get(handles.motorDev5y,'String'));

arr_X = [motor1x;motor2x;motor3x;motor4x;motor5x];
arr_Y = [motor1y;motor2y;motor3y;motor4y;motor5y];

[row_arr_X column_arr_X] = size(arr_X);
[row_arr_Y column_arr_Y] = size(arr_Y);


gds_allX = [gds1x;gds2x;gds3x;gds4x;gds5x];
gds_allY = [gds1y;gds2y;gds3y;gds4y;gds5y];
motor_allX = [motor1x;motor2x;motor3x;motor4x;motor5x];
motor_allY = [motor1y;motor2y;motor3y;motor4y;motor5y];
save('gds_allX.mat','gds_allX');
save('gds_allY.mat','gds_allY');
save('motor_allX.mat','motor_allX');
save('motor_allY.mat','motor_allY');

selectedDevicesFrmChip = cellstr(get(handles.selectedDevices,'String'));
[row column] = size(handles.matrixOfChip);
allDeviceList = handles.matrixOfChip(2:row,6);
[r c]=size(selectedDevicesFrmChip);
matrixOfSelectedDevices={};
for i=1:r
    curr_selected = selectedDevicesFrmChip(i);
    [rn,cn]=find(strcmp(allDeviceList,curr_selected));
    matrixOfSelectedDevices(i,1:column) = handles.matrixOfChip(rn+1,1:column);        
    all_X(i) = (handles.matrixOfChip(rn+1,1));
    all_Y(i) = (handles.matrixOfChip(rn+1,2));
    save_NameFiles(i) = (handles.matrixOfChip(rn+1,6));
end
[r c]=size(matrixOfSelectedDevices)
matrixOfSelectedDevices
save_NameFiles
all_X= str2num(char(all_X))
all_Y= str2num(char(all_Y))
handles.all_save_NameFiles = save_NameFiles;
if(column_arr_X == 0)
    warndlg({'Positions not acquired from the motor coordinates';'Please allign it manually or motor might not be connected!'},'Missing Motor Coordinates');
elseif(column_arr_x == 0)
    warndlg({'Positions not entered for the gds coordinates';'Please enter it manually  !'},'Missing GDS Coordinates');
else
%     disp('here')
    %the linear interpolation model is built here
    
    model_xX = fitlm(arr_x,arr_X);
    model_yY = fitlm(arr_y,arr_Y);
    
    %the created model is fitted to the available coordinates
%     handles.p_all_X = predict(model_xX,all_X);
%     handles.p_all_Y = predict(model_yY,all_Y);
%     c = getMotorCoords([arr_x(1);arr_y(1)])
%     all_X
%     all_Y
    coordinatesToFind = vertcat(all_X',all_Y')
    for i=1:r
        a = getMotorCoords(coordinatesToFind(:,i));
        motorCoordinates(1,i) = a(1);
        motorCoordinates(2,i) = a(2);
    end
    motorCoordinates
    handles.p_all_X = motorCoordinates(1,:);
    handles.p_all_Y = motorCoordinates(2,:);
end
guidata(hObject,handles)

% --- Executes on button press in startAutoMeasurement.
function startAutoMeasurement_Callback(hObject, eventdata, handles)
% hObject    handle to startAutoMeasurement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[row column] = size(handles.p_all_X)

for i=1:column
    [xpos,ypos,~] = handles.stage.getPosition();
    diff_x = handles.p_all_X(i) - xpos;
    diff_y = handles.p_all_Y(i) - ypos;
    handles.stage.move_x(diff_x);
    handles.stage.move_y(diff_y);
    doFineAllignment(handles);
    performSweep(handles);
    folderPath = handles.savePath.String
    fileName = handles.all_save_NameFiles(i)
    pathToSave = [folderPath,'\',fileName,'.mat']
    [r c]=size(folderPath)
    if (c==0)
        warndlg({ strcat('Please enter a valid path to save the files')},'No file Path');
    else
        load('sweepingData.mat');
%     [folderPath,'\',handles.name.String]
%         whos('pathToSave')
%         whos('sweepData')
        a=cell2mat(pathToSave)
        save(a,'sweepData');
    end
end
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


% --- Executes on selection change in individualDeviceList.
function individualDeviceList_Callback(hObject, eventdata, handles)
% hObject    handle to individualDeviceList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns individualDeviceList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from individualDeviceList


% --- Executes during object creation, after setting all properties.
function individualDeviceList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to individualDeviceList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in loadDevices.
function loadDevices_Callback(hObject, eventdata, handles)
% hObject    handle to loadDevices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    fileID = fopen(handles.pathname);
    devices = textscan(fileID,'%s %s %s %s %s %s %s','Delimiter',',');
    handles.matrixOfChip = [devices{1},devices{2},devices{3},devices{4},devices{5},devices{6},devices{7}];
    [row column] = size(handles.matrixOfChip(:,6));
    handles.noOfSelectedDevices = 0;
    handles.devicesOnChip = handles.matrixOfChip(2:row,6);
    handles.devicesOnChip_Copy = handles.matrixOfChip(2:row,6); %this copy is to select all the 
                                                                %devices when all is pressed
    fclose(fileID);
    set(handles.allDevices,'String',handles.devicesOnChip);
    set(handles.dispTotalDevices,'String',row-1);
    set(handles.dispSelectedDevices,'String',handles.noOfSelectedDevices);
    set(handles.deviceSearchText,'String',[]);
    set(handles.selectedDevices,'String',[]);
    
    %filling all the individual device names in the dropdown list box
    set(handles.individualDeviceList,'String',handles.devicesOnChip);
    guidata(hObject,handles)
catch
    
%     warning('off', id)
    
%    warndlg({'Message line 1';'Message line 2'})
   warndlg({'None of the files was selected'},'Device File Missing');
end




% --- Executes during object creation, after setting all properties.
function selectedDevices_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectedDevices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in selectionFilter.
function selectionFilter_Callback(hObject, eventdata, handles)
% hObject    handle to selectionFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectionFilter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectionFilter


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



function deviceSearchText_Callback(hObject, eventdata, handles)
% hObject    handle to deviceSearchText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of deviceSearchText as text
%        str2double(get(hObject,'String')) returns contents of deviceSearchText as a double


% --- Executes during object creation, after setting all properties.
function deviceSearchText_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in searchDevices.
function searchDevices_Callback(hObject, eventdata, handles)

try
    searchTerms = strsplit(get(handles.deviceSearchText,'String'),','); 
    [row column]=size(searchTerms);
    %initialization
    handles.allSelectedDevices = {};
    handles.noOfSelectedDevices = 0;
    
    for i=1:column
        searchTerm = searchTerms{i};
        resultantArray = strfind(handles.devicesOnChip_Copy,searchTerm);
        matchingDevicesIndx = find(~cellfun('isempty', resultantArray));%matching devices to the entered search term
        [row,~] = size(matchingDevicesIndx);
        if(~(row==0))
            handles.noOfSelectedDevices = handles.noOfSelectedDevices + row;
            set(handles.dispSelectedDevices,'String',handles.noOfSelectedDevices);
            handles.allSelectedDevices = [handles.devicesOnChip_Copy(matchingDevicesIndx);handles.allSelectedDevices];
            set(handles.selectedDevices,'String',handles.allSelectedDevices);
            
        else
             warndlg({ strcat('Device not found for the search term :  ',searchTerm);'The search term is case sensitive'},'No match found');
        end
    end
    set(handles.allDevices,'String',handles.devicesOnChip_Copy(~ismember(handles.devicesOnChip_Copy,handles.allSelectedDevices)));
    %the above line searches all the selected devices and removes it from
    %the list of devices present 
    
catch
     warndlg({'Unable to select devices';'Probably missing coordinate file'},'Devices Not Available');
end
guidata(hObject,handles)


% --- Executes on button press in resetMotorPositions.
function resetMotorPositions_Callback(hObject, eventdata, handles)
set(handles.motorDev1x,'String',' ');
set(handles.motorDev1y,'String',' ');
set(handles.motorDev2x,'String',' ');
set(handles.motorDev2y,'String',' ');
set(handles.motorDev3x,'String',' ');
set(handles.motorDev3y,'String',' ');
set(handles.motorDev4x,'String',' ');
set(handles.motorDev4y,'String',' ');
set(handles.motorDev5x,'String',' ');
set(handles.motorDev5y,'String',' ');

% --- Executes on button press in resetGdsPositions.
function resetGdsPositions_Callback(hObject, eventdata, handles)
set(handles.gdsDev1x,'String',' ');
set(handles.gdsDev1y,'String',' ');
set(handles.gdsDev2x,'String',' ');
set(handles.gdsDev2y,'String',' ');
set(handles.gdsDev3x,'String',' ');
set(handles.gdsDev3y,'String',' ');
set(handles.gdsDev4x,'String',' ');
set(handles.gdsDev4y,'String',' ');
set(handles.gdsDev5x,'String',' ');
set(handles.gdsDev5y,'String',' ');



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



function name_Callback(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name as text
%        str2double(get(hObject,'String')) returns contents of name as a double


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


% --- Executes on button press in clearFigure.
function clearFigure_Callback(hObject, eventdata, handles)
% hObject    handle to clearFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function moveMotorX_Callback(hObject, eventdata, handles)
% hObject    handle to moveMotorX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of moveMotorX as text
%        str2double(get(hObject,'String')) returns contents of moveMotorX as a double


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
