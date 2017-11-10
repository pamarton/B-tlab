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


%% Estimating Power Spectral Density PSD
[pxx,f] = pwelch(psi_w(2,:).*pi/180,window,noverlap,nfft,fs);
% Scaling power per Hz to power s/rad
pxx = pxx*1/(2*pi);
% Scaling frequency to rad/s
omega = f*2*pi;