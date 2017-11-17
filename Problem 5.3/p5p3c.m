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

load_system('p5p3c_simulink.mdl');
sim('p5p3c_simulink.mdl');
figure;
plot(s_xy(:,1),s_xy(:,2));
legend('5.3c yx-plot');
figure;
plot(s_t(:),s_delta(:));
legend('5.3c delta-plot');
figure;
plot(s_t(:),s_compass(:));
legend('5.3c compass-plot');
save('../Data/var_o3c.mat','w_c','T_f','T_d','K_pd','s_t','s_compass','s_xy','s_delta','s_course_angle','s_course_angle_ref','course_angle');