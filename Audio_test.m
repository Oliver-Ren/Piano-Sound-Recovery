clear all;
close all;
clc;

%-------------------------------------------------------------------------
% This code uses the enframe and overlapadd function of the VOICEBOX 
%-------------------------------------------------------------------------
% x0 = sin(0.01:0.01:20*pi)';
x0 = ones(6000,1);

% x = x0 + randn(length(x0),1);
fs = 44100;

% Configure the parameters for the SPGL
epsilon = 0.5;
opts = spgSetParms('verbosity',0);
fD = @(w,mode) p1_dic(w,mode);



% Create the overlapped frame for the audio signal

winSize = 1024;
hop = winSize/2;
overlap = winSize - hop;
wn = sqrt(hann(winSize,'periodic'));
x_framed = enframe(x0, wn, hop); 

% F_denoise = zeros(size(x_framed,1),size(x_framed,2));

% 
% % Process for each frame
% for i = 1:size(x_framed,1)
%     signal = x_framed(i,:)';
%     w = spg_bpdn(fD, signal, epsilon,opts);
%     F_denoise(i,:) = idct(w);
% %     F_sep(:,i) = idct(w(1:512));     
% end



X_denoised=overlapadd(x_framed,wn,hop); % for synthessis
sound(X_denoised, fs);

% analyze the result
subplot(2,1,1);
spectrogram(x0,wn,overlap,winSize,fs,'yaxis');
subplot(2,1,2);
spectrogram(X_denoised,wn,overlap,winSize,fs,'yaxis');

%MSE caculation
MSE_dB = MSE_calc(x0, X_denoised, overlap);
