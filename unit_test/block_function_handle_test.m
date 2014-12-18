clear all;
close all;
clc;
addpath '../'
%-------------------------------------------------------------------------
% This code uses the enframe and overlapadd function of the VOICEBOX 
%-------------------------------------------------------------------------
% x0 = sin(0.01:0.01:20*pi)';
sig_length = 10240;
inter = 1;
x3 = sin(inter:inter:sig_length*inter)';
inter = 1/50;
x2 = sin(inter:inter:sig_length*inter)';
inter = 1/3;
x1 = sin(inter:inter:sig_length*inter)';
x0 = x1+x2+x3;

% x0 = linspace(1,sig_length,sig_length)';
% x0 = ones(10240,1);

% x = x0 + randn(length(x0),1);
fs = 44100;

% Configure the parameters for the SPGL
epsilon = 0.2;
opts = spgSetParms('verbosity',0);
fD = @(w,mode) nowindow_dct_block_dic(w,mode);

% x_hat = spg_bpdn(fD, x0, epsilon,opts);

% Create the overlapped frame for the audio signal

winSize = 1024;
hop = winSize/2;
overlap = winSize - hop;
wn = sqrt(hann(winSize,'periodic'));
% wn = ones(winSize,1);
x_framed = enframe(x0, wn, hop); 

test = dct(x_framed');


num_of_frames = floor((sig_length - winSize)/hop) + 1;

bbbb = reshape(test,[num_of_frames*1024,1]);
length_y = winSize + (num_of_frames-1) * hop;
% length_y = winSize * num_of_frames;
y = zeros(length_y,1);



% Group calculation
n = length_y;
block_size = floor((length_y - winSize)/hop) + 1;
num_of_blocks = winSize;
Group = reshape(repmat(linspace(1,winSize,winSize),block_size,1),num_of_blocks*block_size,1);

X_block_recovered  = spg_group(fD,x0,Group,0,opts); 





test_function_y = fD(x0, 2);
test_function_x = fD(test_function_y,1);

X_denoised=overlapadd(x_framed,wn,hop); % for synthessis
sound(X_denoised, fs);
% 
% % analyze the result
subplot(2,1,1);
spectrogram(x0,wn,overlap,winSize,fs,'yaxis');
subplot(2,1,2);
spectrogram(X_denoised,wn,overlap,winSize,fs,'yaxis');

% error = X_denoised - y;
% 
% %MSE caculation
MSE_dB = MSE_calc(x0, X_denoised, overlap);
