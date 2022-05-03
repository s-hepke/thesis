tic

IDnumber = 1;

%% Full analysis result extraction

t = t_start:t_step:cycN*t_end;

invoke(MN6, 'processCommand', 'Set Sol = getDocument.getSolution');

for i = 1 : IDnumber
    for j = 1 : length(t)
        %% Current Extraction
        %%% Primary
        % Reading the phase A current values    
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getCurrentThroughCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseAPrim", MagnitudeIA)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeIA)');
        Ip1.iap(j,i)= invoke(MN6, 'getVariant', 0);
        % Reading the phase B current values
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getCurrentThroughCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseBPrim", MagnitudeIB)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeIB)');
        Ip1.ibp(j,i)= invoke(MN6, 'getVariant', 0);
        % Reading the phase C current values
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getCurrentThroughCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseCPrim", MagnitudeIC)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeIC)');     
        Ip1.icp(j,i)= invoke(MN6, 'getVariant', 0);
        %%% Secondary
        % Reading the phase A current values    
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getCurrentThroughCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseASec", MagnitudeIA)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeIA)');
        Ip1.ias(j,i)= invoke(MN6, 'getVariant', 0);
        % Reading the phase B current values
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getCurrentThroughCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseBSec", MagnitudeIB)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeIB)');
        Ip1.ibs(j,i)= invoke(MN6, 'getVariant', 0);
        % Reading the phase C current values
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getCurrentThroughCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseCSec", MagnitudeIC)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeIC)');     
        Ip1.ics(j,i)= invoke(MN6, 'getVariant', 0); 
        %% Flux Extraction
        %%% Primary
        % Reading the phase A flux values  
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getFluxLinkageThroughCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseAPrim", MagnitudeFA, PhaseFA)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeFA)');
        Fp.fap(j,i)= invoke(MN6, 'getVariant', 0);
        % Reading the phase B flux values      
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getFluxLinkageThroughCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseBPrim", MagnitudeFB, PhaseFB)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeFB)');
        Fp.fbp(j,i)= invoke(MN6, 'getVariant', 0);
        % Reading the phase C flux values      
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getFluxLinkageThroughCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseCPrim", MagnitudeFC, PhaseFC)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeFC)');
        Fp.fcp(j,i)= invoke(MN6, 'getVariant', 0);
        %%% Secondary
        % Reading the phase A flux values  
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getFluxLinkageThroughCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseASec", MagnitudeFA, PhaseFA)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeFA)');
        Fp.fas(j,i)= invoke(MN6, 'getVariant', 0);
        % Reading the phase B flux values      
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getFluxLinkageThroughCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseBSec", MagnitudeFB, PhaseFB)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeFB)');
        Fp.fbs(j,i)= invoke(MN6, 'getVariant', 0);
        % Reading the phase C flux values      
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getFluxLinkageThroughCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseCSec", MagnitudeFC, PhaseFC)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeFC)');
        Fp.fcs(j,i)= invoke(MN6, 'getVariant', 0);
        %% Voltage Extraction
        %%% Primary
        % Reading the phase A voltage values 
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getVoltageAcrossCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseAPrim", MagnitudeVA, PhaseVA)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeVA)');
        Ep.eap(j,i)= invoke(MN6, 'getVariant', 0);
        % Reading the phase B voltage values      
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getVoltageAcrossCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseBPrim", MagnitudeVB, PhaseVB)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeVB)');
        Ep.ebp(j,i)= invoke(MN6, 'getVariant', 0);
        % Reading the phase C voltage values      
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getVoltageAcrossCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseCPrim", MagnitudeVC, PhaseVC)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeVC)');
        Ep.ecp(j,i)= invoke(MN6, 'getVariant', 0);
        %%% Secondary
        % Reading the phase A voltage values 
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getVoltageAcrossCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseASec", MagnitudeVA, PhaseVA)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeVA)');
        Ep.eas(j,i)= invoke(MN6, 'getVariant', 0);
        % Reading the phase B voltage values      
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getVoltageAcrossCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseBSec", MagnitudeVB, PhaseVB)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeVB)');
        Ep.ebs(j,i)= invoke(MN6, 'getVariant', 0);
        % Reading the phase C voltage values      
        invoke(MN6,'processCommand',['Call getDocument().getSolution().getVoltageAcrossCoil(Array(' num2str(i) ',' num2str(t(j)) '), "PhaseCSec", MagnitudeVC, PhaseVC)']);
        invoke(MN6, 'processCommand', 'Call setVariant(0,MagnitudeVC)');
        Ep.ecs(j,i)= invoke(MN6, 'getVariant', 0);
        %% Copper Loss Extraction
        % Getting Joule losses in Phase A1
        invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getOhmicLossInConductor(Array(' num2str(i) ',' num2str(t(j)) '),"primA1"))']);
        Cul.cupa1(j,i)= invoke(MN6, 'getVariant', 0);            % Vector of the Joule losses in the internal slots for double layer winding
        % Getting Joule losses in Phase A2              
        invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getOhmicLossInConductor(Array(' num2str(i) ',' num2str(t(j)) '),"primA2"))']);
        Cul.cupa2(j,i)= invoke(MN6, 'getVariant', 0);            % Vector of the Joule losses in the internal slots for double layer winding
        % Getting Joule losses in Phase A1               
        invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getOhmicLossInConductor(Array(' num2str(i) ',' num2str(t(j)) '),"secA1"))']);
        Cul.cusa1(j,i)= invoke(MN6, 'getVariant', 0);            % Vector of the Joule losses in the internal slots for double layer winding
        % Getting Joule losses in Phase A2
        invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getOhmicLossInConductor(Array(' num2str(i) ',' num2str(t(j)) '),"secA2"))']);
        Cul.cusa2(j,i)= invoke(MN6, 'getVariant', 0);            % Vector of the Joule losses in the internal slots for double layer winding
        % Getting Joule losses in Phase B1               
        invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getOhmicLossInConductor(Array(' num2str(i) ',' num2str(t(j)) '),"primB1"))']);
        Cul.cupb1(j,i)= invoke(MN6, 'getVariant', 0);            % Vector of the Joule losses in the internal slots for double layer winding
        % Getting Joule losses in Phase B2               
        invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getOhmicLossInConductor(Array(' num2str(i) ',' num2str(t(j)) '),"primB2"))']);
        Cul.cupb2(j,i)= invoke(MN6, 'getVariant', 0);            % Vector of the Joule losses in the internal slots for double layer winding
        % Getting Joule losses in Phase B1
        invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getOhmicLossInConductor(Array(' num2str(i) ',' num2str(t(j)) '),"secB1"))']);
        Cul.cusb1(j,i)= invoke(MN6, 'getVariant', 0);            % Vector of the Joule losses in the internal slots for double layer winding
        % Getting Joule losses in Phase B2              
        invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getOhmicLossInConductor(Array(' num2str(i) ',' num2str(t(j)) '),"secB2"))']);
        Cul.cusb2(j,i)= invoke(MN6, 'getVariant', 0);            % Vector of the Joule losses in the internal slots for double layer winding
        % Getting Joule losses in Phase C1               
        invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getOhmicLossInConductor(Array(' num2str(i) ',' num2str(t(j)) '),"primC1"))']);
        Cul.cupc1(j,i)= invoke(MN6, 'getVariant', 0);            % Vector of the Joule losses in the internal slots for double layer winding
        % Getting Joule losses in Phase C2
        invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getOhmicLossInConductor(Array(' num2str(i) ',' num2str(t(j)) '),"primC2"))']);
        Cul.cupc2(j,i)= invoke(MN6, 'getVariant', 0);            % Vector of the Joule losses in the internal slots for double layer winding
        % Getting Joule losses in Phase C1               
        invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getOhmicLossInConductor(Array(' num2str(i) ',' num2str(t(j)) '),"secC1"))']);
        Cul.cusc1(j,i)= invoke(MN6, 'getVariant', 0);            % Vector of the Joule losses in the internal slots for double layer winding
        % Getting Joule losses in Phase C2               
        invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getOhmicLossInConductor(Array(' num2str(i) ',' num2str(t(j)) '),"secC2"))']);
        Cul.cusc2(j,i)= invoke(MN6, 'getVariant', 0);            % Vector of the Joule losses in the internal slots for double layer winding
        %% Flux Density Extraction
        invoke(MN6, 'processCommand', ['Set Mesh = Sol.getMesh(Array(' num2str(i) ',' num2str(t(j)) '))']);
        invoke(MN6, 'processCommand', 'Set FieldB = Sol.getSystemField(Mesh, "|B| smoothed")');
        invoke(MN6, 'processCommand', 'Set FieldBx = Sol.getSystemField(Mesh, "B x smoothed")');
        invoke(MN6, 'processCommand', 'Set FieldBy = Sol.getSystemField(Mesh, "B y smoothed")');
        invoke(MN6, 'processCommand', 'ReDim FieldValB(0)');
        invoke(MN6, 'processCommand', 'ReDim FieldValBx(0)');
        invoke(MN6, 'processCommand', 'ReDim FieldValBy(0)');
        % Fixed point - 1 - at the centre of limb with phase A
        x = 0;
        y = (coreW+windowH/2);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        B.Blp1(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        B.Bxlp1(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        B.Bylp1(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
        % Fixed point - 2 - at the centre of limb with phase B
        x = windowW+coreW;
        y = (coreW+windowH/2);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        B.Blp2(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        B.Bxlp2(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        B.Bylp2(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
        % Fixed point - 3 - at the centre of limb with phase C
        x = -(windowW+coreW);
        y = (coreW+windowH/2);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        B.Blp3(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        B.Bxlp3(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        B.Bylp3(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
        % Fixed point - 4 - at the centre of limb top left
        x = -(windowW/2+coreW/2);
        y = (3*coreW/2+windowH);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        B.Blp4(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        B.Bxlp4(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        B.Bylp4(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
        % Fixed point - 5 - at the centre of limb bottom left
        x = -(windowW/2+coreW/2);
        y = (coreW/2);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        B.Blp5(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        B.Bxlp5(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        B.Bylp5(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
        % Fixed point - 6 - at the centre of limb bottom right
        x = (windowW/2+coreW/2);
        y = (coreW/2);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        B.Blp6(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        B.Bxlp6(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        B.Bylp6(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
        % Fixed point - 7 - at the centre of limb bottom right
        x = (windowW/2+coreW/2);
        y = (3*coreW/2+windowH);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        B.Blp7(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        B.Bxlp7(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        B.Bylp7(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
    end
end

%% Last cycle result extraction

t = (cycN-1)*t_end:t_step:cycN*t_end;

invoke(MN6, 'processCommand', 'Set Sol = getDocument.getSolution');

for i = 1 : IDnumber
    for j = 1 : length(t)
        %% Flux Density Extraction
        invoke(MN6, 'processCommand', ['Set Mesh = Sol.getMesh(Array(' num2str(i) ',' num2str(t(j)) '))']);
        invoke(MN6, 'processCommand', 'Set FieldB = Sol.getSystemField(Mesh, "|B| smoothed")');
        invoke(MN6, 'processCommand', 'Set FieldBx = Sol.getSystemField(Mesh, "B x smoothed")');
        invoke(MN6, 'processCommand', 'Set FieldBy = Sol.getSystemField(Mesh, "B y smoothed")');
        invoke(MN6, 'processCommand', 'ReDim FieldValB(0)');
        invoke(MN6, 'processCommand', 'ReDim FieldValBx(0)');
        invoke(MN6, 'processCommand', 'ReDim FieldValBy(0)');
        % Fixed point - 1 - at the centre of limb with phase A
        x = 0;
        y = (coreW+windowH/2);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        Bf.Blp1(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        Bf.Bxlp1(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        Bf.Bylp1(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
        % Fixed point - 2 - at the centre of limb with phase B
        x = windowW+coreW;
        y = (coreW+windowH/2);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        Bf.Blp2(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        Bf.Bxlp2(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        Bf.Bylp2(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
        % Fixed point - 3 - at the centre of limb with phase C
        x = -(windowW+coreW);
        y = (coreW+windowH/2);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        Bf.Blp3(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        Bf.Bxlp3(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        Bf.Bylp3(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
        % Fixed point - 4 - at the centre of limb top left
        x = -(windowW/2+coreW/2);
        y = (3*coreW/2+windowH);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        Bf.Blp4(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        Bf.Bxlp4(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        Bf.Bylp4(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
        % Fixed point - 5 - at the centre of limb bottom left
        x = -(windowW/2+coreW/2);
        y = (coreW/2);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        Bf.Blp5(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        Bf.Bxlp5(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        Bf.Bylp5(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
        % Fixed point - 6 - at the centre of limb bottom right
        x = (windowW/2+coreW/2);
        y = (coreW/2);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        Bf.Blp6(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        Bf.Bxlp6(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        Bf.Bylp6(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
        % Fixed point - 7 - at the centre of limb bottom right
        x = (windowW/2+coreW/2);
        y = (3*coreW/2+windowH);
        % Getting the amplitude of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldB.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValB)']);
        invoke(MN6, 'processCommand', 'call setVariant(21,FieldValB(0),"MATLAB")');
        Bf.Blp7(j,i)= invoke(MN6, 'getVariant', 21, 'MATLAB');
        % Getting the x-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBx.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBx)']);
        invoke(MN6, 'processCommand', 'call setVariant(22,FieldValBx(0),"MATLAB")');
        Bf.Bxlp7(j,i)= invoke(MN6, 'getVariant', 22, 'MATLAB');
        % Getting the y-axis component of the smoothed flux density vector
        invoke(MN6, 'processCommand', ['Call FieldBy.getFieldAtPoint(' num2str(x) ', ' num2str(y) ', 0 ,FieldValBy)']);
        invoke(MN6, 'processCommand', 'call setVariant(23,FieldValBy(0),"MATLAB")');
        Bf.Bylp7(j,i)= invoke(MN6, 'getVariant', 23, 'MATLAB');
    end
end


%% Resistance and iron losses extraction

for j = 1 : IDnumber
    %% Resistance Extraction
    %%% Primary
    % Getting phase A resistance
    invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getDCResistanceOfCoil(' num2str(j) ', "PhaseAPrim"))']);
    Res.Rap(j) = invoke(MN6, 'getVariant', 0);                                  % Phase A resistance [Ohm]
    % Getting phase B resistance    
    invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getDCResistanceOfCoil(' num2str(j) ', "PhaseBPrim"))']);
    Res.Rbp(j) = invoke(MN6, 'getVariant', 0);                                  % Phase B resistance [Ohm]
    % Getting phase C resistance    
    invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getDCResistanceOfCoil(' num2str(j) ', "PhaseCPrim"))']);
    Res.Rcp(j) = invoke(MN6, 'getVariant', 0); 
    %%% Secondary
    % Getting phase A resistance
    invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getDCResistanceOfCoil(' num2str(j) ', "PhaseASec"))']);
    Res.Ras(j) = invoke(MN6, 'getVariant', 0);                                  % Phase A resistance [Ohm]
    % Getting phase B resistance    
    invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getDCResistanceOfCoil(' num2str(j) ', "PhaseBSec"))']);
    Res.Rbs(j) = invoke(MN6, 'getVariant', 0);                                  % Phase B resistance [Ohm]
    % Getting phase C resistance    
    invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getDCResistanceOfCoil(' num2str(j) ', "PhaseCSec"))']);
    Res.Rcs(j) = invoke(MN6, 'getVariant', 0); 
    %% Core Iron Losses
    invoke(MN6,'processCommand',['CALL setVariant(0,getDocument().getSolution().getIronLossInComponent(' num2str(j) ',"Core",IronLossesStator))']);
    invoke(MN6, 'processCommand', 'Call setVariant(0,IronLossesStator)');
    Pfe_core(:,:,j)= invoke(MN6, 'getVariant', 0);
end
Pfe_core = cell2mat(Pfe_core);

%% Result compilation
Results.Bpeak = mean(max([Bf.Blp1,Bf.Blp2,Bf.Blp3]));
Results.BpeakA = mean(max([Bf.Blp1,Bf.Blp2,Bf.Blp3,Bf.Blp4,Bf.Blp5,Bf.Blp6,Bf.Blp7]));
Results.Brms = Results.Bpeak/sqrt(2);
Results.Pfe_core = Pfe_core(1,1);
Results.Bmax = max(max([Bf.Blp1,Bf.Blp2,Bf.Blp3,Bf.Blp4,Bf.Blp5,Bf.Blp6,Bf.Blp7]));

SimulationTime = toc;                                                      % Ending the simulation time counter
% Display the simulation time 
disp(['Post processing time [s]: ',num2str(SimulationTime)]);