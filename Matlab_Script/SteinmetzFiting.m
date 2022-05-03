function [ factor1, factor2, factor3 ] = SteinmetzFiting( fsw )

% Steinmetz fitting coefficients for rectangular voltage excitation 
% and Bm > 0.1 T
   
if (fsw == 50)
    K = 0.12;
    A = 0;
    B = 1.667;
end

if (fsw == 400)
    K = 2.014;
    A = 0;
    B = 1.81;
end

if (fsw == 1000)
    K = 7.31;
    A = 0;
    B = 1.734;
end

if (fsw == 2000)
    K = 19.447;
    A = 0;
    B = 1.777;
end

if (fsw == 2500)
    K = 26.534;
    A = 0;
    B = 1.724;
end

if (fsw == 3100)
    K = 35.803;
    A = 0;
    B = 1.679;
end

if (fsw == 4000)
    K = 52.919;
    A = 0;
    B = 1.642;
end

if (fsw == 5000)
    K = 72.932;
    A = 0;
    B = 1.646;
end

if (fsw == 8000)
    K = 149.592;
    A = 0;
    B = 1.655;
end

factor1 = (8/pi^2)^(A-1)*(8/pi^2)^(1-A)*K;
factor2 = A;
factor3 = B;

return

