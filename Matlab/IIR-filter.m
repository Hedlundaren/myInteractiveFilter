clc
clear all;
[x,fs]=wavread('Trubadur');
% Korta av ljudfilen till 5 sekunder musik
x = x(1:(5*fs));

t=0:(1/fs):5;

y = x;




% Skapa BS-filter med lämpligt omega (W) som motsvarar f = 800 Hz.
% När funktionen "fir1" används måste två värden på digitala brytfrekv.
% anges. Välj t.ex. nedre gränsen W-0.01 och övre gränsen W+0.01.
% Observera att W anges utan "pi" i MATLAB.
W=2*3000/fs;
num=fir1(10000,[W-0.12 W+0.10],'stop');
% Filtrera den störda filen (y) och skapa en filtrerad variant (y2)
% Funktionen "filter" är användbar för både FIR- och IIR-filter.
% Här skulle det lika gärna kunna fungera med "y2 = conv(num,y);"
y2=filter(num,50,y);
% Lyssna på filtrerat ljud och plotta frekvensgången för filtret
%input('Vänta tills störda musiken spelat färdigt ....');
%soundsc(y2,fs);
freqz(num,1);