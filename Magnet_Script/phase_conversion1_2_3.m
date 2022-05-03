clear all;   clear global;  close all;  clc;
format long

fname = sprintf('x0');
load(fname);

eval(['t = ',fname,'(:,1);']);
eval(['a = ',fname,'(:,2);']);
pa = t*360/t(length(t));

[c, pa120] = min(abs(pa - 120));
[c, pa240] = min(abs(pa - 240));

c = [a(pa120:length(a),1);a(2:pa120,1)];
b = [a(pa240:length(a),1);a(2:pa240,1)];

ain = [t,a]; bin = [t,b]; cin = [t,c];