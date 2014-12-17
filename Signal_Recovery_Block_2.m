clear all;
close all;
clc;

%-------------------------------------------------------------------------
% Piano Sound Recovery using Block Sparsity, Version 2.0
% In this version, we tried to implement the function handle as professor
% Studer talked

% This code uses the enframe and overlapadd function of the VOICEBOX 
%-------------------------------------------------------------------------

% Read from the original sound
[x0,fs0] = audioread('.\Test_audio\a2.wav');
x0 = x0(:,1);

% Read from the noised sound
[x,fs] = audioread('.\Test_audio\a2_guassian_20.wav');

% matching the length to the window length 
winSize = 1024;
hop = winSize/2;
overlap = winSize - hop;
wn = sqrt(hann(winSize,'periodic'));
sig_length = length(x);
num_of_frames = floor((sig_length - winSize)/hop) + 1;
length_x = winSize + (num_of_frames-1) * hop;
signal_with_noise = x(1:length_x,1);

% Calculate the group information
block_size = num_of_frames;
num_of_blocks = winSize;
Group = reshape(repmat(linspace(1,winSize,winSize),block_size,1),num_of_blocks*block_size,1);


% Configure the parameters for the SPGL
% epsilon = 1.8;
opts = spgSetParms('verbosity',0);
fD = @(w,mode) nowindow_dct_block_dic(w,mode);


% iteration of calculation of different epsilons
num_iter = 1;
% epsilon = linspace(0.1,2.5,num_iter);
epsilon = 1;
MSE_dB = zeros(num_iter,1);
PSNR_dB = zeros(num_iter,1);
X_denoised = zeros(length_x,num_iter);
for i = 1:num_iter
    % Denoise
    tic
    x_hat = spg_group(fD, signal_with_noise, Group, epsilon(i),opts);
    toc
    X_denoised(:,i) = fD(x_hat,1); % for synthessis
    sound(X_denoised(:,i), fs);
    
    % analyze the result
    %MSE caculation
    [MSE_dB(i), PSNR_dB(i)] = MSE_PSNR_calc(x0, X_denoised(:,i),overlap);
end

subplot(2,1,1);
spectrogram(x,wn,overlap,winSize,fs,'yaxis');
subplot(2,1,2);
spectrogram(X_denoised(:,1),wn,overlap,winSize,fs,'yaxis');

figure();
plot(epsilon,MSE_dB);
title()
figure();
plot(epsilon,PSNR_dB);

