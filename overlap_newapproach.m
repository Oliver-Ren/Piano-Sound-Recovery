clear all;
close all;
clc;

%-------------------------------------------------------------------------
% This code uses the enframe and overlapadd function of the VOICEBOX 
%-------------------------------------------------------------------------
[x0,fs0] = audioread('C:\Users\CIT-Labs\Documents\MATLAB\Test_audio\a2.wav');
[x,fs] = audioread('C:\Users\CIT-Labs\Documents\MATLAB\Test_audio\a2_guassian_20.wav');
% x = x(1:50000,1);

%fD = @(w,mode) p1_dic(w,mode); 

% Transform x into sparisity domain


% Configure the parameters for the SPGL
epsilon = 0.5;
opts = spgSetParms('verbosity',0);
% Create the overlapped frame for the audio signal

winSize = 1024;
hop = winSize/4;
overlap = winSize - hop;
wn = hann(winSize,'periodic');
x_framed = enframe(x, wn, hop); 

F_denoise = zeros(size(x_framed,1),size(x_framed,2));
prev_signal = zero(1,size(x_framed,1));

% Process for each frame
for i = 1:size(x_framed,1)
    signal = x_framed(i,:)';
    w = spg_bpdn(fD, signal, epsilon,opts);
    F_denoise(i,:) = idct(w);
%     F_sep(:,i) = idct(w(1:512));     
end



X_denoised=overlapadd(F_denoise,wn/1.5,hop); % for synthessis
sound(X_denoised, fs);

% analyze the result
subplot(2,1,1);
spectrogram(x,wn,overlap,winSize,fs,'yaxis');
subplot(2,1,2);
spectrogram(X_denoised,wn,overlap,winSize,fs,'yaxis');

%MSE caculation
MSE = mean((X_denoised - x0(1:size(X_denoised, 1))').^2);
