% J�mf�r ber.tider f�r DFT/FFt
% Fil: Msosf5_1          13-04-17
 
f1=200.0;       % Insignalfrekvens
f2=225.0;       % Insignalfrekvens
fs=2000.0;  % Samplingsfrekvens
 
% Skapa insignal med 4001 sampel
t=0:(1/fs):10.0;    % Signalen samplas med T=1/fs
x=sin(2*pi*f1*t)+sin(2*pi*f2*t);
 
% Utf�r DFT
[N,M]=size(x);
display('  '); display('  '); display('Antal sampel:'); M
if M ~=1        % G�r x till kolumnvektor om den inte �r det !
   x=x';        % Transponera
   N=M;
end
Xk=zeros(N,1);  % Skapa vektor Xk med bara nollv�rden
n = 0:N-1;
tic;                % Starta tidtagningsklocka
for k=0:N-1
   Xk(k+1)=exp(-j*2*pi*k*n/N)*x;
end
 
display('BER�KNING VIA DFT:');
toc;                % Stoppa tidtagning och skriv ut !
display('  ');
tic;
X=fft(x);
display('BER�KNING VIA FFT:');
toc;

%% Frekvensspektrum f�r en diskret signal
% File: Msosf5_3    13-04-17
 
clear all;
fs=2000;    % Samplingsfrekvens
Ts=1/fs;
f=200;      % Signalfrekvens
A=1.0;      % Signalamplitud
 
n=1:1:4001;                 % Skapa n-v�rden (4001, 8001 och 12001)
x=A*sin(2*pi*f.*(n*Ts));    % Skapa tidsdiskret signal
 
% Utf�r DFT
[N,M]=size(x);
if M ~=1        % G�r x till kolumnvektor om den inte �r det !
   x=x';        % Transponera
   N=M;
end
Xk=zeros(N,1);  % Skapa vektor Xk med bara nollv�rden
n2 = 0:N-1;
for k=0:N-1
   Xk(k+1)=exp(-j*2*pi*k*n2/N)*x;
end
 
% Rita diskret insignal och diskret frekvensspektrum
subplot(211);
stem(n(1:50),x(1:50));
subplot(212);
stem(n(390:410),abs(Xk(390:410)));
%stem(n(790:810), abs(Xk(790:810)));
%stem(n(1190:1210), abs(Xk(1190:1210)));

%% Korrekta axlar i ett frekvensspektrum
% Msosf5_4
 
fs = 11025;
t = 0:(1/fs):1.5;                             % 1.5 sekunders tidsaxel med stegl�ngden, dvs sampl.intervallet, (1/fs)
x = 2*sin(2*pi*500.*t) + 3*sin(2*pi*2000.*t); % Skapa en signal med tv� frekvenskomponenter och olika amplitud
X = fft(x);                                   % Utf�r frekvensanalys (Fouriertransform)
f = 0 : fs/length(x) : fs/2;                  % Skapa en korrekt frekvensaxel 
N = length(X)/2;                              % Halva antalet v�rden i Fouriertransformen
X_skalad = (1/N).*X;                          % Korrekta amplitudv�rden f�r frekvensgraf
 
stem(f,abs(X_skalad(1:length(f))));
axis([0 6000 0 5]); grid;




