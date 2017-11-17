close all
clc
clear variables

addpath('../Data');

A_1_top = 63.34;
A_1_bot = 4.64;
A_2_top = 4.23;
A_2_bot = 2.57;
A_1 = (A_1_top - A_1_bot)/2;
A_2 = (A_2_top - A_2_bot)/2;
w_1 = 0.005;
w_2 = 0.05;

T = ((A_2^2 * w_2^2 - A_1^2 * w_1^2)/(A_1^2 * w_1^4 - A_2^2 * w_2^4))^(1/2);
K = A_1 * (w_1^4 * T^2 + w_1^2)^(1/2);

TEMP = 9001;

load_system('p5p1b_simulink.mdl');
sim('p5p1b_simulink.mdl');

save('../Data/var_o1b.mat');