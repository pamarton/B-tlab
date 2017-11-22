function [b,psi] = Kalman_function(u, y, data)
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
