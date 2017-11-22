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
%



function [b,psi] = Kalman_matlab_fnc(u, y, data)
%#codegen
persistent flag_initialized A B C E Q R P_0_min X_0_min I
if (isempty(flag_initialized))
flag_initialized = 1;
% Initialization for system
[A,B,C,E,Q,R,P_0_min,X_0_min, I] = deal(data.Ad,data.Bd,data.Cd,data.Ed, ...
data.Q, data.R, data.P_0_minus, data.X_0_minus, data.I);
end

% Compute the gain
L = (P_0_min*C')/((C*P_0_min*C'+R));

%Update the estimate 
x = X_0_min + L*(y-C*X_0_min);

P = (I - L*C)*P_0_min*(I-L*C)'+L*R*L';

X_0_min = A*x + B*u;
P_0_min = A*P*A' + E*Q*E';
psi = x(3); b = x(5);

end

