A_1_top = 63.34;
A_1_bot = 4.64;
A_2_top = 4.23;
A_2_bot = 2.57;
A_1 = (A_1_top - A_1_bot)/2;
A_2 = (A_2_top - A_2_bot)/2;
w_1 = 0.005;
w_2 = 0.05;

T_d = ((A_2^2 * w_2^2 - A_1^2 * w_1^2)/(A_1^2 * w_1^4 - A_2^2 * w_2^4))^(1/2);
K = A_1 * (w_1^4 * T^2 + w_1^2)^(1/2);



w_c = 0.1;
phase_margin = 50;
deg2rad = pi/180;
rad2deg = 180/pi;
T_f = -1/(w_c* tan((180-phase_margin)*deg2rad));
K_pd = sqrt(T_f^2 * w_c^4 + w_c^2)/K