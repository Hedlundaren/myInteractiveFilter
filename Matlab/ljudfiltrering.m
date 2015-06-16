% Exemplet visar hur en ljudfil adderas till en störning på 800 Hz. Därefter
% filtreras den störda ljudfilen med ett BS-filter. Originalljud, ljud med
% störning och den filtrerade ljudfilen spelas upp.
% Filnamn: Ljudex.m
% Datum: 15-05-07
% Läs in ljudfilen till vektorn x och samplingstakten till variabeln fs.
clear all;
[x,fs]=wavread('Trubadur');
% Korta av ljudfilen till 5 sekunder musik
x = x(1:(5*fs));
% Lyssna på den ostörda ljudfilen
soundsc(x,fs);
% Skapa en störning med frekvensen 800 Hz (godtyckligt vald frekvens).
% Observera att samplingstakten på störningsvektorn måste vara samma
% som för originalljudfilen. Amplituden är medvetet vald till ett lågt
% värde för att inte överrösta musiken.
t=0:(1/fs):5;
storning = 0.05*sin(2*pi*800.*t);
% Gör vektorerna lika långa, dvs vektorn (x) och vektorn (storning).
storning = storning(1:length(x));
% Addera till störningen och skapa en ny störd vektor (y).
% Observera att den ena vektorn måste transponeras för att additionen
% ska fungera i MATLAB.
y = x+storning';
% Lyssna på störd fil.
% Om programmet körs i sin helhet kan ljudkortet
% få en kollision mellan denna "soundsc" och den tidigare om den tidigare
% inte spelat färdigt.
input('Vänta tills ostörda musiken spelat färdigt ....');
soundsc(y,fs);
% Skapa BS-filter med lämpligt omega (W) som motsvarar f = 800 Hz.
% När funktionen "fir1" används måste två värden på digitala brytfrekv.
% anges. Välj t.ex. nedre gränsen W-0.01 och övre gränsen W+0.01.
% Observera att W anges utan "pi" i MATLAB.
W=2*800/fs;
num=fir1(10000,[W-0.01 W+0.01],'stop');
% Filtrera den störda filen (y) och skapa en filtrerad variant (y2)
% Funktionen "filter" är användbar för både FIR- och IIR-filter.
% Här skulle det lika gärna kunna fungera med "y2 = conv(num,y);"
y2=filter(num,1,y);
% Lyssna på filtrerat ljud och plotta frekvensgången för filtret
input('Vänta tills störda musiken spelat färdigt ....');
soundsc(y2,fs);
freqz(num,1);