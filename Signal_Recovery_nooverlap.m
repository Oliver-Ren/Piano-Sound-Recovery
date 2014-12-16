clear all;
close all;
clc;

%-------------------------------------------------------------------------
% This code uses the enframe and overlapadd function of the VOICEBOX 
%-------------------------------------------------------------------------
[x0,fs0] = audioread('C:\Users\CIT-Labs\Documents\MATLAB\Test_audio\a2.wav');
[x,fs] = audioread('C:\Users\CIT-Labs\Documents\MATLAB\Test_audio\a2_guassian.wav');
% x = x(1:50000,1);

% Configure the parameters for the SPGL
epsilon = 0.18;
opts = spgSetParms('verbosity',0);
fD = @(w,mode) p1_dic(w,mode);

x_length = 512;
x_width = floor(length(x)/x_length);
x_size = x_length * x_width;
x_framed = reshape(x(1:x_size), x_length, x_width); 

F_denoise = zeros(size(x_framed,1),size(x_framed,2));

% Process for each frame
for i = 1:size(x_framed,2)
    signal = x_framed(:,i);
    w = spg_bpdn(fD, signal, epsilon,opts);
    F_denoise(:,i) = idct(w);   
end



sound(reshape(F_denoise, x_size ,1), fs);

% analyze the result
subplot(2,1,1);
%spectrogram(x,wn,overlap,winSize,fs,'yaxis');
subplot(2,1,2);
%spectrogram(X_denoised,wn,overlap,winSize,fs,'yaxis');

%MSE caculation
MSE_noise = mean((reshape(F_denoise, x_size ,1) - x(1:x_size)).^2);