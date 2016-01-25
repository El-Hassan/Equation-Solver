function varargout = SystEqSolver(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SystEqSolver_OpeningFcn, ...
                   'gui_OutputFcn',  @SystEqSolver_OutputFcn, ...
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


% --- Executes just before SystEqSolver is made visible.
function SystEqSolver_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = SystEqSolver_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function ans_Callback(hObject, eventdata, handles)
function ans_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_Callback(hObject, eventdata, handles)
function input_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%------------------- Read From File --------------------------%
function readfile_Callback(hObject, eventdata, handles)
    try
        id = fopen('equations.txt','r');
        eq = fscanf(id,'%s',Inf);
        set(handles.input,'String',eq);
    catch ME
        set(handles.ans,'String','File Not Found !');
    end
%--------------------------------------------------------------$
function solve_Callback(hObject, eventdata, handles)
    method = get( get(handles.method,'SelectedObject'),'Tag');
    in = get(handles.input,'String');
    if(~isempty(in)) 
        
        [valid , eqs] = validateInput(in);
        
        if(valid==0)
            set(handles.ans,'String','Enter a valid System of equations');
        else
            switch method 
                case 'g' 
                    gauss(eqs,1,handles);
                case 'gj' 
                    gauss(eqs,2,handles);
                case 'lu' 
                    lu(eqs,handles);
            end
        end
    end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
    set(handles.ans,'String','The Program has been Updated :p ');
%-----------------------------------------------------------------%
function lu(eqs , handles)

    [b,unknowns,ordered] = getMatrix(eqs,1);
    if(ordered==0)
         set(handles.ans,'String','The symbols in all equations must be in the same order .');
         return ;
    elseif(ordered==-1)
        set(handles.ans,'String','The Number of equations is not equal to The number of unknowns');
         return ;
     elseif(ordered==-2)
        set(handles.ans,'String','Enter a valid System of equations');
         return ;     
    end
    
    [a,unknowns,ordered2] = getMatrix(eqs,0);
    if(ordered2==0)
     set(handles.ans,'String','The symbols in all equations must be in the same order .');
     return ;
    end
    
    [Xi,time,er] = LUDecomposition(a, b, length(unknowns)-1, 0);
    printResult(Xi,time,unknowns,handles);
    
function gauss(eqs,method,handles)
    
    [aug,unknowns,ordered] = getMatrix(eqs,2);
    if(ordered==0)
         set(handles.ans,'String','The symbols in all equations must be in the same order .');
         return ;
    elseif(ordered==-1)
        set(handles.ans,'String','The Number of equations is not equal to The number of unknowns');
         return ; 
    elseif(ordered==-2)
        set(handles.ans,'String','Enter a valid System of equations');
         return ;          
    end
    
    if(method == 1)
      [Xi,time] = GaussNaive(aug);  
    else
      [Xi,time] = gaussjordan(aug) ;
    end
    printResult(Xi,time,unknowns,handles);    

function printResult(x,time,unknowns,handles)
    
    result = {};
    noSol = 0 ;
    infSol = 0;
    for i=1:length(x) ;
        if(x(i)==inf)
            noSol = 1 ;
        end
        if(isnan(x(i)))
            infSol = 1;
        end
        result{i} = sprintf('%s = %.15f',unknowns{i},x(i)) ;
    end
    
    if(noSol == 1)
        result = {};
        result{1} = 'No Solution';
    elseif(infSol == 1)
        result = {};
        result{1} = 'Infinite Number of solutions';
    else
        result{length(x)+1}=sprintf('\n---> Time Elapsed = %f \n',time);
    end
    set(handles.ans,'String',result);

        
