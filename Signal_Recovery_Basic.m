clear all;
close all;
clc;

%-------------------------------------------------------------------------
% This code uses the enframe and overlapadd function of the VOICEBOX 
%-------------------------------------------------------------------------
[x0,fs0] = audioread('C:\Users\CIT-Labs\Documents\MATLAB\Test_audio\a2.wav');
[x,fs] = audioread('C:\Users\CIT-Labs\Documents\MATLAB\Test_audio\a2_guassian_20.wav');

x0 = x0(:,1);
% x = x(1:50000,1);

%fD = @(w,mode) p1_dic(w,mode); 

% Transform x into sparisity domain


% Configure the parameters for the SPGL
epsilon = 0.2;
opts = spgSetParms('verbosity',0);
fD = @(w,mode) p1_dic(w,mode);



% Create the overlapped frame for the audio signal

winSize = 1024;
hop = winSize/4;
overlap = winSize - hop;
wn = sqrt(hann(winSize,'periodic'));
x_framed = enframe(x, wn/sqrt(2), hop); 

F_denoise = zeros(size(x_framed,1),size(x_framed,2));


% Process for each frame
for i = 1:size(x_framed,1)
    signal = x_framed(i,:)';
    w = spg_bpdn(fD, signal, epsilon,opts);
    F_denoise(i,:) = idct(w);
%     F_sep(:,i) = idct(w(1:512));     
end



X_denoised=overlapadd(F_denoise,wn/sqrt(2),hop); % for synthessis
sound(X_denoised, fs);

% analyze the result
subplot(2,1,1);
spectrogram(x,wn,overlap,winSize,fs,'yaxis');
subplot(2,1,2);
spectrogram(X_denoised,wn,overlap,winSize,fs,'yaxis');

%MSE caculation
MSE_dB = MSE_calc(x0, X_denoised,overlap);
