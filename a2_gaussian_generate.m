clear all;
close all;
clc;
[y,Fs] = audioread('24nocturnea.wav');
%sound(y,Fs);
xLeft = y(:,1);
[m,n] = size(xLeft);

plot(xLeft);
XLeftFFT = fft(xLeft);
XLeftMag = log(abs(XLeftFFT));
figure();
plot(XLeftMag);
y = awgn(xLeft,10,'measured'); 
figure();
plot(y);
Y = fft(y);
YMag = log10(abs(Y));
figure();
plot(YMag);
start_time = 40;
end_time = 60;
start_sample = start_time * Fs;
end_sample = end_time * Fs;

sound(y(start_sample:end_sample),Fs);

audiowrite('./Test_audio/24nocturnea_gaussian_10.wav',y(start_sample:end_sample),Fs);
%A = dctmtx(512);
%D =[A eye(512)];
% sigma = 0.1;                                    
% opts = spgSetParms('verbosity',0);
% fD = @(w,m) somefunction(w,m);
% w = spg_bpdn(fD, y(26444:26955), sigma, opts);
% 
% x = w(1:512);
% e = w(513:1024);
% fDCT = @(x) dct(x(1:512,1));
% y_recover  = fDCT(x);
% 
% hold
% %plot(y_recover);
% plot(e);