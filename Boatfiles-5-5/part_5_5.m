
%% Part 5.5.a
%Discretizing system from 5.4.a. 
% Run part 1b and 5.4.a first!
[Ad, Bd] = c2d(A, B, Ts);
[Ad, Ed] = c2d(A, E, Ts);
Cd = C;
Dd = 0;

%% yeah
figNum = 1; % Figure number?counter
PSI_r = 30; % Reference angle for simulation
sim_t = 500;
addpath('Datafiles') % Add folder for .mat-files
%load('constants_5.2.mat') % K_w, lambda, omega_0, sigma
%load('constants_5.3.mat') % K, K_pd, T, T_d, T_f, w_c

% \\\ X and Y output of ship
% in task 5.3.b/c/d ///
load('north_east_5.3.mat') % x1, x2, x3, y1, y2, y3

% \\\ Rudder input to ship
% in task 5.3.b/c/d ///
load('rudder_input_5.3.mat') % delta1, delta2, delta3, t1, t2, t3
% \\\ Psi output of ship
% in task 5.3.b/c/d ///
load('compass_measurment_5.3.mat') % psi1, psi2, psi3
% \\\ Add working path for simulink models
addpath('Simulink models tasks')

%% Part 5.5.b  
load_system('../Boatfiles-5-3/b/op53b.slx')
sim('op53b.slx')
% R = E{v^2} = measurement noise variance / T_s
R = var(sim_compass*pi/180);
%
%% Matrices given in part 5.5.c
% Initial a priori estimate error covariance
P_0_minus = [1 0 0 0 0; 0 0.013 0 0 0; 0 0 pi^2 0 0; 0 0 0 1 0;
    0 0 0 0 2.5e-03];
% Process noise covariance
Q = [30 0; 0 1e-06];
% Initial a priori state estimate
x_0_minus = zeros(5,1);

%{
%% Task 5.5.c ???? Discrete Kalman Filter
 R = R/T_s;
 I = diag([1 1 1 1 1]);

% \\\ Put data in a struct for use in the Kalman filter
data = struct('Ad',Ad,'Bd',Bd,'Cd',Cd,'Ed', Ed, 'Q',Q,'R', R,'P_0',P_0, ...
'X_0',X_0, 'I', I);
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
x = x_ + L*(y?C*x_);
% 3 ? Update error covariance matrix
P = (I ? L*C)*P_*(I?L*C)'+L*R*L';
% Projet ahead
x_ = A*x + B*u;
P_ = A*P*A' + E*Q*E';
psi = x(3); b = x(5);
end
%}
