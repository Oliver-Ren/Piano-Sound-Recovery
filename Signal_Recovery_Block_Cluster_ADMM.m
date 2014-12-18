%%
%-------------------------------------------------------------------------
% Piano Sound Recovery using Block Sparsity, optimized with Cluster Norm
% Version 1.0
%
% In this version, we tried to implement the function handle as professor
% Studer talked
%
% 
%
% This code uses the enframe and overlapadd function of the VOICEBOX, SPGL,
% and Toolbox_Optim
%-------------------------------------------------------------------------

addpath('./spgl1-1.8');
addpath('./toolbox_optim');
addpath('./toolbox_optim/toolbox/');

%%
% Read from the original sound
[x0,fs0] = audioread('.\Test_audio\a2.wav');
x0 = x0(:,1);

% Read from the noised sound
[x,fs] = audioread('.\Test_audio\a2_guassian_20.wav');

%%
% matching the length to the window length 
winSize = 1024;
hop = winSize/2;
overlap = winSize - hop;
wn = sqrt(hann(winSize,'periodic'));
sig_length = length(x);
num_of_frames = floor((sig_length - winSize)/hop) + 1;
length_x = winSize + (num_of_frames-1) * hop;

%%
%% matching the length of wav
signal_without_noise = x0(1:length_x,1);
signal_with_noise = x(1:length_x,1);


%%
% Calculate the group information
block_size = num_of_frames;
num_of_blocks = winSize;
Group = reshape(repmat(linspace(1,winSize,winSize),block_size,1),num_of_blocks*block_size,1);

%%
% Configure the parameters for the SPGL
% epsilon = 1.8;
opts = spgSetParms('verbosity',0);
fD = @(w,mode) overlap_dct_block_dic(w,mode);

%%
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

%%
%plot the spectrogram
figure();
subplot(2,2,1);
spectrogram(signal_without_noise,wn,overlap,winSize,fs,'yaxis');
colorbar;
y_max = 6000;
title('Spectrogram of original piano sound A5');
ylim([0 6000]);
subplot(2,2,2);
spectrogram(signal_with_noise,wn,overlap,winSize,fs,'yaxis');
title('Spectrogram of piano sound A5 with noise SNR = 20dB');
ylim([0 6000]);
colorbar;
subplot(2,2,3);
spectrogram(X_denoised(:,1),wn,overlap,winSize,fs,'yaxis');
title(['Spectrogram of denoised piano sound A5, \epsilon=' num2str(epsilon)]);
ylim([0 6000]);
colorbar;
Cluster_ADMM_Continued;





 