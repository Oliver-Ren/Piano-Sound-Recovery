clear all;
close all;
clc;

%-------------------------------------------------------------------------
% This code uses the enframe and overlapadd function of the VOICEBOX 
%-------------------------------------------------------------------------
% x0 = sin(0.01:0.01:20*pi)';
sig_length = 2048;
x0 = ones(sig_length,1);


% x = x0 + randn(length(x0),1);
fs = 44100;

% Configure the parameters for the SPGL
epsilon = 0.2;
opts = spgSetParms('verbosity',0);
fD = @(w,mode) overlap_dct_dic(w,mode);

x_hat = spg_bpdn(fD, x0, epsilon,opts);

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


% Dt Calculation
% for frame = 0:num_of_frames-1
%     offset_w = frame * hop;
%     offset_y = frame * winSize;
%     y(offset_y+1:offset_y+winSize,1) = dct(x0(frame+1:frame+winSize,1));
% end

% for frame = 0:num_of_frames-1
%     offset = frame * hop;
%     y(offset+1:offset+winSize,1) = y(offset+1:offset+winSize,1) + idct(x0(frame+1:frame+winSize,1));
% end

% num_of_xframes = 
fD = @(w,mode) overlap_dct_dic(w,mode);
test_function_y = fD(x0, 2);
test_function_x = fD(test_function_y,1);
% 
% % F_denoise = zeros(size(x_framed,1),size(x_framed,2));
% 
% % 
% % % Process for each frame
% % for i = 1:size(x_framed,1)
% %     signal = x_framed(i,:)';
% %     w = spg_bpdn(fD, signal, epsilon,opts);
% %     F_denoise(i,:) = idct(w);
% % %     F_sep(:,i) = idct(w(1:512));     
% % end
% 
% 
% 
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
