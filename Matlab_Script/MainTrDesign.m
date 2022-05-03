% MF Frequency Transformer for 3 DAB DC-DC Converter

clear all
close all
clc
format short

% DC-DC converter parameters 
Vin_dc = 4e3;                                                               % DC input voltage [V] 
Vout_dc = 40e3;                                                             % DC output voltage [V]
Pin = 4e6;                                                                  % Converter rating power [W]
fsw = 1e3;                                                                  % operating frequency [Hz]
d = 1;                                                                      % dc conversion ratio
theta = pi/2;                                                               % phase shift angle 
L = 0.636e-3;                                                               % fundamental leakage inductance [H]
Eeff = 0.98;                                                                % expected efficiency 
Duty = 0.5;                                                                 % Duty cycle

% Transformer parameters 
Bm = 1.2;                                                                   % Peak flux density [T]
Nt = 1/10;                                                                  % Turn ratio
N1 = 25;                                                                    % Number of primary winding turns
N2 = N1/Nt;                                                                 % Numer of secondary widing turns
Kf = 4;                                                                     % Waveform coefficient, squre wave=4, sine wave=4.44
Ku = 0.5;                                                                   % Window utilization factor 
Jp_e = 8;                                                                   % assumed current density of primary for oil cooling [A/mm^2] 
Js_e = 10;                                                                  % assumed current density of secondary for oil cooling [A/mm^2] 

% Core material parameters - Metglas 2605SA1 amorphous alloy for MF
Core_th = 0.025;                                                            % lamination thickness [mm]
K_core = 0.75;                                                              % core stacking factor 
Den_core = 7.18;                                                            % density of core [g/cm^3]

% Copper parameters
Rho = 1.678e-8;                                                             % the resistivity of conductor in ohm.m 
Mu0 = 4*pi*10^-7;                
Mur = 0.999991;
Mu = Mu0*Mur;                                                               % the absolute magnetic permeability of the conductor

% Insulation material parameters 
Eins_gf = 1.5;                                                              % Dielectric strength of glass fiber [kV/mm]
Eins_pap = 1.6;                                                             % Dielectric strength of paper [kV/mm]
S_1 = 2;                                                                    % safe factor#1 
S_2 = 4;                                                                    % safe factor#2


% Calculation V, I and St for star-star connection transformer 
Vpn = (1.1*sqrt(3)/3)*Vin_dc;
Vsn = Vpn/Nt;
St = Pin/Eeff;                                                              % apparent transformer power [W]
Ip = St/(3*Vpn);
Is = Ip*Nt;


% Calculattion conductor area
% Selection AWG size - from HV,LV copper AWG functions
[AWG_primary, diameterConductor_primary, Rconductor_primary, AreaConductor_primary] = PrimaryCopperAWG(Ip, Jp_e);
fprintf ('AWG for primary side\n')
fprintf ('AWG size of primary winding: %d[AWG]\n', AWG_primary)
fprintf ('Diameter of pri AWG conductor: %d[mm]\n', diameterConductor_primary)
fprintf ('DC resistance of pri AWG conductor: %d[ohm/km]\n', Rconductor_primary)
fprintf ('Area of pri AWG conductor: %d[mm^2]\n\n', AreaConductor_primary)

[AWG_secondary, diameterConductor_secondary, Rconductor_secondary, AreaConductor_secondary] = SecondaryCopperAWG(Is, Js_e);
fprintf ('AWG for secondary side\n')
fprintf ('AWG size of secondary winding: %d[AWG]\n', AWG_secondary)
fprintf ('Diameter of sec AWG conductor: %d[mm]\n', diameterConductor_secondary)
fprintf ('DC resistance of sec AWG conductor: %d[ohm/km]\n', Rconductor_secondary)
fprintf ('Area of sec AWG conductor: %d[mm^2]\n', AreaConductor_secondary)

SkinDepth = sqrt(Rho/(pi*fsw*Mu))*1000;
fprintf ('Effective skin depth: %d[mm]\n\n', SkinDepth)


%Calculation conductor areas
NewAcp = (pi*diameterConductor_primary^2)/4;                                % New primary conductor cross section [mm^2] 
NewJp = Ip/NewAcp;                                                          % New current density for primary side[A/mm^2]
PrimaryAcu = N1*NewAcp;                                                     % Conductor area of primary [mm^2] 

NewAcs = (pi*diameterConductor_secondary^2)/4;                              % New secondary conductor cross section [mm^2] 
NewJs = Ip/NewAcs;                                                          % New current density for secondary side[A/mm^2]
SecondaryAcu = N2*NewAcs;                                                   % Conductor area of primary [mm^2]

TotalAcu = PrimaryAcu + SecondaryAcu;                                       % Total conductor area

fprintf ('Conductor areas\n')
fprintf ('Primary conductor area: %d[mm^2]\n', PrimaryAcu)
fprintf ('Secondary conductor area: %d[mm^2]\n', SecondaryAcu)
fprintf ('Total conductor area: %d[mm^2]\n\n', TotalAcu)


% Calculation geometry dimensions
Ac = (Vin_dc*100)/(Kf*Bm*N1*fsw*K_core);                                    % Calculation core sectional area [cm^2]
Wa = 2*((TotalAcu/Ku)/100);                                                 % Window area for 3 phase [cm^2]

fprintf ('Geometry dimensions\n')
fprintf ('Core section area: %d[cm^2]\n', Ac)
fprintf ('Window area: %d[cm^2]\n\n', Wa)

wa_ratio = 1;                                                               % Window_w and Core_a ratio
da_ratio = 0.5;                                                             % Core_d and Core_a ratio    

Core_a = sqrt(Vin_dc/(Kf*Bm*N1*fsw*K_core*da_ratio));                       % width of core sectional area [m] 
Core_d = (Ac/100)/Core_a;                                                   % length of core sectional area [m]
Window_h = sqrt((Wa/100)/wa_ratio);                                        % height of window area [m]
Window_w = (Wa/100)/Window_h;                                               % width of window area [m]


Wtr = 2*Window_w+3*Core_a;                                                  % Overall width of transformer [m]
Htr = 2*Core_a+Window_h;                                                    % Overall height of transformer [m]
Dtr = Core_d;                                                               % Overall lenght of transformer [m]

Vol_tr = 2*Wtr*Core_d+3*Window_h*Core_a*Core_d;                             % Transformer Volume [m^3]


% Calculation insulation layer -using glass fiber 
dins_cp_gf = S_1*(Vin_dc/(Eins_gf*1000));                                   % Glass fiber insulation layer - core/primary winding [mm]
dins_prisec_gf = S_1*((Vin_dc+Vout_dc)/(Eins_gf*1000));                     % Glass fiber insulation layer - primary/secondary windings [mm]
dins_priturns_gf = S_2*((Vin_dc/N1)/(Eins_gf*1000));                        % Glass fiber insulation layer - primary turns [mm]
dins_secturns_gf = S_2*((Vout_dc/N2)/(Eins_gf*1000));                       % Glass fiber insulation layer - secondary turns [mm]


% Calculation insulation - using paper 
dins_cp_paper = S_1*(Vin_dc/(Eins_pap*1000));                               % Paper insulation layer - core/primary winding [mm]
dins_prisec_paper = S_1*((Vin_dc+Vout_dc)/(Eins_pap*1000));                 % Paper insulation layer - primary/secondary windings [mm]
dins_priturns_paper = S_2*((Vin_dc/N1)/(Eins_pap*1000));                    % Paper insulation layer - primary turns [mm]
dins_secturns_paper = S_2*((Vout_dc/N2)/(Eins_pap*1000));                   % Paper fiber insulation layer - secondary turns [mm]


% Calculate total insulation & winding width using glass fiber 
HPrimaryWinding_gf = Window_h*1000 - 2*dins_cp_gf;                                                   % Height of primary winding area
WPrimaryWinding_gf = (PrimaryAcu/HPrimaryWinding_gf)+dins_priturns_gf*N1;                            % Width of primary winding area   

HSecondaryWinding_gf = Window_h*1000 - 2*(2*dins_cp_gf);                                             % Height of secondary winding area 
WSecondaryWinding_gf = (SecondaryAcu/HSecondaryWinding_gf)+dins_secturns_gf*N2;                      % Width of secondary winding area 

TotalWindingWidth_gf = 2*(dins_cp_gf+WPrimaryWinding_gf+dins_prisec_gf+WSecondaryWinding_gf);        % Total winding width


% Calculate total winding width using paper 
HPrimaryWinding_paper = Window_h*1000 - 2*dins_cp_paper;                                            
WPrimaryWinding_paper = (PrimaryAcu/HPrimaryWinding_paper)+dins_priturns_paper*N1;

HSecondaryWinding_paper = Window_h*1000 - 2*(2*dins_cp_paper);
WSecondaryWinding_paper = (SecondaryAcu/HSecondaryWinding_paper)+dins_secturns_paper*N2;

TotalWindingWidth_paper = 2*(dins_cp_paper+WPrimaryWinding_paper+dins_prisec_paper+WSecondaryWinding_paper);


fprintf ('Width of core sectional area: %d[m]\n', Core_a)
fprintf ('Length of core sectional area: %d[m]\n', Core_d)
fprintf ('Width of window area: %d[m]\n', Window_w)
fprintf ('Height of window area: %d[m]\n', Window_h)
fprintf ('Overall width of transformer: %d[m]\n', Wtr)
fprintf ('Overall height of transformer: %d[m]\n', Htr)
fprintf ('Overall lenght of transformer: %d[m]\n', Dtr)
fprintf ('Transformer volume: %d[m^3]\n\n', Vol_tr)

fprintf ('Glass fiber insulation layer\n')
fprintf ('Core/primary winding: %d[mm]\n', dins_cp_gf)
fprintf ('Primary/secondary windings: %d[mm]\n', dins_prisec_gf)
fprintf ('Primary turns: %d[mm]\n', dins_priturns_gf)
fprintf ('Secondary turns: %d[mm]\n\n', dins_secturns_gf)

fprintf ('Paper insulation layer\n')
fprintf ('Core/primary winding: %d[mm]\n', dins_cp_paper)
fprintf ('Primary/secondary windings: %d[mm]\n', dins_prisec_paper)
fprintf ('Primary turns: %d[mm]\n', dins_priturns_paper)
fprintf ('Secondary turns: %d[mm]\n\n', dins_secturns_paper)

fprintf ('Winding dimension - using glass fiber\n')
fprintf ('Primary winding height: %d[mm]\n', HPrimaryWinding_gf)
fprintf ('Primary/winding width: %d[mm]\n', WPrimaryWinding_gf)
fprintf ('Secondary winding height: %d[mm]\n', HSecondaryWinding_gf)
fprintf ('Secondary winding width: %d[mm]\n', WSecondaryWinding_gf)
fprintf ('Total Winding width: %d[mm]\n\n', TotalWindingWidth_gf)

fprintf ('Winding dimension - using paper\n')
fprintf ('Primary winding height: %d[mm]\n', HPrimaryWinding_paper)
fprintf ('Primary winding width: %d[mm]\n', WPrimaryWinding_paper)
fprintf ('Secondary winding height: %d[mm]\n', HSecondaryWinding_paper)
fprintf ('Secondary winding width: %d[mm]\n', WSecondaryWinding_paper)
fprintf ('Total Winding width: %d[mm]\n\n', TotalWindingWidth_paper)


% Calculation length of turns 
MLTp = 2*(Core_a+Core_d)+(3*pi*Window_w*0.5);                               % Mean length of primary turns [m]
MLTs = 2*(Core_a+Core_d)+(3*pi*Window_w);                                   % Mean length of secondary turns [m]
TLWp = N1*MLTp;                                                             % Total length of primary turns [m]
TLWs = N2*MLTs;                                                             % Total length of secondary turns [m]

fprintf ('Mean lenght of primary turns: %d[m]\n', MLTp)
fprintf ('Mean lenght of secondary turns: %d[m]\n', MLTs)
fprintf ('Total lenght of primary turns: %d[m]\n', TLWp)
fprintf ('Total lenght of secondary turns: %d[m]\n\n', TLWs)


% Calculation conductor weight
WpriConductor = 3*(diameterConductor_primary^2*0.006676*1.0517*TLWp);       % Primary conductor weight
WsecConductor = 3*(diameterConductor_secondary^2*0.006676*1.0517*TLWs);     % Secondary condcutor weight


% Core weight 
Wcore = ((Den_core*10^6)*Vol_tr)/1000;                                      % Core weight             

fprintf ('Primary conductor weight: %d[kg]\n', WpriConductor)
fprintf ('Secondary condcutor weight: %d[kg]\n', WsecConductor)
fprintf ('Core weight: %d[kg]\n\n', Wcore)


% Calculation DC conductor resistance 
Rp_dc = Rconductor_primary*0.001*(TLWp/diameterConductor_primary);          % DC resistance of primary conductor
Rs_dc = Rconductor_secondary*0.001*(TLWs/diameterConductor_secondary);      % DC resistance of secondary conductor 


% AC conductor resistance 
Rp_ac = 1.2*Rp_dc;                                                          % AC resistance of primary conductor
Rs_ac = 1.2*Rs_dc;                                                          % AC resistance of secondary conductor    


% Calculation conductor loss 
Pcon_p = 3*Rp_ac*Ip^2;                                                      % Primary conductor loss
Pcon_s = 3*Rs_ac*Is^2;                                                      % Secondary conductor loss
Pcon = Pcon_p+Pcon_s;                                                       % Total conductor loss


% Calculation core loss 
[K1, K2, K3] = SteinmetzFiting(fsw);                                        % Steinmetz fiting coeffciency - Modified Steinmetz Equation
Pfeo = K1*fsw^K2*Bm^K3*Duty^(1-K2);                                         % Reference core loss using modified steinmetz equation [W/kg]    

Pcore = Pfeo*Wcore;                                                         % Core loss


% Transformer loss & efficiency
Ptr_loss = Pcon + Pcore;                                                    % Transformer loss
eff_Tr = (Pin/(Ptr_loss+Pin))*100;                                          % Transformer efficiency

fprintf ('DC resistance of primary conductor: %d[ohm]\n', Rp_dc)
fprintf ('AC resistance of primary conductor: %d[ohm]\n', Rp_ac)
fprintf ('DC resistance of secondary conductor: %d[ohm]\n', Rs_dc)
fprintf ('AC resistance of secondary conductor: %d[ohm]\n\n', Rs_ac)

fprintf ('Conductor loss of primary side: %d[W]\n', Pcon_p)
fprintf ('Conductor loss of secondary side: %d[W]\n', Pcon_s)
fprintf ('Total conductor loss: %d[W]\n', Pcon)
fprintf ('Core loss: %d[W]\n\n', Pcore)

fprintf ('Total transformer loss: %d[W]\n', Ptr_loss)
fprintf ('Transformer efficiency: %d[percent]\n', eff_Tr)

