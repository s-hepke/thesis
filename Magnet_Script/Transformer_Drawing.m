%% Setup Program

% clear all
% close all
% clc
% format short

%% Setup Communication Link

MN6 = actxserver('Magnet.application');                                    % Building a virtual machine 
set(MN6, 'Visible', 1);                                                    % Opening Magnet software
invoke(MN6, 'newDocument');                                                % Creating a new Magnet file
path = [cd,'\transformer_model.mn'];                                       % Magnet file name definition
invoke(MN6,'saveDocument',num2str(path));                                  % Opening the Magnet file

% Units settings inside the Magnet file

invoke(MN6, 'processCommand', 'CALL getDocument().setDefaultLengthUnit("Millimeters")');     % Length unit setting
invoke(MN6, 'processCommand', 'CALL getDocument().setDefaultTimeUnit("Milliseconds")');      % Time unit setting
invoke(MN6, 'processCommand', 'CALL getDocument().setDefaultFrequencyUnit("Hertz")');        % Frequency unit setting
invoke(MN6, 'processCommand', 'CALL getDocument().setDefaultTemperatureUnit("Celsius")');    % Temperature unit setting

Doc = invoke(MN6, 'getDocument');
View = invoke(Doc, 'getCurrentView');
Consts = invoke(MN6, 'getConstants');

%% Creating Model

tic                                                                        % Starting the simulation time counter
Model_Inputs;
Model_Materials;
Model_Drawing;
Model_Excitation;
Model_Circuit;
SimulationTime = toc;                                                      % Ending the simulation time counter
% Display the simulation time 
disp(['Model Setup Time [s]: ',num2str(SimulationTime)]);

Model_Solution;
Model_Postprocessing;

%% Close Communication Link
invoke(MN6,'saveDocument',num2str(path));                                  % Opening the Magnet file
% invoke(MN6,'saveDocument');                                  % Opening the Magnet file
invoke(MN6, 'processCommand', 'CALL getDocument().close(False)');

%% Secondary Communication Link
invoke(MN6, 'newDocument');                                                % Creating a new Magnet file
path = [cd,'\transformer_model_magnetizing_current.mn'];                                       % Magnet file name definition
invoke(MN6,'saveDocument',num2str(path));                                  % Opening the Magnet file

% Units settings inside the Magnet file

invoke(MN6, 'processCommand', 'CALL getDocument().setDefaultLengthUnit("Millimeters")');     % Length unit setting
invoke(MN6, 'processCommand', 'CALL getDocument().setDefaultTimeUnit("Milliseconds")');      % Time unit setting
invoke(MN6, 'processCommand', 'CALL getDocument().setDefaultFrequencyUnit("Hertz")');        % Frequency unit setting
invoke(MN6, 'processCommand', 'CALL getDocument().setDefaultTemperatureUnit("Celsius")');    % Temperature unit setting

Doc = invoke(MN6, 'getDocument');
View = invoke(Doc, 'getCurrentView');
Consts = invoke(MN6, 'getConstants');

% tic
% Model_Magnetizing_Current;
% SimulationTime = toc;                                                      % Ending the simulation time counter
% % Display the simulation time 
% disp(['Model Magnetizing Current Calculation [s]: ',num2str(SimulationTime)]);

%% Close Secondary Communication Link
invoke(MN6,'saveDocument',num2str(path));                                  % Opening the Magnet file
% invoke(MN6,'saveDocument');                                  % Opening the Magnet file
invoke(MN6, 'processCommand', 'CALL getDocument().close(False)');

%% Exit the Magnet
invoke(MN6, 'Exit');                                                       % Close the Magnet file