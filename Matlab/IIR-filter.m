clc
clear all;
[x,fs]=wavread('Trubadur');
% Korta av ljudfilen till 5 sekunder musik
x = x(1:(5*fs));

t=0:(1/fs):5;

y = x;




% Skapa BS-filter med l�mpligt omega (W) som motsvarar f = 800 Hz.
% N�r funktionen "fir1" anv�nds m�ste tv� v�rden p� digitala brytfrekv.
% anges. V�lj t.ex. nedre gr�nsen W-0.01 och �vre gr�nsen W+0.01.
% Observera att W anges utan "pi" i MATLAB.
W=2*3000/fs;
num=fir1(10000,[W-0.12 W+0.10],'stop');
% Filtrera den st�rda filen (y) och skapa en filtrerad variant (y2)
% Funktionen "filter" �r anv�ndbar f�r b�de FIR- och IIR-filter.
% H�r skulle det lika g�rna kunna fungera med "y2 = conv(num,y);"
y2=filter(num,50,y);
% Lyssna p� filtrerat ljud och plotta frekvensg�ngen f�r filtret
%input('V�nta tills st�rda musiken spelat f�rdigt ....');
%soundsc(y2,fs);
freqz(num,1);