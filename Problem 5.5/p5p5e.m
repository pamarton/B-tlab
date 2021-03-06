clear all
clc

PSI_r = 30; % Reference angle for simulation
simulation_time = 1000;
addpath('../Data') % Add folder for .mat-files

load('var_o1b.mat');
load('var_o2.mat');
load('var_o3d.mat');
load('var_o4.mat');
load('var_o5a.mat');
load('var_o5b.mat');
load('var_o5c.mat');

course_angle = 30;
course_angle_error = 45;
rad2deg = 180/pi;
deg2rad = pi/180;

load_system('p5p5e_simulink.mdl');
sim('p5p5e_simulink.mdl');

hold on
plot(s_t,s_course_angle);
plot(s_t,s_compass);
%plot(s_t,s_course_angle_ref);
load('var_o1b.mat');
load('var_o2.mat');
load('var_o3d.mat');

plot(s_t,s_compass);%5.3.d
hold off


save('../Data/var_o5e.mat');