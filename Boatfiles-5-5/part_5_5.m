
% Discretizing system from 5.4.a. Run part 1b and 5.4.a first!
[Ad, Bd] = c2d(A, B, Ts);
[Ad, Ed] = c2d(A, E, Ts);
Cd = C;
Dd = 0;