
% MF Frequency Transformer for 3 DAB DC-DC Converter

%% DC-DC converter parameters 
Vin_dc = 1.1e3;                                                             % DC input voltage [V] 
Vout_dc = 22e3;                                                             % DC output voltage [V]
Pin = 5e6;                                                                  % Converter rating power [W]
fsw = 2000;                                                                 % operating frequency [Hz]
degrees = -180:1:300;
omega=2*pi*fsw;
radians = degrees*(pi/180);
phaseAngle = radians;

delta = 1;                                                                      % dc conversion ratio
theta = pi/2;                                                               % phase shift angle 
L = 0.636e-3;                                                               % fundamental leakage inductance [H]
Eeff = 0.98;                                                                % expected efficiency 
Duty = 0.5;                                                                 % Duty cycle
%Et = 0.45*sqrt(4000);                                                       % Voltage per turns
% N1 = Vpn/Et = 89.9.. 
Nt = 1.1/22;                                                                % Turn ratio

%% Calculation V, I and St for star-star connection transformer 
%Vpn = (1.1*sqrt(3)/3)*Vin_dc;
Vpn = Vin_dc/sqrt(3);
Vsn = Vpn/Nt;
St = Pin/Eeff;                                                              % apparent transformer power [W]

BaseCurrent = Vin_dc/(3*omega*L);
Ip = St/(3*Vpn);
%Ip = LVCurrent(phaseAngle,BaseCurrent,theta,delta);

Is = Ip*Nt;

%% Transformer parameters 
Bm = 1.41;                                                                   % Peak flux density [T]
N1 = 11;                                                                    % Number of primary winding turns
N2_cal = N1/Nt;                                                                 % Numer of secondary widing turns
N2 = 220;           
Et = Vpn/N1;                                                                % Voltage per turns

Kf = 4.44;                                                                     % Waveform coefficient, squre wave=4, sine wave=4.44
Ku = 0.4;                                                                   % Window utilization factor 
Jp_e = 6;                                                                   % assumed current density of primary for oil cooling [A/mm^2] 
Js_e = 6;                                                                  % assumed current density of secondary for oil cooling [A/mm^2]

hw_ratio = 2.5;                                                             % Core_d and Core_a ratio
da_ratio = 1.2;                                                             % Window_w and Core_a ratio                             
                                                            

%% Core material parameters 
%- Metglas 2605SA1 amorphous alloy for MF
Core_th = 0.018;                                                            % lamination thickness [mm]
K_core = 0.75;                                                              % core stacking factor 
Den_core = 7290;                                                            % density of core [kg/m^3]

% USS Transformer 72-29 gage
kh = 0.00336922369454695;
alpha_m19 = 1.30103359460677;
belta_m19 = 2.13595976775746;
Den_m19 = 7290;

%% Copper parameters
Rho = 1.678e-8;                                                             % the resistivity of conductor in ohm.m
%Rho = 1.8e-8;
Mu0 = 4*pi*10^-7;                
Mur = 0.999991;
Mu = Mu0*Mur;                                                               % the absolute magnetic permeability of the conductor

%% Insulation material parameters 
%Eins_gf = 24;                                                              % Dielectric strength of glass fiber [kV/mm]
Eins_pap = 24;                                                             % Dielectric strength of paper [kV/mm]
S_1 = 1.5;                                                                    % safe factor#1 
S_2 = 1.5;                                                                    % safe factor#2


%% Core design 
%Ac = (Vpn*1e6)/(Kf*Bm*N1*fsw);                                             % Calculation core sectional area [mm^2]
Ac = 1e6*(Et/(Kf*fsw)/Bm);
                                                    

Core_a = sqrt(Ac/da_ratio);                                                 % width of core sectional area [m] 
Core_d = Ac/Core_a;                                                         % length of core sectional area [mm]


%% Winding design 
% Calculation conductor area
[AWG_primary, diameterConductor_primary, Rconductor_primary, AreaConductor_primary] = PrimaryCopperAWG(Ip, Jp_e);  % Selection AWG size - from HV,LV copper AWG functions

[AWG_secondary, diameterConductor_secondary, Rconductor_secondary, AreaConductor_secondary] = SecondaryCopperAWG(Is, Js_e);


%% Calculation Effective Skin depth 
SkinDepth = sqrt(Rho/(pi*fsw*Mu))*1000;


%% Calculation conductor areas
NewAcp = (pi*diameterConductor_primary^2)/4;                                % New primary conductor cross section [mm^2] 
NewJp = Ip/NewAcp;                                                          % New current density for primary side[A/mm^2]
PrimaryAcu = N1*NewAcp;                                                     % Conductor area of primary [mm^2] 

NewAcs = (pi*diameterConductor_secondary^2)/4;                              % New secondary conductor cross section [mm^2] 
NewJs = Is/NewAcs;                                                          % New current density for secondary side[A/mm^2]
SecondaryAcu = N2*NewAcs;                                                   % Conductor area of primary [mm^2]

TotalAcu = PrimaryAcu + SecondaryAcu;                                       % Total conductor area


%% Calculation window area
Wa = 2*(TotalAcu/Ku);                                                       % Window area for 3 phase [mm^2]
                                                          
Window_w = sqrt(Wa/hw_ratio);                                               % width of window area [mm]
Window_h = Wa/Window_w;                                                     % height of window area [mm]


%% Overall dimensions of transformer
Wtr = 2*Window_w+3*Core_a;                                                  % Overall width of transformer [mm]
Htr = 2*Core_a+Window_h;                                                    % Overall height of transformer [mm]
Dtr = Core_d;                                                               % Overall lenght of transformer [mm]

%% Transformer Volume
Vol_tr = (Ac*(3*Window_h+4*Window_w)+6*Core_a*Core_a*Core_d)*1e-9;          % Transformer Volume [m^3]


% %% Calculation insulation layer -using glass fiber 
% dins_cp_gf = S_1*(Vpn/(Eins_gf*1000));                                      % Glass fiber insulation layer - core/primary winding [mm]
% dins_prisec_gf = S_1*((Vpn+Vsn)/(Eins_gf*1000));                            % Glass fiber insulation layer - primary/secondary windings [mm]
% dins_priturns_gf = S_2*((Vpn/N1)/(Eins_gf*1000));                           % Glass fiber insulation layer - primary turns [mm]
% dins_secturns_gf = S_2*((Vsn/N2)/(Eins_gf*1000));                           % Glass fiber insulation layer - secondary turns [mm]


%% Calculation insulation - using paper 
dins_cp_paper = S_1*(Vpn/(Eins_pap*1000));                                  % Paper insulation layer - core/primary winding [mm]
dins_prisec_paper = S_1*((Vpn+Vsn)/(Eins_pap*1000));                        % Paper insulation layer - primary/secondary windings [mm]
dins_priturns_paper = S_2*((Vpn/N1)/(Eins_pap*1000));                       % Paper insulation layer - primary turns [mm]
dins_secturns_paper = S_2*((Vsn/N2)/(Eins_pap*1000));                       % Paper fiber insulation layer - secondary turns [mm]


% %% Calculate total insulation & winding width using glass fiber 
% HPrimaryWinding_gf = Window_h - 2*dins_cp_gf;                                                        % Height of primary winding area
% WPrimaryWinding_gf = (PrimaryAcu/HPrimaryWinding_gf)+dins_priturns_gf*N1;                            % Width of primary winding area   
% 
% HSecondaryWinding_gf = Window_h - 2*(dins_cp_gf/Nt);                                                  % Height of secondary winding area 
% WSecondaryWinding_gf = (SecondaryAcu/HSecondaryWinding_gf)+dins_secturns_gf*N2;                      % Width of secondary winding area 
% 
% TotalWindingWidth_gf = 2*(dins_cp_gf+WPrimaryWinding_gf+dins_prisec_gf+WSecondaryWinding_gf);        % Total winding width


%% Calculate total winding width using paper 
HPrimaryWinding_paper = Window_h - 2*dins_cp_paper;                                            
WPrimaryWinding_paper = (PrimaryAcu/HPrimaryWinding_paper)+dins_priturns_paper*N1;

HSecondaryWinding_paper = Window_h - 2*(dins_cp_paper/Nt);
WSecondaryWinding_paper = (SecondaryAcu/HSecondaryWinding_paper)+dins_secturns_paper*N2;

TotalWindingWidth_paper = 2*(dins_cp_paper+WPrimaryWinding_paper+dins_prisec_paper+WSecondaryWinding_paper);


%% Calculation length of turns 
MLTp = 2*(Core_a+Core_d)+(pi*Window_w*0.5);                                 % Mean length of primary turns [mm]
MLTs = 2*(Core_a+Core_d)+(pi*Window_w);                                     % Mean length of secondary turns [mm]
TLWp = N1*MLTp;                                                             % Total length of primary turns [mm]
TLWs = N2*MLTs;                                                             % Total length of secondary turns [mm]


%% Calculation leakage inductance 

u0 = 4*pi*1e-10;                                                            % Permeability [H/mm]

Ll1_paper =(u0*N1^2*MLTp)/HPrimaryWinding_paper;

Ll2_paper = dins_prisec_paper/2+WPrimaryWinding_paper/3;
Ll_paper = Ll1_paper*Ll2_paper*1e3;                                         % Leakage inductance of primary side [mH]

L21_paper = (u0*N2^2*MLTs)/HSecondaryWinding_paper;
L22_paper = dins_prisec_paper/2+WSecondaryWinding_paper/3;

L2_paper = L21_paper*L22_paper*1e3;                                         % Leakage inductance of secondary side [mH]

L_paper = Ll1_paper*(dins_prisec_paper+(WPrimaryWinding_paper+WSecondaryWinding_paper)/3)*1e3;   % Leakage inductance 

Lstray = ((N1^2*u0*MLTp)/Window_h)*(WPrimaryWinding_paper/3+dins_prisec_paper+WSecondaryWinding_paper/3)*1e3; % stray inductance [mH]

Lm = (u0*N1*N2*Ac*1e3)/Window_h;                                            % Mutual inductance
%Lm = 0.3*sqrt(Ll_paper*L2_paper);


%% Calculation Power losses 
% Calculation conductor weight
WpriConductor = 3*(diameterConductor_primary^2*0.006676*1.0517*TLWp)*0.001;       % Primary conductor weight
WsecConductor = 3*(diameterConductor_secondary^2*0.006676*1.0517*TLWs)*0.001;     % Secondary condcutor weight


%% Core weight 
Wcore = Den_core*Vol_tr;                                                    % Core weight             
Wcore_m19 = Den_m19*Vol_tr;

%% Calculation DC conductor resistance 
%Rcopper = 1.68*1e-8;

Rp_dc = (Rho*1e-3*TLWp)/(NewAcp*1e-6);                                      % DC resistance of primary conductor
Rs_dc = (Rho*TLWs*1e-3)/(NewAcs*1e-6);                                      % DC resistance of secondary conductor 


%% AC conductor resistance 
Rp_ac = 1.5*Rp_dc;                                                          % AC resistance of primary conductor
Rs_ac = 1.5*Rs_dc;                                                          % AC resistance of secondary conductor    


%% Calculation conductor loss 
Iprms = Ip/sqrt(2);
Isrms = Is/sqrt(2);

Pcon_p = 3*Rp_ac*Ip^2;                                                   % Primary conductor loss
Pcon_s = 3*Rs_ac*Is^2;                                                   % Secondary conductor loss
Pcon = Pcon_p+Pcon_s;                                                       % Total conductor loss


%% Calculation core loss 
%[K1, K2, K3] = SteinmetzFiting(fsw);                                        % Steinmetz fiting coeffciency - Modified Steinmetz Equation
%Pfeo = K1*(fsw^K2)*(Bm^K3)*(Duty^(1-K2));                                  % Reference core loss using modified steinmetz equation [W/kg]    
%Pfeo = 45.9577;                                                            % Measured specific core loss for 1kHz, Bm>0.1. [W/kg] 

Pfeo_m19 = kh*fsw^alpha_m19*Bm^belta_m19;                                   % M19 Core 

%Pcore = Pfeo*Wcore;                                                        % Core loss
Pcore = Pfeo_m19*Wcore_m19;                                                 % M19 core loss     


%% Calculation magnetizing current 

% find out magnetizing force H(Amps/m) corresponding to Bm in the core and yoke from B-H curve
% Bm_rms = 1.2 so calculate Bm = 1.2*sqrt(2) = 1.697. find out H
% correspondng to Bm = 1.697 from B-H curve

at_core = 8332.17381;                                                      % magentizing force H corresponding in the core
at_yoke = 8332.17381;                                                      % magentizing force H corresponding in the core  

MMF_core = 0.85*3*Window_h*1e-3*at_core;                                         % Magnetomotive force(MMF) required for the core
MMF_yoke = 0.85*4*Window_w*1e-3*at_yoke;                                              % MMF required for the yoke
% MMF_yoke = 2*Wtr*1e-3*at_yoke;                                              % MMF required for the yoke
TotalMMF = 1.0*(MMF_core+MMF_yoke);                                        % Total MMF required, we account 10% at for joints 

% Im_peak = (4.44*fsw*Bm*Ac*1e-6*TotalMMF)/(3*Vpn);                           % Peak Value of Magentizing current 
Im_peak = TotalMMF/(3*N1);                                                  % Peak Value of Magentizing current 

Im_rms = Im_peak/sqrt(2);                                                   % RMS value of Magnetizing current     

Ic = Pcore/Vpn;                                                             % Core loss current 
Io = sqrt(Im_rms^2+Ic^2);                                                   % No load current 

%% Transformer loss & efficiency

Ptr_loss = Pcon + Pcore;                                                    % Transformer loss
eff_Tr = (Pin/(Ptr_loss+Pin))*100;                                          % Transformer efficiency

Ef_final = eff_Tr - Im_rms/Ip;                                             % final efficiency 

%% Temperature rise 


 
%% Calculation conductor area
fprintf ('AWG for primary side\n')
fprintf ('AWG size of primary winding: %d[AWG]\n', AWG_primary)
fprintf ('Diameter of pri AWG conductor: %d[mm]\n', diameterConductor_primary)
fprintf ('DC resistance of pri AWG conductor: %d[ohm/km]\n', Rconductor_primary)
fprintf ('Area of pri AWG conductor: %d[mm^2]\n\n', AreaConductor_primary)

fprintf ('AWG for secondary side\n')
fprintf ('AWG size of secondary winding: %d[AWG]\n', AWG_secondary)
fprintf ('Diameter of sec AWG conductor: %d[mm]\n', diameterConductor_secondary)
fprintf ('DC resistance of sec AWG conductor: %d[ohm/km]\n', Rconductor_secondary)
fprintf ('Area of sec AWG conductor: %d[mm^2]\n', AreaConductor_secondary)

% Calculation Effective Skin depth 
fprintf ('Effective skin depth: %d[mm]\n\n', SkinDepth)

% verification of conductor diameter 
if (diameterConductor_primary < 2*SkinDepth)
    fprintf ('Primary conductor diameter is ok\n')
else 
    fprintf ('Parallel conductor are required to primary side\n')
end

if (diameterConductor_secondary < 2*SkinDepth)
    fprintf ('Secondary conductor diameter is ok\n\n')
else 
    fprintf ('Parallel conductor are required to secondary side\n\n')
end

%Calculation conductor areas
fprintf ('Conductor areas\n')
fprintf ('Primary conductor area: %d[mm^2]\n', PrimaryAcu)
fprintf ('Secondary conductor area: %d[mm^2]\n', SecondaryAcu)
fprintf ('Total conductor area: %d[mm^2]\n\n', TotalAcu)

%% Overall dimensions of transformer
fprintf ('Geometry dimensions\n')
fprintf ('Core section area: %d[mm^2]\n', Ac)
fprintf ('Window area: %d[mm^2]\n\n', Wa)

fprintf ('Width of core sectional area: %d[mm]\n', Core_a)
fprintf ('Length of core sectional area: %d[mm]\n', Core_d)
fprintf ('Width of window area: %d[mm]\n', Window_w)
fprintf ('Height of window area: %d[mm]\n', Window_h)
fprintf ('Overall width of transformer: %d[mm]\n', Wtr)
fprintf ('Overall height of transformer: %d[mm]\n', Htr)
fprintf ('Overall lenght of transformer: %d[mm]\n', Dtr)

% Transformer Volume
fprintf ('Transformer volume: %d[m^3]\n\n', Vol_tr)

% %% Calculation insulation layer -using glass fiber 
% fprintf ('Glass fiber insulation layer\n')
% fprintf ('Core/primary winding: %d[mm]\n', dins_cp_gf)
% fprintf ('Primary/secondary windings: %d[mm]\n', dins_prisec_gf)
% fprintf ('Primary turns: %d[mm]\n', dins_priturns_gf)
% fprintf ('Secondary turns: %d[mm]\n\n', dins_secturns_gf)

% Calculation insulation layer -using paper 
fprintf ('Paper insulation layer\n')
fprintf ('Core/primary winding: %d[mm]\n', dins_cp_paper)
fprintf ('Primary/secondary windings: %d[mm]\n', dins_prisec_paper)
fprintf ('Primary turns: %d[mm]\n', dins_priturns_paper)
fprintf ('Secondary turns: %d[mm]\n\n', dins_secturns_paper)

% % Calculate total insulation & winding width using glass fiber 
% fprintf ('Winding dimension - using glass fiber\n')
% fprintf ('Primary winding height: %d[mm]\n', HPrimaryWinding_gf)
% fprintf ('Primary/winding width: %d[mm]\n', WPrimaryWinding_gf)
% fprintf ('Secondary winding height: %d[mm]\n', HSecondaryWinding_gf)
% fprintf ('Secondary winding width: %d[mm]\n', WSecondaryWinding_gf)
% fprintf ('Total Winding width: %d[mm]\n\n', TotalWindingWidth_gf)

% Calculate total insulation & winding width using paper 
fprintf ('Winding dimension - using paper\n')
fprintf ('Primary winding height: %d[mm]\n', HPrimaryWinding_paper)
fprintf ('Primary winding width: %d[mm]\n', WPrimaryWinding_paper)
fprintf ('Secondary winding height: %d[mm]\n', HSecondaryWinding_paper)
fprintf ('Secondary winding width: %d[mm]\n', WSecondaryWinding_paper)
fprintf ('Total Winding width: %d[mm]\n\n', TotalWindingWidth_paper)


% %% verification of winding area 
% if (TotalWindingWidth_gf < Window_w)
%     fprintf ('Calculation geometric dimension using glass fiber is ok\n')
% else 
%     fprintf ('Calculation geometric dimension using glass fiber is wrong.\n\n')
% end
 
if (TotalWindingWidth_paper < Window_w)
    fprintf ('Calculation geometric dimension using paper is ok\n')
else 
    fprintf ('Calculation geometric dimension using paper is wrong.\n\n')
end

%% Calculation length of turns 
fprintf ('Mean lenght of primary turns: %d[mm]\n', MLTp)
fprintf ('Mean lenght of secondary turns: %d[mm]\n', MLTs)
fprintf ('Total lenght of primary turns: %d[mm]\n', TLWp)
fprintf ('Total lenght of secondary turns: %d[mm]\n\n', TLWs)

%% Calculation leakage inductance 
fprintf ('Primary winding Leakage inductance: %d[mH]\n', Ll_paper)
fprintf ('Secondary winding Leakage inductance: %d[mH]\n\n', L2_paper)

fprintf ('Leakage inductance using paper insulation: %d[mH]\n\n', L_paper)

fprintf ('Stary inductance using paper insulation: %d[mH]\n\n', Lstray)
fprintf ('Mutual inductance: %d[mH]\n\n', Lm)

fprintf ('Peak value of magentizing current: %d[A]\n', Im_peak)
fprintf ('RMS value of magentizing current: %d[A]\n', Im_rms)
fprintf ('Core loss current: %d[A]\n', Ic)
fprintf ('No load current: %d[A]\n\n', Io)


%% Calculation conductor weight
fprintf ('Primary conductor weight: %d[kg]\n', WpriConductor)
fprintf ('Secondary condcutor weight: %d[kg]\n', WsecConductor)

% Core weight 
fprintf ('Core weight: %d[kg]\n\n', Wcore)

% Calculation DC&AC conductor resistance 
fprintf ('DC resistance of primary conductor: %d[ohm]\n', Rp_dc)
fprintf ('AC resistance of primary conductor: %d[ohm]\n', Rp_ac)
fprintf ('DC resistance of secondary conductor: %d[ohm]\n', Rs_dc)
fprintf ('AC resistance of secondary conductor: %d[ohm]\n\n', Rs_ac)

% Calculation conductor loss  
fprintf ('Conductor loss of primary side: %d[W]\n', Pcon_p)
fprintf ('Conductor loss of secondary side: %d[W]\n', Pcon_s)
fprintf ('Total conductor loss: %d[W]\n', Pcon)

% Calculation core loss 
fprintf ('Core loss: %d[W]\n\n', Pcore)

% Transformer loss & efficiency
fprintf ('Total transformer loss: %d[W]\n', Ptr_loss)
fprintf ('Calculated transformer efficiency: %d[percent]\n', eff_Tr)
fprintf ('Final Transformer efficiency: %d[percent]\n', Ef_final)
