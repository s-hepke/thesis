%% Creating Coils
invoke(MN6, 'processCommand',['ReDim PhaseANames1(' num2str(1) ')']);
invoke(MN6, 'processCommand',['ReDim PhaseBNames1(' num2str(1) ')']);
invoke(MN6, 'processCommand',['ReDim PhaseCNames1(' num2str(1) ')']);
invoke(MN6, 'processCommand',['ReDim PhaseANames2(' num2str(1) ')']);
invoke(MN6, 'processCommand',['ReDim PhaseBNames2(' num2str(1) ')']);
invoke(MN6, 'processCommand',['ReDim PhaseCNames2(' num2str(1) ')']);
for i = 1:1:2
    % Phase A Coil
    PhaseANames = ['primA',num2str(i)];
    invoke(MN6, 'processCommand',['PhaseANames1(' num2str(i-1) ') = "' num2str(PhaseANames) '"']);   % Vector including the phase A coil names
    PhaseANames = ['secA',num2str(i)];
    invoke(MN6, 'processCommand',['PhaseANames2(' num2str(i-1) ') = "' num2str(PhaseANames) '"']);   % Vector including the phase A coil names
    % Phase B Coil
    PhaseBNames = ['primB',num2str(i)];
    invoke(MN6, 'processCommand',['PhaseBNames1(' num2str(i-1) ') = "' num2str(PhaseBNames) '"']);   % Vector including the phase A coil names
    PhaseBNames = ['secB',num2str(i)];
    invoke(MN6, 'processCommand',['PhaseBNames2(' num2str(i-1) ') = "' num2str(PhaseBNames) '"']);   % Vector including the phase A coil names
    % Phase C Coil
    PhaseCNames = ['primC',num2str(i)];
    invoke(MN6, 'processCommand',['PhaseCNames1(' num2str(i-1) ') = "' num2str(PhaseCNames) '"']);   % Vector including the phase A coil names
    PhaseCNames = ['secC',num2str(i)];
    invoke(MN6, 'processCommand',['PhaseCNames2(' num2str(i-1) ') = "' num2str(PhaseCNames) '"']);   % Vector including the phase A coil names
end
% Phase A Coil
invoke(MN6, 'processCommand',['CALL getDocument().makeSimpleCoil(1, PhaseANames1)']);
invoke(MN6, 'processCommand',['CALL getDocument().renameObject("Coil#1", "PhaseAPrim")']);
invoke(MN6, 'processCommand',['CALL getDocument().makeSimpleCoil(1, PhaseANames2)']);
invoke(MN6, 'processCommand',['CALL getDocument().renameObject("Coil#2", "PhaseASec")']);
% Phase B Coil
invoke(MN6, 'processCommand',['CALL getDocument().makeSimpleCoil(1, PhaseBNames1)']);
invoke(MN6, 'processCommand',['CALL getDocument().renameObject("Coil#3", "PhaseBPrim")']);
invoke(MN6, 'processCommand',['CALL getDocument().makeSimpleCoil(1, PhaseBNames2)']);
invoke(MN6, 'processCommand',['CALL getDocument().renameObject("Coil#4", "PhaseBSec")']);
% Phase C Coil
invoke(MN6, 'processCommand',['CALL getDocument().makeSimpleCoil(1, PhaseCNames1)']);
invoke(MN6, 'processCommand',['CALL getDocument().renameObject("Coil#5", "PhaseCPrim")']);
invoke(MN6, 'processCommand',['CALL getDocument().makeSimpleCoil(1, PhaseCNames2)']);
invoke(MN6, 'processCommand',['CALL getDocument().renameObject("Coil#6", "PhaseCSec")']);

% Phase A Turns
invoke(MN6, 'processCommand',['Call getDocument().setCoilNumberOfTurns("PhaseAPrim", ' num2str(primT) ')']);
invoke(MN6, 'processCommand',['Call getDocument().setParameter("PhaseAPrim", "StrandArea", "' num2str(primC/1000000) '", infoNumberParameter)']);

invoke(MN6, 'processCommand',['Call getDocument().setCoilNumberOfTurns("PhaseBPrim", ' num2str(primT) ')']);
invoke(MN6, 'processCommand',['Call getDocument().setParameter("PhaseBPrim", "StrandArea", "' num2str(primC/1000000) '", infoNumberParameter)']);

invoke(MN6, 'processCommand',['Call getDocument().setCoilNumberOfTurns("PhaseCPrim", ' num2str(primT) ')']);
invoke(MN6, 'processCommand',['Call getDocument().setParameter("PhaseCPrim", "StrandArea", "' num2str(primC/1000000) '", infoNumberParameter)']);

invoke(MN6, 'processCommand',['Call getDocument().setCoilNumberOfTurns("PhaseASec", ' num2str(secT) ')']);
invoke(MN6, 'processCommand',['Call getDocument().setParameter("PhaseASec", "StrandArea", "' num2str(secC/1000000) '", infoNumberParameter)']);

invoke(MN6, 'processCommand',['Call getDocument().setCoilNumberOfTurns("PhaseBSec", ' num2str(secT) ')']);
invoke(MN6, 'processCommand',['Call getDocument().setParameter("PhaseBSec", "StrandArea", "' num2str(secC/1000000) '", infoNumberParameter)']);

invoke(MN6, 'processCommand',['Call getDocument().setCoilNumberOfTurns("PhaseCSec", ' num2str(secT) ')']);
invoke(MN6, 'processCommand',['Call getDocument().setParameter("PhaseCSec", "StrandArea", "' num2str(secC/1000000) '", infoNumberParameter)']);