% Filtrering med IIR-filter (fö.9)
% Filnamn: Msosf9_1      13-05-13
 
clear all;
fs=11025;
 
% Placera ett nollställe för z=1.0*exp(j*0.091*pi) och konjugatet,
% spärrfrekvens 2000 Hz
% Placera pol så att spärrbandsbredden blir c:a 25 Hz. Design på fö.
num=[1 -0.8356 1]; den=[1 -1.8565 0.985850];
 
freqz(num,den);
 
% Skapa insignal och filtrera
t=0:(1/fs):3;
x=sin(2*pi*1700*t)+sin(2*pi*2000*t)+sin(2*pi*2300*t);
 
y(1)=0; y(2)=0;
for n=3:1:length(t)
    y(n)=1.8565*y(n-1)-0.9859*y(n-2)+x(n)-0.8356*x(n-1)+x(n-2);
end
 
% Utför frekvensanalys
f=0:fs/length(y):fs/2;
X=fft(x);
Y=fft(y);
figure(2); plot(f,abs(X(1:length(f)))/(length(x)/2)); grid;
figure(3); plot(f,abs(Y(1:length(f)))/(length(y)/2)); grid;
