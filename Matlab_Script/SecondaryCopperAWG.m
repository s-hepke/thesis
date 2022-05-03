function [ASecondary, BSecondary, CSecondary, DSecondary] = SecondaryCopperAWG(Is, Js_e)

% Calculate conductor cross section & diameter using given A/mm^2

%Acp = Ip/Jp_e;                          % Primary conductor cross section [mm^2]
Acs = Is/Js_e;                          % Secondary conductor cross section [mm^2]
%d_cp = sqrt(Acp/pi)*2;                  % Primary conductor diameter [mm]
d_cs = sqrt(Acs/pi)*2;                  % Secondary conductor diameter [mm]   

% selection AWG size 
if ( 23.42678827 < d_cs) &&(d_cs <= 26.30669481) 
    AWG_s = -10;                        
    d_cs_new = 26.30669481;                  
    Rcu_s = 0.1608;                     
    AreaCu_s = 543.5286665;                     
end

if ( 20.8622 < d_cs) &&(d_cs <= 23.42678827) 
    AWG_s = -9;                        
    d_cs_new = 23.42678827;                  
    Rcu_s = 0.1608;                     
    AreaCu_s = 431.0378286;                     
end

if ( 18.5783 < d_cs) &&(d_cs <= 20.8622) 
    AWG_s = -8;                        
    d_cs_new = 20.8622;                  
    Rcu_s = 0.1608;                     
    AreaCu_s = 341.8285;                     
end

if ( 16.5444 < d_cs) &&(d_cs <= 18.5783)
    AWG_s = -7;                         
    d_cs_new = 18.5783;                 
    Rcu_s = 0.1608;                     
    AreaCu_s = 271.0824;                     
end

if ( 14.7333 < d_cs) &&(d_cs <= 16.5444) 
    AWG_s = -6;                         
    d_cs_new = 16.5444;                  % New conductor diameter [mm]
    Rcu_s = 0.1608;                     % Copper resistance [ohm/km]
    AreaCu_s = 214.9781;                     % Copper area [mm^2]
end

if ( 13.1203 < d_cs) &&(d_cs <= 14.7333) 
    AWG_s = -5;                         
    d_cs_new = 14.7333;                  % New conductor diameter [mm]
    Rcu_s = 0.1608;                     % Copper resistance [ohm/km]
    AreaCu_s = 170.4854;                     % Copper area [mm^2]
end

if ( 11.684 < d_cs) &&(d_cs <= 13.1203) 
    AWG_s = -4;                         
    d_cs_new = 13.1203;                  % New conductor diameter [mm]
    Rcu_s = 0.1608;                     % Copper resistance [ohm/km]
    AreaCu_s = 135.2010;                     % Copper area [mm^2]
end

if ( 10.405 < d_cs) &&(d_cs <= 11.684)
    AWG_s = -3;                        % AWG size = 4/0; 
    d_cs_new = 11.684;                  % New conductor diameter [mm]
    Rcu_s = 0.1608;                     % Copper resistance [ohm/km]
    AreaCu_s = 107;                     % Copper area [mm^2]
end

if ( 9.266 < d_cs) &&(d_cs <= 10.405)            % AWG size = 3/0; 
    AWG_s = -2;                            
    d_cs_new = 10.405;                  
    Rcu_s = 0.2028;                     
    AreaCu_s = 85;                     
end

if ( 8.251 < d_cs)&&(d_cs <= 9.266)              % AWG size = 2/0; 
    AWG_s = -1;                            
    d_cs_new = 9.266;                  
    Rcu_s = 0.2557;                     
    AreaCu_s = 67.4;                     
end

if ( 7.348 < d_cs) &&(d_cs <= 8.251)             % AWG size = 1/0; 
    AWG_s = 0;                            
    d_cs_new = 8.251;                  
    Rcu_s = 0.3324;                     
    AreaCu_s = 53.5;                     
end

if ( 6.544 < d_cs) && (d_cs <= 7.348)            % AWG size = 1; 
    AWG_s = 1;                            
    d_cs_new = 7.348;                  
    Rcu_s = 0.4066;                     
    AreaCu_s = 42.4;                     
end

if ( 5.827 < d_cs) && (d_cs <= 6.544)            % AWG size = 2; 
    AWG_s = 2;                            
    d_cs_new = 6.544;                  
    Rcu_s = 0.5127;                     
    AreaCu_s = 33.6;                     
end

if ( 5.189 < d_cs) && (d_cs <= 5.827)            % AWG size = 3; 
    AWG_s = 3;                            
    d_cs_new = 5.827;                  
    Rcu_s = 0.6465;                     
    AreaCu_s = 26.7;                     
end

if ( 4.621 < d_cs) && (d_cs <= 5.189)            % AWG size = 4; 
    AWG_s = 4;                            
    d_cs_new = 5.189;                  
    Rcu_s = 0.8152;                     
    AreaCu_s = 21.2;                     
end

if ( 4.115 < d_cs) && (d_cs <= 4.621)            % AWG size = 5; 
    AWG_s = 5;                            
    d_cs_new = 4.621;                  
    Rcu_s = 1.028;                     
    AreaCu_s = 16.8;                     
end

if ( 3.665 < d_cs) && (d_cs <= 4.115)            % AWG size = 6; 
    AWG_s = 6;                            
    d_cs_new = 4.115;                  
    Rcu_s = 1.296;                     
    AreaCu_s = 13.3;                     
end

if ( 3.264 < d_cs) && (d_cs <= 3.665)            % AWG size = 7; 
    AWG_s = 7;                            
    d_cs_new = 3.665;                  
    Rcu_s = 1.634;                     
    AreaCu_s = 10.5;                     
end

if ( 2.906 < d_cs) && (d_cs <= 3.264)            % AWG size = 8; 
    AWG_s = 8;                            
    d_cs_new = 3.264;                  
    Rcu_s = 2.061;                     
    AreaCu_s = 8.37;                     
end

if ( 2.588 < d_cs) && (d_cs <= 2.906)            % AWG size = 9; 
    AWG_s = 9;                            
    d_cs_new = 2.906;                  
    Rcu_s = 2.599;                     
    AreaCu_s = 6.63;                     
end

if ( 2.305 < d_cs) && (d_cs <= 2.588)            % AWG size = 10; 
    AWG_s = 10;                            
    d_cs_new = 2.588;                  
    Rcu_s = 3.277;                     
    AreaCu_s = 5.26;                     
end

if ( 2.053 < d_cs) && (d_cs <= 2.305)            % AWG size = 11; 
    AWG_s = 11;                            
    d_cs_new = 2.305;                  
    Rcu_s = 4.132;                     
    AreaCu_s = 4.17;                     
end

if ( 1.828 < d_cs) && (d_cs <= 2.053)            % AWG size = 12; 
    AWG_s = 12;                            
    d_cs_new = 2.053;                  
    Rcu_s = 5.211;                     
    AreaCu_s = 3.31;                     
end

if ( 1.628 < d_cs) && (d_cs <= 1.828)            % AWG size = 13; 
    AWG_s = 13;                            
    d_cs_new = 1.828;                  
    Rcu_s = 6.571;                     
    AreaCu_s = 2.62;                     
end

if ( 1.450 < d_cs) && (d_cs <= 1.628)            % AWG size = 14; 
    AWG_s = 14;                            
    d_cs_new = 1.628;                  
    Rcu_s = 8.286;                     
    AreaCu_s = 2.08;                     
end

if ( 1.291 < d_cs) && (d_cs <= 1.450)            % AWG size = 15; 
    AWG_s = 15;                            
    d_cs_new = 1.450;                  
    Rcu_s = 10.45;                     
    AreaCu_s = 1.65;                     
end

if ( 1.150 < d_cs) && (d_cs <= 1.291)            % AWG size = 16; 
    AWG_s = 16;                            
    d_cs_new = 1.291;                  
    Rcu_s = 13.17;                     
    AreaCu_s = 1.31;                     
end

if ( 1.024 < d_cs) && (d_cs <= 1.150)            % AWG size = 17; 
    AWG_s = 17;                            
    d_cs_new = 1.150;                  
    Rcu_s = 16.61;                     
    AreaCu_s = 1.04;                     
end

if ( 0.912 < d_cs ) && (d_cs <= 1.024)            % AWG size = 18; 
    AWG_s = 18;                            
    d_cs_new = 1.024;                  
    Rcu_s = 20.95;                     
    AreaCu_s = 0.823;                     
end

if ( 0.812 < d_cs) && (d_cs <= 0.912)            % AWG size = 19; 
    AWG_s = 19;                            
    d_cs_new = 0.912;                  
    Rcu_s = 26.42;                     
    AreaCu_s = 0.653;                     
end

if ( 0.723 < d_cs) && (d_cs <= 0.812)            % AWG size = 20; 
    AWG_s = 20;                            
    d_cs_new = 0.812;                  
    Rcu_s = 33.31;                     
    AreaCu_s = 0.518;    
end

if ( 0.644 < d_cs) && (d_cs <= 0.723)            % AWG size = 21; 
    AWG_s = 21;                            
    d_cs_new = 0.723;                  
    Rcu_s = 42;                     
    AreaCu_s = 0.41;    
end

if ( 0.573 < d_cs) && (d_cs <= 0.644)            % AWG size = 22; 
    AWG_s = 22;                            
    d_cs_new = 0.644;                  
    Rcu_s = 52.96;                     
    AreaCu_s = 0.326;    
end

if ( 0.511 < d_cs) && (d_cs <= 0.573)            % AWG size = 23; 
    AWG_s = 23;                            
    d_cs_new = 0.573;                  
    Rcu_s = 66.79;                     
    AreaCu_s = 0.258;    
end

if ( 0.455 < d_cs) && (d_cs <= 0.511)            % AWG size = 24; 
    AWG_s = 24;                            
    d_cs_new = 0.511;                  
    Rcu_s = 84.22;                     
    AreaCu_s = 0.205;    
end

if ( 0.405 < d_cs) && (d_cs <= 0.455)            % AWG size = 25; 
    AWG_s = 25;                            
    d_cs_new = 0.455;                  
    Rcu_s = 106.2;                     
    AreaCu_s = 0.162;    
end

if ( 0.361 < d_cs) && (d_cs <= 0.405)            % AWG size = 26; 
    AWG_s = 26;                            
    d_cs_new = 0.405;                  
    Rcu_s = 133.9;                     
    AreaCu_s = 0.129;    
end

if ( 0.321 < d_cs) && (d_cs <= 0.361)            % AWG size = 27; 
    AWG_s = 27;                            
    d_cs_new = 0.361;                  
    Rcu_s = 168.9;                     
    AreaCu_s = 0.102;    
end

if ( 0.286 < d_cs) && (d_cs <= 0.321)            % AWG size = 28; 
    AWG_s = 28;                            
    d_cs_new = 0.321;                  
    Rcu_s = 212.9;                     
    AreaCu_s = 0.081;    
end

if ( 0.255 < d_cs) && (d_cs <= 0.286)            % AWG size = 29; 
    AWG_s = 29;                            
    d_cs_new = 0.286;                  
    Rcu_s = 268.5;                     
    AreaCu_s = 0.0642;    
end

if ( 0.227 < d_cs) && (d_cs <= 0.255)            % AWG size = 30; 
    AWG_s = 30;                            
    d_cs_new = 0.255;                  
    Rcu_s = 338.6;                     
    AreaCu_s = 0.0509;    
end

if ( 0.202 < d_cs) && (d_cs <= 0.227)            % AWG size = 31; 
    AWG_s = 31;                            
    d_cs_new = 0.227;                  
    Rcu_s = 426.9;                     
    AreaCu_s = 0.0404;    
end

if ( 0.180 < d_cs) && (d_cs <= 0.202)            % AWG size = 32; 
    AWG_s = 32;                            
    d_cs_new = 0.202;                  
    Rcu_s = 538.3;                     
    AreaCu_s = 0.032;    
end

if ( 0.160 < d_cs) && (d_cs <= 0.180)            % AWG size = 33; 
    AWG_s = 33;                            
    d_cs_new = 0.180;                  
    Rcu_s = 678.8;                     
    AreaCu_s = 0.0254;    
end

if ( 0.143 < d_cs) && (d_cs <= 0.160)            % AWG size = 34; 
    AWG_s = 34;                            
    d_cs_new = 0.160;                  
    Rcu_s = 856;                     
    AreaCu_s = 0.0201;    
end

if ( 0.127 < d_cs) && (d_cs <= 0.143)            % AWG size = 35; 
    AWG_s = 35;                            
    d_cs_new = 0.143;                  
    Rcu_s = 1076;                     
    AreaCu_s = 0.016;    
end

if ( 0.113 < d_cs) && (d_cs <= 0.127)            % AWG size = 36; 
    AWG_s = 36;                            
    d_cs_new = 0.127;                  
    Rcu_s = 1361;                     
    AreaCu_s = 0.0127;    
end

if ( 0.101 < d_cs) && (d_cs <= 0.113)            % AWG size = 37; 
    AWG_s = 37;                            
    d_cs_new = 0.113;                  
    Rcu_s = 1716;                     
    AreaCu_s = 0.01;    
end

if ( 0.090 < d_cs) && (d_cs <= 0.101)            % AWG size = 38; 
    AWG_s = 38;                            
    d_cs_new = 0.101;                  
    Rcu_s = 2164;                     
    AreaCu_s = 0.00797;    
end

if ( 0.080 < d_cs) && (d_cs <= 0.090)            % AWG size = 39; 
    AWG_s = 39;                            
    d_cs_new = 0.090;                  
    Rcu_s = 2729;                     
    AreaCu_s = 0.00632;    
end

if ( 0 < d_cs) && (d_cs <= 0.080)                % AWG size = 40; 
    AWG_s = 40;                            
    d_cs_new = 0.080;                  
    Rcu_s = 3441;                     
    AreaCu_s = 0.00501;    
end

ASecondary = AWG_s;
BSecondary = d_cs_new;
CSecondary = Rcu_s;
DSecondary = AreaCu_s;

return

