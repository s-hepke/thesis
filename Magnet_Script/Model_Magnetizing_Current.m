%% New Magnetizing Current File
Model_Inputs;
Model_Materials;
Model_Drawing;
Model_Excitation;

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

%% Primary Winding Excitation
for i = 1:1:magste
        Imag = i*primI/magste;
        
        %% Zero Angle
        
%         invoke(MN6,'processCommand', 'Call getDocument().setParameter("PhaseBPrim", "WaveFormType", "ACDC", infoStringParameter)');
%         invoke(MN6,'processCommand', 'Call getDocument().setParameter("PhaseBPrim", "Current", "5", infoNumberParameter)');
%         invoke(MN6,'processCommand', 'Call getDocument().setParameter("PhaseBPrim", "CurrentPhase", "0%deg", infoNumberParameter)');
        % Setting the phase A current waveform parameters 
        invoke(MN6,'processCommand', 'Call getDocument().setParameter("PhaseAPrim", "WaveFormType", "DC", infoStringParameter)');
        invoke(MN6,'processCommand', ['Call getDocument().setParameter("PhaseAPrim", "Current", "', num2str(Imag*0), '", infoNumberParameter)']);
        % Setting the phase B current waveform parameters 
        invoke(MN6,'processCommand', 'Call getDocument().setParameter("PhaseBPrim", "WaveFormType", "DC", infoStringParameter)');
        invoke(MN6,'processCommand', ['Call getDocument().setParameter("PhaseBPrim", "Current", "', num2str(Imag*sind(120)*sqrt(2)), '", infoNumberParameter)']);
        % Setting the phase C current waveform parameters 
        invoke(MN6,'processCommand', 'Call getDocument().setParameter("PhaseCPrim", "WaveFormType", "DC", infoStringParameter)');
        invoke(MN6,'processCommand', ['Call getDocument().setParameter("PhaseCPrim", "Current", "', num2str(Imag*sind(240)*sqrt(2)), '", infoNumberParameter)']);

        %% Performing Solution

        % Solution
%         tic                                                                        % Starting the simulation time counter
        invoke(MN6,'processCommand','CALL getDocument().solveStatic2d()');
%         SimulationTime = toc;                                                      % Ending the simulation time counter
%         % Display the simulation time 
%         disp(['Simulation time [s]: ',num2str(SimulationTime)]);
        
        IDnumber = 1;
        
        invoke(MN6, 'processCommand', 'Set Sol = getDocument.getSolution');
        invoke(MN6, 'processCommand', ['Set Mesh = Sol.getMesh( ' num2str(IDnumber) ')']);
        invoke(MN6, 'processCommand', 'Set FieldB = Sol.getSystemField(Mesh, "|B| smoothed")');
        invoke(MN6, 'processCommand', 'Set FieldBx = Sol.getSystemField(Mesh, "B x smoothed")');
        invoke(MN6, 'processCommand', 'Set FieldBy = Sol.getSystemField(Mesh, "B y smoothed")');
        invoke(MN6, 'processCommand', 'ReDim FieldValB(0)');
        invoke(MN6, 'processCommand', 'ReDim FieldValBx(0)');
        invoke(MN6, 'processCommand', 'ReDim FieldValBy(0)');        
        % Getting the amplitude of the smoothed flux density vector - 1
        x = 0;
        y = (coreW+windowH/2);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm0.B(i,1)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm0.Bx(i,1)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm0.By(i,1)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the amplitude of the smoothed flux density vector - 2
        x = windowW+coreW;
        y = (coreW+windowH/2);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm0.B(i,2)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm0.Bx(i,2)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm0.By(i,2)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the amplitude of the smoothed flux density vector - 3
        x = -(windowW+coreW);
        y = (coreW+windowH/2);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm0.B(i,3)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm0.Bx(i,3)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm0.By(i,3)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the amplitude of the smoothed flux density vector - 4
        x = -(windowW/2+coreW/2);
        y = (3*coreW/2+windowH);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm0.B(i,4)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm0.Bx(i,4)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm0.By(i,4)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the amplitude of the smoothed flux density vector - 5
        x = -(windowW/2+coreW/2);
        y = (coreW/2);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm0.B(i,5)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm0.Bx(i,5)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm0.By(i,5)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the amplitude of the smoothed flux density vector - 6
        x = (windowW/2+coreW/2);
        y = (coreW/2);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm0.B(i,6)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm0.Bx(i,6)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm0.By(i,6)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the amplitude of the smoothed flux density vector - 7
        x = (windowW/2+coreW/2);
        y = (3*coreW/2+windowH);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm0.B(i,7)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm0.Bx(i,7)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm0.By(i,7)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        Bm.max1 = max(Bm.Bm0.B(i,:));
        
        %% Maximum Current Angle
        
%         invoke(MN6,'processCommand', 'Call getDocument().setParameter("PhaseBPrim", "WaveFormType", "ACDC", infoStringParameter)');
%         invoke(MN6,'processCommand', 'Call getDocument().setParameter("PhaseBPrim", "Current", "5", infoNumberParameter)');
%         invoke(MN6,'processCommand', 'Call getDocument().setParameter("PhaseBPrim", "CurrentPhase", "0%deg", infoNumberParameter)');
        % Setting the phase A current waveform parameters 
        invoke(MN6,'processCommand', 'Call getDocument().setParameter("PhaseAPrim", "WaveFormType", "DC", infoStringParameter)');
        invoke(MN6,'processCommand', ['Call getDocument().setParameter("PhaseAPrim", "Current", "', num2str(Imag*sind(90)*sqrt(2)), '", infoNumberParameter)']);
        % Setting the phase B current waveform parameters 
        invoke(MN6,'processCommand', 'Call getDocument().setParameter("PhaseBPrim", "WaveFormType", "DC", infoStringParameter)');
        invoke(MN6,'processCommand', ['Call getDocument().setParameter("PhaseBPrim", "Current", "', num2str(Imag*sind(120+90)*sqrt(2)), '", infoNumberParameter)']);
        % Setting the phase C current waveform parameters 
        invoke(MN6,'processCommand', 'Call getDocument().setParameter("PhaseCPrim", "WaveFormType", "DC", infoStringParameter)');
        invoke(MN6,'processCommand', ['Call getDocument().setParameter("PhaseCPrim", "Current", "', num2str(Imag*sind(240+90)*sqrt(2)), '", infoNumberParameter)']);

        %% Performing Solution

        % Solution
%         tic                                                                        % Starting the simulation time counter
        invoke(MN6,'processCommand','CALL getDocument().solveStatic2d()');
%         SimulationTime = toc;                                                      % Ending the simulation time counter
%         % Display the simulation time 
%         disp(['Simulation time [s]: ',num2str(SimulationTime)]);
        
        IDnumber = 1;
        
        invoke(MN6, 'processCommand', 'Set Sol = getDocument.getSolution');
        invoke(MN6, 'processCommand', ['Set Mesh = Sol.getMesh( ' num2str(IDnumber) ')']);
        invoke(MN6, 'processCommand', 'Set FieldB = Sol.getSystemField(Mesh, "|B| smoothed")');
        invoke(MN6, 'processCommand', 'Set FieldBx = Sol.getSystemField(Mesh, "B x smoothed")');
        invoke(MN6, 'processCommand', 'Set FieldBy = Sol.getSystemField(Mesh, "B y smoothed")');
        invoke(MN6, 'processCommand', 'ReDim FieldValB(0)');
        invoke(MN6, 'processCommand', 'ReDim FieldValBx(0)');
        invoke(MN6, 'processCommand', 'ReDim FieldValBy(0)');        
        % Getting the amplitude of the smoothed flux density vector - 1
        x = 0;
        y = (coreW+windowH/2);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm1.B(i,1)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm1.Bx(i,1)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm1.By(i,1)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the amplitude of the smoothed flux density vector - 2
        x = windowW+coreW;
        y = (coreW+windowH/2);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm1.B(i,2)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm1.Bx(i,2)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm1.By(i,2)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the amplitude of the smoothed flux density vector - 3
        x = -(windowW+coreW);
        y = (coreW+windowH/2);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm1.B(i,3)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm1.Bx(i,3)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm1.By(i,3)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the amplitude of the smoothed flux density vector - 4
        x = -(windowW/2+coreW/2);
        y = (3*coreW/2+windowH);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm1.B(i,4)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm1.Bx(i,4)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm1.By(i,4)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the amplitude of the smoothed flux density vector - 5
        x = -(windowW/2+coreW/2);
        y = (coreW/2);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm1.B(i,5)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm1.Bx(i,5)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm1.By(i,5)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the amplitude of the smoothed flux density vector - 6
        x = (windowW/2+coreW/2);
        y = (coreW/2);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm1.B(i,6)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm1.Bx(i,6)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm1.By(i,6)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the amplitude of the smoothed flux density vector - 7
        x = (windowW/2+coreW/2);
        y = (3*coreW/2+windowH);
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValB(0),"MATLAB")');
        Bm.Bm1.B(i,7)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBx(0),"MATLAB")');
        Bm.Bm1.Bx(i,7)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector    
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(0,FieldValBy(0),"MATLAB")');
        Bm.Bm1.By(i,7)= invoke(MN6, 'getVariant', 0, 'MATLAB');
        Bm.max2 = max(Bm.Bm1.B(i,:));

        %% Check for correct magnetizing current
        Bm.max = max(Bm.max1,Bm.max2);
        if Bm.max-Results.Bmax >= 0
            disp(['Magnetizing Current = ',num2str(Imag)]);
            break
        end
%         if Bm.max-Bref*sqrt(2) >= 0
%             disp(['Magnetizing Current = ',num2str(Imag)]);
%             break
%         end
end