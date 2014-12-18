clear all;
close all;
clc;
[y,Fs] = audioread('C:\Users\CIT-Labs\Desktop\wind_noise_light.wav');
[y1,Fs1] = audioread('C:\Users\CIT-Labs\Documents\GitHub\Piano-Sound-Recovery\Test_audio\a2.wav');
%sound(y,Fs);
y = y(:,1);
y1 = y1(:,1);

size = length(y);
yout = y/5 + y1(1:size);


audiowrite('a2_wind.wav',yout,Fs);
