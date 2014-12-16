clear all;
close all;
clc;
[y,Fs] = audioread('a2.wav');
%sound(y,Fs);
xLeft = y(:,1);
[m,n] = size(xLeft);

plot(xLeft);
XLeftFFT = fft(xLeft);
XLeftMag = log(abs(XLeftFFT));
figure();
plot(XLeftMag);
y = xLeft + randn(m,1) * 0.0075;
figure();
plot(y);
Y = fft(y);
YMag = log10(abs(Y));
figure();
plot(YMag);
sound(y(1:250000),Fs);
audiowrite('a2_guassian.wav',y(1:250000),Fs);
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