% Inserting K parameter with waves
clear all
clc
load('../Data/var_o1b.mat');
load('../Data/var_o2.mat');

Kw = 0.1761;
% Sampling frequency in Hertz
f_s = 10;
% Sampling time in seconds
Ts = 1/f_s;
A = [0 1 0 0 0; 
    -omega_0^2 -2*lambda_fitted*omega_0 0 0 0; 
    0 0 0 1 0;
    0 0 0 -1/T -K/T; 
    0 0 0 0 0];
B = [0; 0; 0; K/T; 0];
C = [0 1 1 0 0];
E = [0 0; Kw 0; 0 0; 0 0; 0 1];

obsverv = obsv(A,C);

save('../Data/var_o4.mat');
