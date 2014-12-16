clear;
clc;
[y,Fs] = audioread('a2.wav');
%sound(y,Fs);
%plot(y(26444:26955));
%A = dctmtx(512);
%D =[A eye(512)];
sigma = 0.1;                                    
opts = spgSetParms('verbosity',0);
fD = @(w,m) somefunction(w,m);
w = spg_bpdn(fD, y(26444:26955), sigma, opts);

x = w(1:512);
e = w(513:1024);
fDCT = @(x) dct(x(1:512,1));
y_recover  = fDCT(x);

hold
%plot(y_recover);
plot(e);