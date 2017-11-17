%% Fresh start
clear
clc

%% Constants
pi = 3.141579;
% Sampling frequency in Hertz
fs = 10;
window = 4096;
noverlap = [];
nfft = [];

%% Loading wave matrix
load('wave.mat')

%% Loading constants from '../../Data'
addpath('../Data');
load('var_o1b.mat');

%% Estimating Power Spectral Density PSD
[S_psi,f] = pwelch(psi_w(2,:).*pi/180,window,noverlap,nfft,fs);
% Scaling power per Hz to power s/rad
S_psi = S_psi*1/(2*pi);
% Scaling frequency to rad/s
omega = f*2*pi;
% Eigen frequency from plot
omega_0 = 0.7823;
% Max amplitude from spectral plot
sigma_squared = 1.5E-03;
% Standard deviation from spectral plot
sigma = sqrt(sigma_squared);
%% Identifying damping factor
%lambda = 1;
%omega_vector = 1:150;
%Kw = 2*lambda*omega_0*sigma;

%% Plotting estimated PSD in part 5.2.c
figure
hold on
plot(omega, S_psi)
xlim([0,1.5])
%xlim([0,1.5])
xlabel('Angular frequency, rad')
ylabel('Estimated Spectral Density')

%% Curve fitting in part 5.2.d
P_psi = @(lambda,omega)((2*lambda*omega_0*sigma)^2.*omega.^2) ./...
    (omega_0^4 +  + omega.^4 + 2*omega_0^2*omega.^2*(2*lambda^2 - 1));
x0 = 1;
lambda_fitted = lsqcurvefit(P_psi,x0,omega,S_psi);
%% Plotting curve fitting in part 5.2.d
figure
hold on
plot(omega, S_psi)
xlim([0,1.5])
plot(omega, P_psi(lambda_fitted,omega))
%xlim([0,1.5])
xlabel('Angular frequency, rad')
ylabel('Estimated and analytical PSD')

save('../Data/var_o2.mat','omega_0','lambda_fitted');
