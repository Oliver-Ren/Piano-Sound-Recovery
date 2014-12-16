clear;
clc;
[y,Fs] = audioread('mussorgsky.wav');
%sound(y,Fs);
%plot(y(26444:26955));
%A = dctmtx(512);
%D =[A eye(512)];
sigma = 0.1;                                    
opts = spgSetParms('verbosity',0);
fD = @(w,m) somefunction(w,m);
y_recover = [];
e_recover = [];



for i = 1 : 512 : 1591809
%for i = 10000 : 512 : 20600    
  w = spg_bpdn(fD, y(i:i+511), sigma, opts);  
  x = w(1:512);
  e = w(513:1024);
  fDCT = @(x) dct(x(1:512,1));
  y0 = fDCT(x);
  y_recover = [y_recover ; y0];
  e_recover = [e_recover ; e];
end

y1(1:256) = y_recover(1:256);
e(1:256) = y_recover(1:256);

for i = 257 : 512 : 1592065
%for i = 10000 : 512 : 20600    
  w0 = spg_bpdn(fD, y_recover(i:i+511), sigma, opts);  
  x0 = w0(1:512);
  e0 = w0(513:1024);
  fDCT = @(x) dct(x(1:512,1));
  y0 = fDCT(x0);
  y1(i:i+511) = y0;
  e(i:i+511) = e0;
end
