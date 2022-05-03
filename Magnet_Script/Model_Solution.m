%% Primary Winding Excitation

if ex_c == 0
    % Setting the phase A current waveform parameters 
    invoke(MN6,'processCommand', 'REDIM DataWaveform(5)');                        % Defining the vector size
    invoke(MN6,'processCommand', 'DataWaveform(0)= 0');                           % Current offset value [A]
    invoke(MN6,'processCommand', ['DataWaveform(1)=' num2str(primI*sqrt(2)) ]);            % Current amplitude value [A]
    invoke(MN6,'processCommand', ['DataWaveform(2)=' num2str(freqF) ]);               % Current frequency [Hz]
    invoke(MN6,'processCommand', 'DataWaveform(3)= 0');                           % Time delay [ms]
    invoke(MN6,'processCommand', 'DataWaveform(4)= 0');                           % Damping factor
    invoke(MN6,'processCommand', ['DataWaveform(5)=' num2str(0)]);     % Current phase advance [deg]
    % Assigning the current parameters to the phase A current source
    invoke(MN6,'processCommand', 'Call getDocument().setSourceWaveform("I1","SIN", DataWaveform)');

    % Setting the phase B current waveform parameters        
    invoke(MN6,'processCommand', 'REDIM DataWaveform(5)');                        % Defining the vector size
    invoke(MN6,'processCommand', 'DataWaveform(0)= 0');                           % Current offset value [A]
    invoke(MN6,'processCommand', ['DataWaveform(1)=' num2str(primI*sqrt(2)) ]);            % Current amplitude value [A]
    invoke(MN6,'processCommand', ['DataWaveform(2)=' num2str(freqF) ]);               % Current frequency [Hz]
    invoke(MN6,'processCommand', 'DataWaveform(3)= 0');                           % Time delay [ms]
    invoke(MN6,'processCommand', 'DataWaveform(4)= 0');                           % Damping factor
    invoke(MN6,'processCommand', ['DataWaveform(5)=' num2str(120)]); % Current phase advance [deg]
    % Assigning the current parameters to the phase B current source
    invoke(MN6,'processCommand', 'Call getDocument().setSourceWaveform("I2","SIN", DataWaveform)');

    % Setting the phase C current waveform parameters        
    invoke(MN6,'processCommand', 'REDIM DataWaveform(5)');                        % Defining the vector size
    invoke(MN6,'processCommand', 'DataWaveform(0)= 0');                           % Current offset value [A]
    invoke(MN6,'processCommand', ['DataWaveform(1)=' num2str(primI*sqrt(2)) ]);            % Current amplitude value [A]
    invoke(MN6,'processCommand', ['DataWaveform(2)=' num2str(freqF) ]);               % Current frequency [Hz]
    invoke(MN6,'processCommand', 'DataWaveform(3)= 0');                           % Time delay [ms]
    invoke(MN6,'processCommand', 'DataWaveform(4)= 0');                           % Damping factor
    invoke(MN6,'processCommand', ['DataWaveform(5)=' num2str(240)]); % Current phase advance [deg]
    % Assigning the current parameters to the phase B current source
    invoke(MN6,'processCommand', 'Call getDocument().setSourceWaveform("I3","SIN", DataWaveform)');
elseif ex_c == 1
    t_start = 0;
    t_end = 1000*1/freqF;
    t = [t_start:t_end/(length(ex_w)-1):t_end]';
    a = ex_w;
    pa = t*360/t(length(t));
    [c, pa120] = min(abs(pa - 120));
    [c, pa240] = min(abs(pa - 240));
    c = [a(pa120:length(a),1);a(2:pa120,1)];
    b = [a(pa240:length(a),1);a(2:pa240,1)];
    t = t/1000;
    for ex = 1:1:cycN
        if ex == 1
            tif = t;
            af = a;
            bf = b;
            cf = c;
        elseif ex >1
            tif = [tif(1:length(tif-1),:);t+(ex-1)*t_end/1000];
            af = [af(1:length(af-1),:);a];
            bf = [bf(1:length(bf-1),:);b];
            cf = [cf(1:length(cf-1),:);c];
        end
    end
    invoke(MN6,'processCommand', ['REDIM DataWaveformA(', num2str(2*length(af)-1) ,')']);
    invoke(MN6,'processCommand', ['REDIM DataWaveformB(', num2str(2*length(bf)-1) ,')']);
    invoke(MN6,'processCommand', ['REDIM DataWaveformC(', num2str(2*length(cf)-1) ,')']);
    for ex = 0:1:2*length(af)-1
        if rem(ex,2) == 0
            invoke(MN6,'processCommand', ['DataWaveformA(', num2str(ex) ,' )=' num2str(tif(1+(ex)/2,1)) ]);
        elseif rem(ex,2) == 1
            invoke(MN6,'processCommand', ['DataWaveformA(', num2str(ex) ,' )=' num2str(af((ex+1)/2,1)) ]);
        end
    end
    for ex = 0:1:2*length(bf)-1
        if rem(ex,2) == 0
            invoke(MN6,'processCommand', ['DataWaveformB(', num2str(ex) ,' )=' num2str(tif(1+(ex)/2,1)) ]);
        elseif rem(ex,2) == 1
            invoke(MN6,'processCommand', ['DataWaveformB(', num2str(ex) ,' )=' num2str(bf((ex+1)/2,1)) ]);
        end
    end
    for ex = 0:1:2*length(cf)-1
        if rem(ex,2) == 0
            invoke(MN6,'processCommand', ['DataWaveformC(', num2str(ex) ,' )=' num2str(tif(1+(ex)/2,1)) ]);
        elseif rem(ex,2) == 1
            invoke(MN6,'processCommand', ['DataWaveformC(', num2str(ex) ,' )=' num2str(cf((ex+1)/2,1)) ]);
        end
    end
    invoke(MN6,'processCommand', 'Call getDocument().setSourceWaveform("I1","PWL", DataWaveformA)');
    invoke(MN6,'processCommand', 'Call getDocument().setSourceWaveform("I2","PWL", DataWaveformB)');
    invoke(MN6,'processCommand', 'Call getDocument().setSourceWaveform("I3","PWL", DataWaveformC)');
end
%% Resistance Assignment

% Setting the secondary load resistance  
% invoke(MN6,'processCommand', 'REDIM LoadResistance()');                   
invoke(MN6,'processCommand', ['LoadResistance = ' num2str(loadR) ]);                     
invoke(MN6,'processCommand','Call getDocument().setResistance("R1", LoadResistance)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R2", LoadResistance)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R3", LoadResistance)');

% Setting the primary phase resistance  
% invoke(MN6,'processCommand', 'REDIM LoadResistance()');                   
invoke(MN6,'processCommand', ['LoadResistance = ' num2str(resP) ]);                     
invoke(MN6,'processCommand','Call getDocument().setResistance("R4", LoadResistance)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R5", LoadResistance)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R6", LoadResistance)');

% Setting the primary damping resistance  
% invoke(MN6,'processCommand', 'REDIM LoadResistance()');                   
invoke(MN6,'processCommand', ['LoadResistance = ' num2str(0.001) ]);                     
invoke(MN6,'processCommand','Call getDocument().setResistance("R7", LoadResistance)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R8", LoadResistance)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R9", LoadResistance)');

% Setting the secondary phase resistance  
% invoke(MN6,'processCommand', 'REDIM LoadResistance()');                   
invoke(MN6,'processCommand', ['LoadResistance = ' num2str(resS) ]);                     
invoke(MN6,'processCommand','Call getDocument().setResistance("R10", LoadResistance)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R11", LoadResistance)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R12", LoadResistance)');

%% Mesh Control
invoke(MN6,'processCommand', ['tempP = ' num2str(genM) ]);                     
invoke(MN6,'processCommand','Call getDocument().setMaxElementSize("", tempP)');
invoke(MN6,'processCommand', ['tempP = ' num2str(coreM) ]);                     
invoke(MN6,'processCommand','Call getDocument().setMaxElementSize("Core", tempP)');

%% Solver Constraints
invoke(MN6,'processCommand','Call getDocument().setNumberOfMultiCoreSolveThreads(1)');
invoke(MN6,'processCommand','Call getDocument().setSolverMaterialType(infoNonlinearMaterial)');
invoke(MN6,'processCommand','Call getDocument().setCGTolerance(0.001)');
invoke(MN6,'processCommand','Call getDocument().setNewtonTolerance(0.001)');
invoke(MN6,'processCommand','Call getDocument().setMaxNumberOfNewtonIterations(50)');
invoke(MN6,'processCommand', ['tempP = ' num2str(freqF) ]);                     
invoke(MN6,'processCommand','Call getDocument().setSourceFrequency(tempP)');

%% Performing Solution

t_start = 0;
t_end = 1000*1/freqF;
t_step = t_end/tsteps;
t = t_start:t_step:t_end;

% Setting the parameters for the transient with motion simulation
% invoke(MN6,'processCommand', ['Call getDocument().setFixedIntervalTimeSteps(' num2str(t_start) ',' num2str(cycN*t_end) ',' num2str(t_step,'%10.10f') ')']);
invoke(MN6,'processCommand', ['Call getDocument().setFixedIntervalTimeSteps(' num2str(t_start) ',' num2str(cycN*t_end) ',' num2str(t_step) ')']);
invoke(MN6,'processCommand', ['Call getDocument().setParameter("", "SourcesOnAtTransientStart", "Yes", infoStringParameter)']);

% Setting start and ending time for the iron losses calculation
invoke(MN6,'processCommand', ['Call getDocument().setParameter("", "TransientAveragePowerLossStartTime", "' num2str((cycN-1)*t_end*1e-3) '", infoNumberParameter)']);
invoke(MN6,'processCommand', ['Call getDocument().setParameter("", "TransientAveragePowerLossEndTime", "' num2str(cycN*t_end*1e-3) '", infoNumberParameter)']);

% Solution
tic                                                                        % Starting the simulation time counter
invoke(MN6,'processCommand','CALL getDocument().solveTransient2d()');
SimulationTime = toc;                                                      % Ending the simulation time counter
% Display the simulation time 
disp(['Simulation time [s]: ',num2str(SimulationTime)]);