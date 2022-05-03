function [xn, yn] = interpol(x,y,xn)

% dbstop if error
% dbclear if error

x = [0; x];  y = [0; y];
for i = 1:1:length(y)
    if i ~= 1 && y(i) == 0
        break;
    end
end
% x = x(1:length(x)-2,1);     y = y(1:length(y)-2,1);
x = x(1:i-1,1);     y = y(1:i-1,1);
for j = 1:1:length(x)
    if x(j) > xn    
        break   
    end
end
if max(x) > xn
%     xc = [x(j-1,1) x(j,1)];   yc = [y(j-1,1) y(j,1)];   yn = interp1(xc,yc,xn,'linear'); 
    yn = ((xn-x(j-1,1))/(x(j,1)-x(j-1,1))*(y(j,1)-y(j-1,1)))+y(j-1,1);  
elseif max(x) <= xn || min(x) >= xn
    xc = x;   yc = y;   yn = interp1(xc,yc,xn,'linear','extrap'); 
end