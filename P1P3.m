clear all;
close all;
clc;

%-------------------------------------------------------------------------
% This code uses the enframe and overlapadd function of the VOICEBOX 
%-------------------------------------------------------------------------
[x,fs] = audioread('./Test_audio/a2_guassian.wav');
fD = @(w, mode) p1_dic(w, mode); 
epsilon = 0.001;
opts = spgSetParms('verbosity',0);
% player = audioplayer(seg,fs);
% play(player);
INC=256;                               % set frame increment in samples
NW=INC*2;                            % oversample by a factor of 2 (4 is also often used)
W=sqrt(hamming(NW,'periodic'));     % sqrt hamming window of period NW
F=enframe(x,W,INC)'; 
F_sep = zeros(size(F,1),size(F,2));
for i = 1:length(F)
     w = spg_bpdn(fD, F(:,i), epsilon,opts);
     F_sep(:,i) = idct(w(1:512));     
end
X=overlapadd(F_sep',W,INC);
wavwrite(X,44100,'a2_guassian_sep.wav');

