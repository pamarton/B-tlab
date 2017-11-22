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

%% Matrices from 5.5.c
% Initial a priori estimate error covariance
P_0_minus = [1 0 0 0 0; 0 0.013 0 0 0; 0 0 pi^2 0 0; 0 0 0 1 0;
    0 0 0 0 2.5e-03];
% Process noise covariance
Q = [30 0; 0 1e-06];
% Initial a priori state estimate
X_0_minus = zeros(5,1);


%% Problem 5.5.c 
 R = R/Ts;
 I = diag([1 1 1 1 1]);

% Put the data into a struct
data = struct('Ad',Ad,'Bd',Bd,'Cd',Cd,'Ed', Ed, 'Q',Q,'R', R,'P_0_minus',P_0_minus, ...
'X_0_minus',X_0_minus, 'I', I);

%other
course_angle = 30;
course_angle_error = 45;
rad2deg = 180/pi;
deg2rad = pi/180;

save('../Data/var_o5c.mat');