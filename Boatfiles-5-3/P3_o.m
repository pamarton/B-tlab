clear all
clc

addpath('../Data/');
load('var_o1b.mat');
%load('var_o2');

w_c = 0.1;
phase_margin = 50;
deg2rad = pi/180;
rad2deg = 180/pi;
T_f = -1/(w_c* tan((180-phase_margin)*deg2rad));
K_pd = sqrt(T_f^2 * w_c^4 + w_c^2)/K;
T_d  = T;
course_angle = 30;
course_angle_error = 35;

hold on
addpath('b/');
load_system('op5_3b.slx');
sim('op5_3b.slx');
plot(s_xy(:,1),s_xy(:,2));
save('../Data/var_o3b.mat','w_c','T_f','T_d','K_pd','s_t','s_compass','s_xy','s_delta','s_course_angle','s_course_angle_ref');

addpath('c/');
load_system('op5_3c.slx');
sim('op5_3c.slx');
plot(s_xy(:,1),s_xy(:,2));
save('../Data/var_o3c.mat','w_c','T_f','T_d','K_pd','s_t','s_compass','s_xy','s_delta','s_course_angle','s_course_angle_ref');

addpath('d/');
load_system('op5_3d.slx');
sim('op5_3d.slx');
plot(s_xy(:,1),s_xy(:,2));
save('../Data/var_o3d.mat','w_c','T_f','T_d','K_pd','s_t','s_compass','s_xy','s_delta','s_course_angle','s_course_angle_ref');
