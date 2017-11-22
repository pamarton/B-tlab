clear all
clc

addpath('../Data') % Add folder for .mat-files
load('var_o4.mat','A','B','Ts','E','C')

%% Problem 5.5.a
[Ad, Bd] = c2d(A, B, Ts);
[Ad, Ed] = c2d(A, E, Ts);
Cd = C;
Dd = 0;

save('../Data/var_o5a.mat');

