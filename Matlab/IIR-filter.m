clc
clear all;
[y,fs]=wavread('Lumus');
% Korta av ljudfilen till 5 sekunder musik
y = y(1:(5*fs));
W=2*900/fs;
num=fir1(20000,[W-0.15 W+0.005],'stop');
y2=filter(num,50,y);
% Lyssna på filtrerat ljud och plotta frekvensgången för filtret
%input('Vänta tills störda musiken spelat färdigt ....');
soundsc(y2,fs);
freqz(num,1);