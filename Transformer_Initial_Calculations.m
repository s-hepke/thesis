
% Transformer Design - Samuel Hepke 20179161

%% Parameters 
Vin = 1.1e3;                                                            % DC input voltage [V] 
Vout = 33e3;                                                            % DC output voltage [V]
Pin = 5e6;                                                              % Converter rating power [W]
f = 1000;                                                               % Operating frequency [Hz]
Nt = Vin/Vout;                                                          % Turns ratio
Np = 10;                                                                % Number of primary winding turns
Ns = Np/Nt;                                                             % Number of secondary winding turns

Kf = 4.44;                                                              % Waveform coefficient, squre wave=4, sine wave=4.44
Ku = 0.4;                                                               % Window utilization factor 
Jp_e = 6;                                                               % Assumed current density of primary for oil cooling [A/mm^2] 
Js_e = 6;                                                               % Assumed current density of secondary for oil cooling [A/mm^2]

da_ratio = 2.5;                                                         % Dcore and Acore ratio
wa_ratio = 1.2;                                                         % Wcore and Acore ratio      
%% Calculation V, I and St for star-star connection transformer 
Vp = Vin/sqrt(3);
Vs = Vp/Nt;
Vt = Vp/Np;                                                             % Voltage per turns

Ip = Pin/(3*Vp);
Is = Ip*Nt;
%% Core material parameters
den_core = 7290;                                                            % density of core [kg/m^3]
Bmax = 1.2;                                                             % Peak flux density [T]

k = 0.00336922369454695;
a = 1.30103359460677;
b = 2.13595976775746;
%% Copper parameters
Rho = 1.678e-8;                                                             % the resistivity of conductor in ohm.m
Mu = 4*pi*10^-7;                
%% Insulation material parameters 
dielectricstrength_oil = 24;                                                              % Dielectric strength of oil [kV/mm]
safe_factor = 1.5;                                                                    % safe factor#1 
%% Core design 
Acore = 1e6*(Vt/(Kf*f)/Bmax);
Wcore = sqrt(Acore/wa_ratio);                                                 % width of core sectional area [m] 
Dcore = Acore/Wcore;                                                         % depth of core sectional area [mm]
%% Winding design
conductorp_diam = 11.684;
conductorp_res = 0.1608;
conductors_diam = 2.588;
conductors_res = 3.277;
%% Calculation Effective Skin depth 
skin_depth = sqrt(Rho/(pi*f*Mu))*1000;
%% Calculation conductor areas
conductorp_csa = (pi*conductorp_diam^2)/4;                                % New primary conductor cross section [mm^2] 
conductorp_j = Ip/conductorp_csa;                                                          % New current density for primary side[A/mm^2]
conductorp_area = Np*conductorp_csa;                                                     % Conductor area of primary [mm^2] 

conductors_csa = (pi*conductors_diam^2)/4;                              % New secondary conductor cross section [mm^2] 
conductors_j = Is/conductors_csa;                                                          % New current density for secondary side[A/mm^2]
conductors_area = Ns*conductors_csa;                                                   % Conductor area of primary [mm^2]

total_conductor_area = conductorp_area + conductors_area;                                       % Total conductor area
%% Calculation window area
Awindow = 2*(total_conductor_area/Ku);                                                       % Window area for 3 phase [mm^2]
                                                          
Wwindow = sqrt(Awindow/da_ratio);                                               % width of window area [mm]
Hwindow = Awindow/Wwindow;                                                     % height of window area [mm]
%% Overall dimensions of transformer
Wtransformer = 2*Wwindow+3*Wcore;                                                  % Overall width of transformer [mm]
Htransformer = 2*Wcore+Hwindow;                                                    % Overall height of transformer [mm]
Dtransformer = Dcore;                                                               % Overall lenght of transformer [mm]
%% Transformer Volume
Vtransformer = (Acore*(3*Hwindow+4*Wwindow)+6*Wcore*Wcore*Dcore)*1e-9;          % Transformer Volume [m^3]
%% Calculation insulation - using oil 
insulation_cp_oil = safe_factor*(Vp/(dielectricstrength_oil*1000));                                  % Oil insulation layer - core/primary winding [mm]
insulation_ps_oil = safe_factor*((Vp+Vs)/(dielectricstrength_oil*1000));                           % Oil insulation layer - primary/secondary windings [mm]
insulation_pturns_oil = safe_factor*((Vp/Np)/(dielectricstrength_oil*1000));                       % Oil insulation layer - primary turns [mm]
insulation_sturns_oil = safe_factor*((Vs/Ns)/(dielectricstrength_oil*1000));        % Oil insulation layer - secondary turns [mm]
%% Calculate total winding width using oil 
Hp_oil = Hwindow - 2*insulation_cp_oil;                                            
Wp_oil = (conductorp_area/Hp_oil)+insulation_pturns_oil*Np;

Hs_oil = Hwindow - 2*(insulation_cp_oil/Nt);
Ws_oil = (conductors_area/Hs_oil)+insulation_sturns_oil*Ns;

total_conductor_width_oil = 2*(insulation_cp_oil+Wp_oil+insulation_ps_oil+Ws_oil);
%% Calculation length of turns 
mean_length_turnsp = 2*(Wcore+Dcore)+(pi*Wwindow*0.5);                                 % Mean length of primary turns [mm]
mean_length_turnss = 2*(Wcore+Dcore)+(pi*Wwindow);                                     % Mean length of secondary turns [mm]
total_length_turnsp = Np*mean_length_turnsp;                                                             % Total length of primary turns [mm]
total_length_turnss = Ns*mean_length_turnss;                                                             % Total length of secondary turns [mm]
%% Calculation leakage inductance
u0 = 4*pi*1e-10;                                                            % Permeability [H/mm]

Ll1_oil =(u0*Np^2*mean_length_turnsp)/Hp_oil;
Ll2_oil = insulation_ps_oil/2+Wp_oil/3;
Ll_oil = Ll1_oil*Ll2_oil*1e3;                                         % Leakage inductance of primary side [mH]

L21_oil = (u0*Ns^2*mean_length_turnss)/Hs_oil;
L22_oil = insulation_ps_oil/2+Ws_oil/3;
L2_oil = L21_oil*L22_oil*1e3;                                         % Leakage inductance of secondary side [mH]

L_oil = Ll1_oil*(insulation_ps_oil+(Wp_oil+Ws_oil)/3)*1e3;   % Leakage inductance 

Lstray = ((Np^2*u0*mean_length_turnsp)/Hwindow)*(Wp_oil/3+insulation_ps_oil+Ws_oil/3)*1e3; % stray inductance [mH]

Lm = (u0*Np*Ns*Acore*1e3)/Hwindow;                                            % Mutual inductance
%% Calculation Power losses 
conductorp_weight = 3*(conductorp_diam^2*0.006676*1.0517*total_length_turnsp)*0.001;       % Primary conductor weight
conductors_weight = 3*(conductors_diam^2*0.006676*1.0517*total_length_turnss)*0.001;     % Secondary conductor weight
%% Core weight 
core_weight = den_core*Vtransformer;                                                    % Core weight             
%% Calculation DC conductor resistance 
Rp_dc = (Rho*1e-3*total_length_turnsp)/(conductorp_csa*1e-6);                                      % DC resistance of primary conductor
Rs_dc = (Rho*total_length_turnss*1e-3)/(conductors_csa*1e-6);                                      % DC resistance of secondary conductor
%% AC conductor resistance 
Rp_ac = 1.6*Rp_dc;                                                          % AC resistance of primary conductor
Rs_ac = 1.6*Rs_dc;                                                          % AC resistance of secondary conductor
%% Calculation conductor loss 
Iprms = Ip/sqrt(2);
Isrms = Is/sqrt(2);

Pcon_p = 3*Rp_ac*Ip^2;                                                   % Primary conductor loss
Pcon_s = 3*Rs_ac*Is^2;                                                   % Secondary conductor loss
Pcon = Pcon_p+Pcon_s;                                                       % Total conductor loss
%% Calculation core loss
Psteinmetz = k*f^a*Bmax^b;                                                            % M19 Core
Pcore = Psteinmetz*core_weight;                                                 % M19 core loss
%% Calculation magnetizing current 

% find out magnetizing force H(Amps/m) corresponding to Bm in the core and yoke from B-H curve
% Bm_rms = 1.2 so calculate Bm = 1.2*sqrt(2) = 1.697. find out H
% correspondng to Bm = 1.697 from B-H curve

at_core = 8332.17381;                                                      % magentizing force H corresponding in the core
at_yoke = 8332.17381;                                                      % magentizing force H corresponding in the core  

MMF_core = 0.85*3*Hwindow*1e-3*at_core;                                         % Magnetomotive force(MMF) required for the core
MMF_yoke = 0.85*4*Wwindow*1e-3*at_yoke;                                              % MMF required for the yoke
TotalMMF = 1.0*(MMF_core+MMF_yoke);                                        % Total MMF required, we account 10% at for joints 

Im_peak = TotalMMF/(3*Np);                                                  % Peak Value of Magentizing current
Im_rms = Im_peak/sqrt(2);                                                   % RMS value of Magnetizing current     

Ic = Pcore/Vp;                                                             % Core loss current 
Io = sqrt(Im_rms^2+Ic^2);                                                   % No load current 
%% Transformer loss & efficiency
Ptr_loss = Pcon + Pcore;                                                    % Transformer loss
eff_Tr = (Pin/(Ptr_loss+Pin))*100;                                          % Transformer efficiency

Ef_final = eff_Tr - Im_rms/Ip;                                             % final efficiency