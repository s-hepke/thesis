% Function Description: Given a point with coordinetes "xi" and "yi", the
% function provides che coordinates of a point displaced by the angle "angle" 
% from the initial point 

function [xo,yo] = Rot_Point(xi,yi,angle)
xo = real((xi + 1i*yi).* exp(1i*angle));
yo = imag((xi + 1i*yi).* exp(1i*angle));
