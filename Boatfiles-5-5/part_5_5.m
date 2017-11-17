clear all

PSI_r = 30; % Reference angle for simulation
simulation_time = 1000;
addpath('../Data') % Add folder for .mat-files

load('var_o1b.mat')
load('var_o2.mat')
load('var_o3d.mat')
load('var_o4.mat')

%% Part 5.5.a
%Discretizing system from 5.4.a. 
% Run part 1b and 5.4.a first!
[Ad, Bd] = c2d(A, B, Ts);
[Ad, Ed] = c2d(A, E, Ts);
Cd = C;
Dd = 0;



%% Part 5.5.b  
% R = E{v^2} = measurement noise variance / Tss
R = var(s_compass*pi/180);
%
%% Matrices given in part 5.5.c
% Initial a priori estimate error covariance
P_0_minus = [1 0 0 0 0; 0 0.013 0 0 0; 0 0 pi^2 0 0; 0 0 0 1 0;
    0 0 0 0 2.5e-03];
% Process noise covariance
Q = [30 0; 0 1e-06];
% Initial a priori state estimate
X_0_minus = zeros(5,1);


%% Task 5.5.c ???? Discrete Kalman Filter
 R = R/Ts;
 I = diag([1 1 1 1 1]);

% \\\ Put data in a struct for use in the Kalman filter
data = struct('Ad',Ad,'Bd',Bd,'Cd',Cd,'Ed', Ed, 'Q',Q,'R', R,'P_0_minus',P_0_minus, ...
'X_0_minus',X_0_minus, 'I', I);
%



function [b,psi] = Kalman_matlab_fnc(u, y, data)
%#codegen
persistent init_flag A B C E Q R P_ x_ I
if (isempty(init_flag))
init_flag = 1;
% Initialization for system
[A,B,C,E,Q,R,P_,x_, I] = deal(data.Ad,data.Bd,data.Cd,data.Ed, ...
data.Q, data.R, data.P_0, data.X_0, data.I);
end

% Compute the Kalman Gain
L = (P_*C')/((C*P_*C'+R));
%Update estimate with measurment
x = x_ + L*(y-C*x_);
% 3 ? Update error covariance matrix
P = (I - L*C)*P_*(I-L*C)'+L*R*L';
% Projet ahead
x_ = A*x + B*u;
P_ = A*P*A' + E*Q*E';
psi = x(3); b = x(5);
end

