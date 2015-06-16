% Exemplet visar hur en ljudfil adderas till en st�rning p� 800 Hz. D�refter
% filtreras den st�rda ljudfilen med ett BS-filter. Originalljud, ljud med
% st�rning och den filtrerade ljudfilen spelas upp.
% Filnamn: Ljudex.m
% Datum: 15-05-07
% L�s in ljudfilen till vektorn x och samplingstakten till variabeln fs.
clear all;
[x,fs]=wavread('Trubadur');
% Korta av ljudfilen till 5 sekunder musik
x = x(1:(5*fs));
% Lyssna p� den ost�rda ljudfilen
soundsc(x,fs);
% Skapa en st�rning med frekvensen 800 Hz (godtyckligt vald frekvens).
% Observera att samplingstakten p� st�rningsvektorn m�ste vara samma
% som f�r originalljudfilen. Amplituden �r medvetet vald till ett l�gt
% v�rde f�r att inte �verr�sta musiken.
t=0:(1/fs):5;
storning = 0.05*sin(2*pi*800.*t);
% G�r vektorerna lika l�nga, dvs vektorn (x) och vektorn (storning).
storning = storning(1:length(x));
% Addera till st�rningen och skapa en ny st�rd vektor (y).
% Observera att den ena vektorn m�ste transponeras f�r att additionen
% ska fungera i MATLAB.
y = x+storning';
% Lyssna p� st�rd fil.
% Om programmet k�rs i sin helhet kan ljudkortet
% f� en kollision mellan denna "soundsc" och den tidigare om den tidigare
% inte spelat f�rdigt.
input('V�nta tills ost�rda musiken spelat f�rdigt ....');
soundsc(y,fs);
% Skapa BS-filter med l�mpligt omega (W) som motsvarar f = 800 Hz.
% N�r funktionen "fir1" anv�nds m�ste tv� v�rden p� digitala brytfrekv.
% anges. V�lj t.ex. nedre gr�nsen W-0.01 och �vre gr�nsen W+0.01.
% Observera att W anges utan "pi" i MATLAB.
W=2*800/fs;
num=fir1(10000,[W-0.01 W+0.01],'stop');
% Filtrera den st�rda filen (y) och skapa en filtrerad variant (y2)
% Funktionen "filter" �r anv�ndbar f�r b�de FIR- och IIR-filter.
% H�r skulle det lika g�rna kunna fungera med "y2 = conv(num,y);"
y2=filter(num,1,y);
% Lyssna p� filtrerat ljud och plotta frekvensg�ngen f�r filtret
input('V�nta tills st�rda musiken spelat f�rdigt ....');
soundsc(y2,fs);
freqz(num,1);