function [APrimary, BPrimary, CPrimary, DPrimary] = PrimaryCopperAWG(Ip, Jp_e)

% Calculate conductor cross section & diameter using given A/mm^2

Acp = Ip/Jp_e;                          % Primary conductor cross section [mm^2]

d_cp = sqrt(Acp/pi)*2;                  % Primary conductor diameter [mm]

% selection AWG size
if ( 23.42678827 < d_cp) &&(d_cp <= 26.30669481) 
    AWG_p = -10;                        
    d_cp_new = 26.30669481;                  
    Rcu_p = 0.1608;                     
    AreaCu_p = 543.5286665;                     
end

if ( 20.8622 < d_cp) &&(d_cp <= 23.42678827) 
    AWG_p = -9;                        
    d_cp_new = 23.42678827;                  
    Rcu_p = 0.1608;                     
    AreaCu_p = 431.0378286;                     
end

if ( 18.5783 < d_cp) &&(d_cp <= 20.8622) 
    AWG_p = -8;                        
    d_cp_new = 20.8622;                  
    Rcu_p = 0.1608;                     
    AreaCu_p = 341.8285;                     
end

if ( 16.5444 < d_cp) &&(d_cp <= 18.5783)
    AWG_p = -7;                         
    d_cp_new = 18.5783;                 
    Rcu_p = 0.1608;                     
    AreaCu_p = 271.0824;                     
end

if ( 14.7333 < d_cp) &&(d_cp <= 16.5444) 
    AWG_p = -6;                         
    d_cp_new = 16.5444;                  % New conductor diameter [mm]
    Rcu_p = 0.1608;                     % Copper resistance [ohm/km]
    AreaCu_p = 214.9781;                     % Copper area [mm^2]
end

if ( 13.1203 < d_cp) &&(d_cp <= 14.7333) 
    AWG_p = -5;                         
    d_cp_new = 14.7333;                  % New conductor diameter [mm]
    Rcu_p = 0.1608;                     % Copper resistance [ohm/km]
    AreaCu_p = 170.4854;                     % Copper area [mm^2]
end

if ( 11.684 < d_cp) &&(d_cp <= 13.1203) 
    AWG_p = -4;                         
    d_cp_new = 13.1203;                  % New conductor diameter [mm]
    Rcu_p = 0.1608;                     % Copper resistance [ohm/km]
    AreaCu_p = 135.2010;                     % Copper area [mm^2]
end

if ( 10.405 < d_cp) &&(d_cp <= 11.684) 
    AWG_p = -3;                         
    d_cp_new = 11.684;                  % New conductor diameter [mm]
    Rcu_p = 0.1608;                     % Copper resistance [ohm/km]
    AreaCu_p = 107;                     % Copper area [mm^2]
end

if ( 9.266 < d_cp) &&(d_cp <= 10.405)            % AWG size = 3/0; 
    AWG_p = -2;                            
    d_cp_new = 10.405;                  
    Rcu_p = 0.2028;                     
    AreaCu_p = 85;                     
end

if ( 8.251 < d_cp)&&(d_cp <= 9.266)            % AWG size = 2/0; 
    AWG_p = -1;                            
    d_cp_new = 9.266;                  
    Rcu_p = 0.2557;                     
    AreaCu_p = 67.4;                     
end

if ( 7.348 < d_cp) &&(d_cp <= 8.251)            % AWG size = 1/0; 
    AWG_p = 0;                            
    d_cp_new = 8.251;                  
    Rcu_p = 0.3324;                     
    AreaCu_p = 53.5;                     
end

if ( 6.544 < d_cp) && (d_cp <= 7.348)            % AWG size = 1; 
    AWG_p = 1;                            
    d_cp_new = 7.348;                  
    Rcu_p = 0.4066;                     
    AreaCu_p = 42.4;                     
end

if ( 5.827 < d_cp) && (d_cp <= 6.544)            % AWG size = 2; 
    AWG_p = 2;                            
    d_cp_new = 6.544;                  
    Rcu_p = 0.5127;                     
    AreaCu_p = 33.6;                     
end

if ( 5.189 < d_cp) && (d_cp <= 5.827)            % AWG size = 3; 
    AWG_p = 3;                            
    d_cp_new = 5.827;                  
    Rcu_p = 0.6465;                     
    AreaCu_p = 26.7;                     
end

if ( 4.621 < d_cp) && (d_cp <= 5.189)            % AWG size = 4; 
    AWG_p = 4;                            
    d_cp_new = 5.189;                  
    Rcu_p = 0.8152;                     
    AreaCu_p = 21.2;                     
end

if ( 4.115 < d_cp) && (d_cp <= 4.621)            % AWG size = 5; 
    AWG_p = 5;                            
    d_cp_new = 4.621;                  
    Rcu_p = 1.028;                     
    AreaCu_p = 16.8;                     
end

if ( 3.665 < d_cp) && (d_cp <= 4.115)            % AWG size = 6; 
    AWG_p = 6;                            
    d_cp_new = 4.115;                  
    Rcu_p = 1.296;                     
    AreaCu_p = 13.3;                     
end

if ( 3.264 < d_cp) && (d_cp <= 3.665)            % AWG size = 7; 
    AWG_p = 7;                            
    d_cp_new = 3.665;                  
    Rcu_p = 1.634;                     
    AreaCu_p = 10.5;                     
end

if ( 2.906 < d_cp) && (d_cp <= 3.264)            % AWG size = 8; 
    AWG_p = 8;                            
    d_cp_new = 3.264;                  
    Rcu_p = 2.061;                     
    AreaCu_p = 8.37;                     
end

if ( 2.588 < d_cp) && (d_cp <= 2.906)            % AWG size = 9; 
    AWG_p = 9;                            
    d_cp_new = 2.906;                  
    Rcu_p = 2.599;                     
    AreaCu_p = 6.63;                     
end

if ( 2.305 < d_cp) && (d_cp <= 2.588)            % AWG size = 10; 
    AWG_p = 10;                            
    d_cp_new = 2.588;                  
    Rcu_p = 3.277;                     
    AreaCu_p = 5.26;                     
end

if ( 2.053 < d_cp) && (d_cp <= 2.305)            % AWG size = 11; 
    AWG_p = 11;                            
    d_cp_new = 2.305;                  
    Rcu_p = 4.132;                     
    AreaCu_p = 4.17;                     
end

if ( 1.828 < d_cp) && (d_cp <= 2.053)            % AWG size = 12; 
    AWG_p = 12;                            
    d_cp_new = 2.053;                  
    Rcu_p = 5.211;                     
    AreaCu_p = 3.31;                     
end

if ( 1.628 < d_cp) && (d_cp <= 1.828)            % AWG size = 13; 
    AWG_p = 13;                            
    d_cp_new = 1.828;                  
    Rcu_p = 6.571;                     
    AreaCu_p = 2.62;                     
end

if ( 1.450 < d_cp) && (d_cp <= 1.628)            % AWG size = 14; 
    AWG_p = 14;                            
    d_cp_new = 1.628;                  
    Rcu_p = 8.286;                     
    AreaCu_p = 2.08;                     
end

if ( 1.291 < d_cp) && (d_cp <= 1.450)            % AWG size = 15; 
    AWG_p = 15;                            
    d_cp_new = 1.450;                  
    Rcu_p = 10.45;                     
    AreaCu_p = 1.65;                     
end

if ( 1.150 < d_cp) && (d_cp <= 1.291)            % AWG size = 16; 
    AWG_p = 16;                            
    d_cp_new = 1.291;                  
    Rcu_p = 13.17;                     
    AreaCu_p = 1.31;                     
end

if ( 1.024 < d_cp) && (d_cp <= 1.150)            % AWG size = 17; 
    AWG_p = 17;                            
    d_cp_new = 1.150;                  
    Rcu_p = 16.61;                     
    AreaCu_p = 1.04;                     
end

if ( 0.912 < d_cp ) && (d_cp <= 1.024)            % AWG size = 18; 
    AWG_p = 18;                            
    d_cp_new = 1.024;                  
    Rcu_p = 20.95;                     
    AreaCu_p = 0.823;                     
end

if ( 0.812 < d_cp) && (d_cp <= 0.912)            % AWG size = 19; 
    AWG_p = 19;                            
    d_cp_new = 0.912;                  
    Rcu_p = 26.42;                     
    AreaCu_p = 0.653;                     
end

if ( 0.723 < d_cp) && (d_cp <= 0.812)            % AWG size = 20; 
    AWG_p = 20;                            
    d_cp_new = 0.812;                  
    Rcu_p = 33.31;                     
    AreaCu_p = 0.518;    
end

if ( 0.644 < d_cp) && (d_cp <= 0.723)            % AWG size = 21; 
    AWG_p = 21;                            
    d_cp_new = 0.723;                  
    Rcu_p = 42;                     
    AreaCu_p = 0.41;    
end

if ( 0.573 < d_cp) && (d_cp <= 0.644)            % AWG size = 22; 
    AWG_p = 22;                            
    d_cp_new = 0.644;                  
    Rcu_p = 52.96;                     
    AreaCu_p = 0.326;    
end

if ( 0.511 < d_cp) && (d_cp <= 0.573)            % AWG size = 23; 
    AWG_p = 23;                            
    d_cp_new = 0.573;                  
    Rcu_p = 66.79;                     
    AreaCu_p = 0.258;    
end

if ( 0.455 < d_cp) && (d_cp <= 0.511)            % AWG size = 24; 
    AWG_p = 24;                            
    d_cp_new = 0.511;                  
    Rcu_p = 84.22;                     
    AreaCu_p = 0.205;    
end

if ( 0.405 < d_cp) && (d_cp <= 0.455)            % AWG size = 25; 
    AWG_p = 25;                            
    d_cp_new = 0.455;                  
    Rcu_p = 106.2;                     
    AreaCu_p = 0.162;    
end

if ( 0.361 < d_cp) && (d_cp <= 0.405)            % AWG size = 26; 
    AWG_p = 26;                            
    d_cp_new = 0.405;                  
    Rcu_p = 133.9;                     
    AreaCu_p = 0.129;    
end

if ( 0.321 < d_cp) && (d_cp <= 0.361)            % AWG size = 27; 
    AWG_p = 27;                            
    d_cp_new = 0.361;                  
    Rcu_p = 168.9;                     
    AreaCu_p = 0.102;    
end

if ( 0.286 < d_cp) && (d_cp <= 0.321)            % AWG size = 28; 
    AWG_p = 28;                            
    d_cp_new = 0.321;                  
    Rcu_p = 212.9;                     
    AreaCu_p = 0.081;    
end

if ( 0.255 < d_cp) && (d_cp <= 0.286)            % AWG size = 29; 
    AWG_p = 29;                            
    d_cp_new = 0.286;                  
    Rcu_p = 268.5;                     
    AreaCu_p = 0.0642;    
end

if ( 0.227 < d_cp) && (d_cp <= 0.255)            % AWG size = 30; 
    AWG_p = 30;                            
    d_cp_new = 0.255;                  
    Rcu_p = 338.6;                     
    AreaCu_p = 0.0509;    
end

if ( 0.202 < d_cp) && (d_cp <= 0.227)            % AWG size = 31; 
    AWG_p = 31;                            
    d_cp_new = 0.227;                  
    Rcu_p = 426.9;                     
    AreaCu_p = 0.0404;    
end

if ( 0.180 < d_cp) && (d_cp <= 0.202)            % AWG size = 32; 
    AWG_p = 32;                            
    d_cp_new = 0.202;                  
    Rcu_p = 538.3;                     
    AreaCu_p = 0.032;    
end

if ( 0.160 < d_cp) && (d_cp <= 0.180)            % AWG size = 33; 
    AWG_p = 33;                            
    d_cp_new = 0.180;                  
    Rcu_p = 678.8;                     
    AreaCu_p = 0.0254;    
end

if ( 0.143 < d_cp) && (d_cp <= 0.160)            % AWG size = 34; 
    AWG_p = 34;                            
    d_cp_new = 0.160;                  
    Rcu_p = 856;                     
    AreaCu_p = 0.0201;    
end

if ( 0.127 < d_cp) && (d_cp <= 0.143)            % AWG size = 35; 
    AWG_p = 35;                            
    d_cp_new = 0.143;                  
    Rcu_p = 1076;                     
    AreaCu_p = 0.016;    
end

if ( 0.113 < d_cp) && (d_cp <= 0.127)            % AWG size = 36; 
    AWG_p = 36;                            
    d_cp_new = 0.127;                  
    Rcu_p = 1361;                     
    AreaCu_p = 0.0127;    
end

if ( 0.101 < d_cp) && (d_cp <= 0.113)            % AWG size = 37; 
    AWG_p = 37;                            
    d_cp_new = 0.113;                  
    Rcu_p = 1716;                     
    AreaCu_p = 0.01;    
end

if ( 0.090 < d_cp) && (d_cp <= 0.101)            % AWG size = 38; 
    AWG_p = 38;                            
    d_cp_new = 0.101;                  
    Rcu_p = 2164;                     
    AreaCu_p = 0.00797;    
end

if ( 0.080 < d_cp) && (d_cp <= 0.090)            % AWG size = 39; 
    AWG_p = 39;                            
    d_cp_new = 0.090;                  
    Rcu_p = 2729;                     
    AreaCu_p = 0.00632;    
end

if ( 0 < d_cp) && (d_cp <= 0.080)                % AWG size = 40; 
    AWG_p = 40;                            
    d_cp_new = 0.080;                  
    Rcu_p = 3441;                     
    AreaCu_p = 0.00501;    
end

APrimary = AWG_p;
BPrimary = d_cp_new;
CPrimary = Rcu_p;
DPrimary = AreaCu_p;

end

