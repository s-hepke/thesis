%% Details
% All dimensions are in mm
% All dimensions are in deg
% All dimensions are in Hz
% All currents are in A
% All voltages are in V

%% Define Inputs

%% Core Dimensions
stackL = Core_d;
windowH = Window_h;
windowW = Window_w;
coreW = Core_a;

%% Airbox Bounding/Scaling Factor  ************* DO NOT CHANGE *************
airbox = 20;

%% Insulation and Winding Data
coreI = dins_cp_paper;
prim2secI = dins_prisec_paper;

primT = N1;
primC = NewAcp;
secT = N2;
secC = NewAcs;

%% Winding Electrical Data
primV = Vpn;
primI = Ip;
XmerR = secT/primT;
secV = XmerR*primV;
secI = primI/XmerR;
resP = Rp_ac;
resS = Rs_ac;
freqF = fsw;
typeA = 2;                                                                 % 0 - OC Test
                                                                           % 1 - SC Test
                                                                           % 2 - FL Test
if typeA == 0
    loadR = 1e9;
elseif typeA == 1
    loadR = 0.1;
elseif typeA == 2;
    loadR = secV/secI;
else
    loadR = 1e9;
end
dampR = (primV/primI);
Bref = Bm;

%% Mesh Details ************* DO NOT CHANGE *************
genM = windowH/10;
coreM = windowH/50;

tsteps = 200;
excS = 0;                                                                  
cycN = 02;
dampC = 2;

%% Winding Excitation
ex_c = 0;                                                                  % 0 - Sine Wave Excitation
                                                                           % 1 - Peicewise Linear Excitation (any waveform)
if ex_c == 0                                        
elseif ex_c == 1
    load ex_w;
%     tsteps = length(ex_w);
end

magste = 200;

%% Extension - Winding Arrangement