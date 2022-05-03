%% CIRCUIT CREATION

% Open new window to create the circuit
invoke(MN6,'processCommand','Call getDocument().newCircuitWindow()');

%% Inserting Resistors

% Secondary load resistors
% Placing the three resistors
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertResistor(550, 800)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertResistor(550, 1000)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertResistor(550, 1200)');
% Primary phase resistors
% Placing the three resistors
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertResistor(550, 100)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertResistor(550, 300)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertResistor(550, 500)');
% Primary damping resistors
% Placing the three resistors
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertResistor(750, 100)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertResistor(750, 300)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertResistor(750, 500)');
% Secondary phase resistors
% Placing the three resistors
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertResistor(350, 800)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertResistor(350, 1000)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertResistor(350, 1200)');

% Assigining default resistance values
invoke(MN6,'processCommand','Call getDocument().setResistance("R1", 1)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R2", 1)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R3", 1)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R4", 1)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R5", 1)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R6", 1)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R7", 1)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R8", 1)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R9", 1)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R10", 1)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R11", 1)');
invoke(MN6,'processCommand','Call getDocument().setResistance("R12", 1)');

%% Primary Winding

% Placing the three coils
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertCoil("PhaseAPrim", 350, 100)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertCoil("PhaseBPrim", 350, 300)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertCoil("PhaseCPrim", 350, 500)');

% Placing the three current sources
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertCurrentSource(150, 100)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertCurrentSource(150, 300)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertCurrentSource(150, 500)');

% Connecting the phase A current source with the phase A coil
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("I1,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseAPrim,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase B current source with the phase B coil
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("I2,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseBPrim,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase C current source with the phase C coil
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("I3,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseCPrim,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase A coil with the phase A resistor
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseAPrim,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R4,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase B coil with the phase B resistor
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseBPrim,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R5,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase C coil with the phase C resistor
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseCPrim,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R6,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase A resistor with the phase A damping resistor
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R7,T1", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R4,T2", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase B resistor with the phase B damping resistor
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R8,T1", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R5,T2", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase C resistor with the phase C damping resistor
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R9,T1", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R6,T2", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase A resistor with the phase A source (neutral point)
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R7,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("I1,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase B resistor with the phase B source (neutral point)
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R8,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("I2,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase C resistor with the phase C source (neutral point)
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R9,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("I3,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase A current source with the phase B current source (neutral point)
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("I1,T1", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("I2,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase B current source with the phase C current source (neutral point)
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("I2,T1", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("I3,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

%% Secondary Winding

% Placing the three coils
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertCoil("PhaseASec", 150, 800)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertCoil("PhaseBSec", 150, 1000)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertCoil("PhaseCSec", 150, 1200)');

% Connecting the phase A coil with the phase A phase resistor
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseASec,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R10,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase B coil with the phase B phase resistor
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseBSec,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R11,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase C coil with the phase C phase resistor
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseCSec,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R12,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase A phase resistor with the phase A load resistor
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R1,T1", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R10,T2", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase B phase resistor with the phase B load resistor
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R2,T1", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R11,T2", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase C phase resistor with the phase C load resistor
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R3,T1", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R12,T2", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase A coil with the phase B coil (neutral point)
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseASec,T1", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseBSec,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase B coil with the phase C coil (neutral point)
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseCSec,T1", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseBSec,T1", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase A load resistor with the phase B load resistor (neutral point)
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R1,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R2,T2", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% Connecting the phase B load resistor with the phase C load resistor (neutral point)
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R2,T2", TX1, TY1)');
invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R3,T2", TX2, TY2)');
invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');

% % Connecting the phase A load resistor with the phase A neutral
% invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R1,T2", TX1, TY1)');
% invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseASec,T1", TX2, TY2)');
% invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
% invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
% invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
% invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
% invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
% invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
% invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');
% 
% % Connecting the phase B load resistor with the phase B neutral
% invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R2,T2", TX1, TY1)');
% invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseBSec,T1", TX2, TY2)');
% invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
% invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
% invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
% invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
% invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
% invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
% invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');
% 
% % Connecting the phase C load resistor with the phase C neutral
% invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("R3,T2", TX1, TY1)');
% invoke(MN6,'processCommand','Call getDocument().getCircuit().getPositionOfTerminal("PhaseCSec,T1", TX2, TY2)');
% invoke(MN6,'processCommand', 'REDIM XArrayOfValues(1)');
% invoke(MN6,'processCommand','XArrayOfValues(0)= TX1');
% invoke(MN6,'processCommand','XArrayOfValues(1)= TX2');
% invoke(MN6,'processCommand', 'REDIM YArrayOfValues(1)');
% invoke(MN6,'processCommand','YArrayOfValues(0)= TY1');
% invoke(MN6,'processCommand','YArrayOfValues(1)= TY2');
% invoke(MN6,'processCommand','Call getDocument().getCircuit().insertConnection(XArrayOfValues, YArrayOfValues)');