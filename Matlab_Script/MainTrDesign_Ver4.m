
% MF Frequency Transformer for 3 DAB DC-DC Converter

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
Et = 0.45*sqrt(4000);                                                       % Voltage per turns
% N1 = Vpn/Et = 89.9.. 
Nt = 1/10;                                                                  % Turn ratio

% Calculation V, I and St for star-star connection transformer 
Vpn = (1.1*sqrt(3)/3)*Vin_dc;
Vsn = Vpn/Nt;
St = Pin/Eeff;                                                              % apparent transformer power [W]
Ip = St/(3*Vpn);
Is = Ip*Nt;

% Transformer parameters 
Bm = 1.2;                                                                   % Peak flux density [T]
N1 = 90;                                                                    % Number of primary winding turns
N2 = N1/Nt;                                                                 % Numer of secondary widing turns
Kf = 4;                                                                     % Waveform coefficient, squre wave=4, sine wave=4.44
Ku = 0.4;                                                                   % Window utilization factor 
Jp_e = 8;                                                                   % assumed current density of primary for oil cooling [A/mm^2] 
Js_e = 10;                                                                  % assumed current density of secondary for oil cooling [A/mm^2] 

% Core material parameters - Metglas 2605SA1 amorphous alloy for MF
Core_th = 0.025;                                                            % lamination thickness [mm]
K_core = 0.75;                                                              % core stacking factor 
Den_core = 7180;                                                            % density of core [kg/m^3]

% Copper parameters
Rho = 1.678e-8;                                                             % the resistivity of conductor in ohm.m 
Mu0 = 4*pi*10^-7;                
Mur = 0.999991;
Mu = Mu0*Mur;                                                               % the absolute magnetic permeability of the conductor

% Insulation material parameters 
Eins_gf = 1.6;                                                              % Dielectric strength of glass fiber [kV/mm]
Eins_pap = 1.6;                                                             % Dielectric strength of paper [kV/mm]
S_1 = 1.5;                                                                    % safe factor#1 
S_2 = 1.5;                                                                    % safe factor#2


%Core design 
%Ac = (Vin_dc*100)/(Kf*Bm*N1*fsw*K_core);                                   % Calculation core sectional area [mm^2]
Ac = 1e6*(Et/(Kf*fsw)/Bm);

da_ratio = 0.5;                                                             % Core_d and Core_a ratio    

Core_a = sqrt(Ac/da_ratio);                                                 % width of core sectional area [m] 
Core_d = Ac/Core_a;                                                         % length of core sectional area [mm]


% Winding design 
% Calculation conductor area
[AWG_primary, diameterConductor_primary, Rconductor_primary, AreaConductor_primary] = PrimaryCopperAWG(Ip, Jp_e);  % Selection AWG size - from HV,LV copper AWG functions

[AWG_secondary, diameterConductor_secondary, Rconductor_secondary, AreaConductor_secondary] = SecondaryCopperAWG(Is, Js_e);


% Calculation Effective Skin depth 
SkinDepth = sqrt(Rho/(pi*fsw*Mu))*1000;


%Calculation conductor areas
NewAcp = (pi*diameterConductor_primary^2)/4;                                % New primary conductor cross section [mm^2] 
NewJp = Ip/NewAcp;                                                          % New current density for primary side[A/mm^2]
PrimaryAcu = N1*NewAcp;                                                     % Conductor area of primary [mm^2] 

NewAcs = (pi*diameterConductor_secondary^2)/4;                              % New secondary conductor cross section [mm^2] 
NewJs = Ip/NewAcs;                                                          % New current density for secondary side[A/mm^2]
SecondaryAcu = N2*NewAcs;                                                   % Conductor area of primary [mm^2]

TotalAcu = PrimaryAcu + SecondaryAcu;                                       % Total conductor area


% Calculation window area
Wa = 2*(TotalAcu/Ku);                                                       % Window area for 3 phase [mm^2]

hw_ratio = 1.0;                                                             % Window_w and Core_a ratio

Window_w = sqrt(Wa/hw_ratio);                                               % width of window area [mm]
Window_h = Wa/Window_w;                                                     % height of window area [mm]


% Overall dimensions of transformer
Wtr = 2*Window_w+3*Core_a;                                                  % Overall width of transformer [mm]
Htr = 2*Core_a+Window_h;                                                    % Overall height of transformer [mm]
Dtr = Core_d;                                                               % Overall lenght of transformer [mm]

% Transformer Volume
Vol_tr = (Ac*(3*Window_h+4*Window_w)+6*Core_a*Core_a*Core_d)*1e-9;          % Transformer Volume [mm^3]


% Calculation insulation layer -using glass fiber 
dins_cp_gf = S_1*(Vpn/(Eins_gf*1000));                                      % Glass fiber insulation layer - core/primary winding [mm]
dins_prisec_gf = S_1*((Vpn+Vsn)/(Eins_gf*1000));                            % Glass fiber insulation layer - primary/secondary windings [mm]
dins_priturns_gf = S_2*((Vpn/N1)/(Eins_gf*1000));                           % Glass fiber insulation layer - primary turns [mm]
dins_secturns_gf = S_2*((Vsn/N2)/(Eins_gf*1000));                           % Glass fiber insulation layer - secondary turns [mm]


% Calculation insulation - using paper 
dins_cp_paper = S_1*(Vpn/(Eins_pap*1000));                                  % Paper insulation layer - core/primary winding [mm]
dins_prisec_paper = S_1*((Vpn+Vsn)/(Eins_pap*1000));                        % Paper insulation layer - primary/secondary windings [mm]
dins_priturns_paper = S_2*((Vpn/N1)/(Eins_pap*1000));                       % Paper insulation layer - primary turns [mm]
dins_secturns_paper = S_2*((Vsn/N2)/(Eins_pap*1000));                       % Paper fiber insulation layer - secondary turns [mm]


% Calculate total insulation & winding width using glass fiber 
HPrimaryWinding_gf = Window_h - 2*dins_cp_gf;                                                        % Height of primary winding area
WPrimaryWinding_gf = (PrimaryAcu/HPrimaryWinding_gf)+dins_priturns_gf*N1;                            % Width of primary winding area   

HSecondaryWinding_gf = Window_h - 2*(dins_cp_gf/Nt);                                                  % Height of secondary winding area 
WSecondaryWinding_gf = (SecondaryAcu/HSecondaryWinding_gf)+dins_secturns_gf*N2;                      % Width of secondary winding area 

TotalWindingWidth_gf = 2*(dins_cp_gf+WPrimaryWinding_gf+dins_prisec_gf+WSecondaryWinding_gf);        % Total winding width


% Calculate total winding width using paper 
HPrimaryWinding_paper = Window_h - 2*dins_cp_paper;                                            
WPrimaryWinding_paper = (PrimaryAcu/HPrimaryWinding_paper)+dins_priturns_paper*N1;

HSecondaryWinding_paper = Window_h - 2*(dins_cp_paper/Nt);
WSecondaryWinding_paper = (SecondaryAcu/HSecondaryWinding_paper)+dins_secturns_paper*N2;

TotalWindingWidth_paper = 2*(dins_cp_paper+WPrimaryWinding_paper+dins_prisec_paper+WSecondaryWinding_paper);


% Calculation length of turns 
MLTp = 2*(Core_a+Core_d)+(pi*Window_w*0.5);                                 % Mean length of primary turns [mm]
MLTs = 2*(Core_a+Core_d)+(pi*Window_w);                                     % Mean length of secondary turns [mm]
TLWp = N1*MLTp;                                                             % Total length of primary turns [mm]
TLWs = N2*MLTs;                                                             % Total length of secondary turns [mm]


% Calculation leakage inductance 

u0 = 4*pi*1e-10;                                                            % Permeability [H/mm]

Ll1_gf =(u0*N1^2*MLTp)/HPrimaryWinding_gf;
Ll2_gf = dins_prisec_gf+(WPrimaryWinding_gf+WSecondaryWinding_gf)/3;
Ll_gf = 0.5*Ll1_gf*Ll2_gf*1e3;                                              % Leakage inductance [mH]  

Ll1_paper =(u0*N1^2*MLTp)/HPrimaryWinding_paper;
Ll2_paper = dins_prisec_paper+(WPrimaryWinding_paper+WSecondaryWinding_paper)/3;
Ll_paper = 0.5*Ll1_paper*Ll2_paper*1e3;                                     % Leakage inductance [mH]


% Calculation Power losses 
% Calculation conductor weight
WpriConductor = 3*(diameterConductor_primary^2*0.006676*1.0517*TLWp);       % Primary conductor weight
WsecConductor = 3*(diameterConductor_secondary^2*0.006676*1.0517*TLWs);     % Secondary condcutor weight


% Core weight 
Wcore = Den_core*Vol_tr;                                                    % Core weight             


% Calculation DC conductor resistance 
Rp_dc = Rconductor_primary*0.000001*(TLWp/diameterConductor_primary);       % DC resistance of primary conductor
Rs_dc = Rconductor_secondary*0.000001*(TLWs/diameterConductor_secondary);   % DC resistance of secondary conductor 


% AC conductor resistance 
Rp_ac = 1.2*Rp_dc;                                                          % AC resistance of primary conductor
Rs_ac = 1.2*Rs_dc;                                                          % AC resistance of secondary conductor    


% Calculation conductor loss 
Pcon_p = 3*Rp_ac*Ip^2;                                                      % Primary conductor loss
Pcon_s = 3*Rs_ac*Is^2;                                                      % Secondary conductor loss
Pcon = Pcon_p+Pcon_s;                                                       % Total conductor loss


% Calculation core loss 
[K1, K2, K3] = SteinmetzFiting(fsw);                                        % Steinmetz fiting coeffciency - Modified Steinmetz Equation
%Pfeo = K1*(fsw^K2)*(Bm^K3)*(Duty^(1-K2));                                   % Reference core loss using modified steinmetz equation [W/kg]    
Pfeo = 45.9577;                                                            % Measured specific core loss for 1kHz, Bm>0.1. [W/kg] 
Pcore = Pfeo*Wcore;                                                         % Core loss


% Transformer loss & efficiency
Ptr_loss = Pcon + Pcore;                                                    % Transformer loss
eff_Tr = (Pin/(Ptr_loss+Pin))*100;                                          % Transformer efficiency


% Temperature rise 


% Calculation conductor area
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

% Overall dimensions of transformer
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

% Calculation insulation layer -using glass fiber 
fprintf ('Glass fiber insulation layer\n')
fprintf ('Core/primary winding: %d[mm]\n', dins_cp_gf)
fprintf ('Primary/secondary windings: %d[mm]\n', dins_prisec_gf)
fprintf ('Primary turns: %d[mm]\n', dins_priturns_gf)
fprintf ('Secondary turns: %d[mm]\n\n', dins_secturns_gf)

% Calculation insulation layer -using paper 
fprintf ('Paper insulation layer\n')
fprintf ('Core/primary winding: %d[mm]\n', dins_cp_paper)
fprintf ('Primary/secondary windings: %d[mm]\n', dins_prisec_paper)
fprintf ('Primary turns: %d[mm]\n', dins_priturns_paper)
fprintf ('Secondary turns: %d[mm]\n\n', dins_secturns_paper)

% Calculate total insulation & winding width using glass fiber 
fprintf ('Winding dimension - using glass fiber\n')
fprintf ('Primary winding height: %d[mm]\n', HPrimaryWinding_gf)
fprintf ('Primary/winding width: %d[mm]\n', WPrimaryWinding_gf)
fprintf ('Secondary winding height: %d[mm]\n', HSecondaryWinding_gf)
fprintf ('Secondary winding width: %d[mm]\n', WSecondaryWinding_gf)
fprintf ('Total Winding width: %d[mm]\n\n', TotalWindingWidth_gf)

% Calculate total insulation & winding width using paper 
fprintf ('Winding dimension - using paper\n')
fprintf ('Primary winding height: %d[mm]\n', HPrimaryWinding_paper)
fprintf ('Primary winding width: %d[mm]\n', WPrimaryWinding_paper)
fprintf ('Secondary winding height: %d[mm]\n', HSecondaryWinding_paper)
fprintf ('Secondary winding width: %d[mm]\n', WSecondaryWinding_paper)
fprintf ('Total Winding width: %d[mm]\n\n', TotalWindingWidth_paper)


% verification of winding area 
if (TotalWindingWidth_gf < Window_w)
    fprintf ('Calculation geometric dimension using glass fiber is ok\n')
else 
    fprintf ('Calculation geometric dimension using glass fiber is wrong.\n\n')
end
 
if (TotalWindingWidth_paper < Window_w)
    fprintf ('Calculation geometric dimension using paper is ok\n')
else 
    fprintf ('Calculation geometric dimension using paper is wrong.\n\n')
end

% Calculation length of turns 
fprintf ('Mean lenght of primary turns: %d[mm]\n', MLTp)
fprintf ('Mean lenght of secondary turns: %d[mm]\n', MLTs)
fprintf ('Total lenght of primary turns: %d[mm]\n', TLWp)
fprintf ('Total lenght of secondary turns: %d[mm]\n\n', TLWs)

% Calculation leakage inductance 
fprintf ('Leakage inductace using glass fiber insulation: %d[mH]\n', Ll_gf)
fprintf ('Leakage inductance using paper insulation: %d[mH]\n\n', Ll_paper)

% Calculation conductor weight
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
fprintf ('Transformer efficiency: %d[percent]\n', eff_Tr)

