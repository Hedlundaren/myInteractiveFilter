clc
clear all;
[y,fs]=wavread('Lumus');
% Korta av ljudfilen till 5 sekunder musik
y = y(1:(5*fs));
W=2*900/fs;
num=fir1(20000,[W-0.15 W+0.005],'stop');
y2=filter(num,50,y);
% Lyssna p� filtrerat ljud och plotta frekvensg�ngen f�r filtret
%input('V�nta tills st�rda musiken spelat f�rdigt ....');
soundsc(y2,fs);
freqz(num,1);