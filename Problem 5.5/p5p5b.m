clear all
clc

addpath('../Data') % Add folder for .mat-files

load('var_o1b.mat')

%% Problem 5.5.b  


simulation_time = 10000; %High number to ensure an accurate variance
load_system('p5p5b_simulink.mdl');
sim('p5p5b_simulink.mdl');

hold on;

plot(s_t,s_compass);
R = var(s_compass*pi/180);

save('../Data/var_o5b.mat');

