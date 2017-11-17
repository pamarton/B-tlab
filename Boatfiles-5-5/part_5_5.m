
%% Part 5.5.a
%Discretizing system from 5.4.a. 
% Run part 1b and 5.4.a first!
[Ad, Bd] = c2d(A, B, Ts);
[Ad, Ed] = c2d(A, E, Ts);
Cd = C;
Dd = 0;

%% Part 5.5.b  
load_system('task5_5_b.slx')
sim('task5_5_b.slx')
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


%% Task 5.5.c ???? Discrete Kalman Filter
 R = R/T_s;
 I = diag([1 1 1 1 1]);

% \\\ Put data in a struct for use in the Kalman filter
data = struct('Ad',Ad,'Bd',Bd,'Cd',Cd,'Ed', Ed, 'Q',Q,'R', R,'P_0',P_0, ...
'X_0',X_0, 'I', I);
%

%% Task