function varargout = proj(varargin)
% PROJ MATLAB code for proj.fig
%      PROJ, by itself, creates a new PROJ or raises the existing
%      singleton*.
%
%      H = PROJ returns the handle to a new PROJ or the handle to
%      the existing singleton*.
%
%      PROJ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJ.M with the given input arguments.
%
%      PROJ('Property','Value',...) creates a new PROJ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proj_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proj_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proj

% Last Modified by GUIDE v2.5 03-Dec-2019 20:43:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proj_OpeningFcn, ...
                   'gui_OutputFcn',  @proj_OutputFcn, ...
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


% --- Executes just before proj is made visible.
function proj_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proj (see VARARGIN)

% Choose default command line output for proj
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proj wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = proj_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%paths for fetching the training data 
path1='C:\Users\hp\Desktop\project\STUDENT1\';%subject 1 sample images directory
path2='C:\Users\hp\Desktop\project\STUDENT2\';%subject 2 sample images directory
path3='C:\Users\hp\Desktop\project\STUDENT3\';%subject 3 sample images directory

%displaying the text Training.......
set(handles.text2, 'Visible', 'on');
pause(0.7);
set(handles.pushbutton2, 'Visible', 'on');
pause(0.7);
set(handles.pushbutton3, 'Visible', 'on');
pause(0.7);
set(handles.pushbutton4, 'Visible', 'on');
pause(0.7);
set(handles.pushbutton5, 'Visible', 'on');
pause(0.7);
set(handles.pushbutton6, 'Visible', 'on');
pause(0.7);
set(handles.pushbutton7, 'Visible', 'on');
pause(0.7);
set(handles.pushbutton8, 'Visible', 'on');
pause(0.7);
set(handles.pushbutton9, 'Visible', 'on');
pause(0.7);
set(handles.pushbutton10, 'Visible', 'on');




%variable to distinguish subject ie subject 1 subject 2 subject 3
subject=1;

%three subjects 
for j=1:3
    %Fifteen samples of each subject
    for i=1:15
        if (i<10)
            %setting default value of the directory
            filename='0';
            if(j==1)
                fpath=[path1,num2str(j),' ',filename,num2str(i),'.jpg'];
            else if (j==2)
                fpath=[path2,num2str(j),' ',filename,num2str(i),'.jpg'];
            else
                    fpath=[path3,num2str(j),' ',filename,num2str(i),'.jpg'];
                end
            end
        else
            %saving the path of folders from directory
            if(j==1)
                fpath=[path1,num2str(j),' ',num2str(i),'.jpg'];
            else if(j==2)
                    fpath=[path2,num2str(j),' ',num2str(i),'.jpg'];
                else
                    fpath=[path3,num2str(j),' ',num2str(i),'.jpg'];
                end
            end
        end
    %executes fifteen times for each subject 
    
    %Reading the images from the subject directory
    sampleface = imread(fpath);
    %converting into greyscale
    sampleface = rgb2gray(sampleface);
    %standardizing the size of the input
    Face=imresize(sampleface,[200 200]);
    %extracting features of the subject
    features(subject,:)=extractHOGFeatures(Face);
    %labelling the subject
    if(j==1)
        TrainData{subject}='Student 1';
    else if(j==2)
            TrainData{subject}='Student 2';
        else
            TrainData{subject}='Student 3';
        end
    end
    %
    subject=subject+1;
    end
end

set(handles.text4, 'Visible', 'on');
pause(0.5);
set(handles.text5, 'Visible', 'on');


%Prepration of standard model
 model = fitcecoc (features,TrainData);  

 set(handles.text5, 'Visible', 'on');
 
 %Testing the input images
  for i=1:3;
    TestData=['Test',num2str(i),'.jpg'];
    Testface = imread(TestData);
    TestFace=imresize(Testface,[200 200]);
    TestMatrix=extractHOGFeatures(TestFace);
    PredictFace = predict (model,TestMatrix);
    if i==1
    axes(handles.axes1);
    imshow((TestFace)),title(PredictFace);
    set(handles.text6, 'Visible', 'on');
    set(handles.text7, 'Visible', 'on');
    end
     if i==2
    axes(handles.axes2);
    imshow((TestFace)),title(PredictFace);
    set(handles.text8, 'Visible', 'on');
     end
     if i==3
    axes(handles.axes3);
    imshow((TestFace)),title(PredictFace);
    set(handles.text9, 'Visible', 'on');
    end

    pause(2);
  end






set(handles.text10, 'Visible', 'on');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
