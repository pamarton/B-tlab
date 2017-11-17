
% Discretizing system from 5.4.a. Run part 1b and 5.4.a first!
[Ad, Bd] = c2d(A, B, Ts);
[Ad, Ed] = c2d(A, E, Ts);
Cd = C;
Dd = 0;

%% Matrices given in part 5.5.c
% Initial a priori estimate error covariance
P_0_minus = [1 0 0 0 0; 0 0.013 0 0 0; 0 0 pi^2 0 0; 0 0 0 1 0;
    0 0 0 0 2.5e-03];
% Process noise covariance
Q = [30 0; 0 1e-06];
% Initial a priori state estimate
x_0_minus = zeros(5,1);