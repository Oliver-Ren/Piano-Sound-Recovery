clear all;
close all;
clc;
[x Fs] = audioread('C:\Users\CIT-Labs\Documents\MATLAB\Test_audio\a2.wav');
xLeft = x(:,1);
plot(xLeft);
XLeftFFT = dct(xLeft);
figure();
plot(XLeftFFT);

y = awgn(xLeft,10,'measured'); 
Y = log10(abs(fft(y)));
figure();
plot(Y);
winSize = 2048;
hop = winSize/4;
overlap = winSize - hop;
wn = hann(winSize,'periodic');
x_framed = enframe(xLeft, wn, hop);
X_framed = fft(x_framed);
X_Mag = log10(abs(X_framed));
X_Ang = angle(X_framed);


figure();
spectrogram(xLeft,wn,overlap,winSize,Fs,'yaxis');

spectrogram(y,wn,overlap,winSize,Fs,'yaxis');

sound(y,Fs);
    % Get the angle



% wavplay(xLeft,Fs);