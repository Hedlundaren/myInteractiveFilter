% Filtrering med FIR-filter av LP-typ
% Filnamn: Msosf8_1        12-05-07
 
clear all;
fs=10000;       % Samplingsfrekvens
fb=1500;        % Brytfrekvens
wb=2*pi*fb/fs;  % Normerad brytfrekvens 
 
 
% Skapa en signal
t=0:(1/fs):3;
x=sin(2*pi*440*t)+1.8*sin(2*pi*2000*t);
 
 
% Beräkna filterkoefficienter
i=1;
for n=-20:1:20
   if n==0
      h(i)=(1/(2*pi))*(wb-(-wb));
   else
      h(i)=(1/(pi*n))*sin(wb*n);
   end
   i=i+1;
end
 
% Filtrera 
y=conv(x,h);
figure(1);
subplot(311); plot(t(1:100),x(1:100),'k'); axis([0 0.01 -2 2]); grid; 
subplot(312); plot(t(1:100),y(100:199),'b'); axis([0 0.01 -2 2]); grid; 
%h2=fir1(40,0.30); y2=conv(x,h2);
%subplot(313); plot(t(1:100),y2(100:199),'b'); axis([0 0.01 -2 2]); grid;
 
 
% Beräkna fönsterkoefficienter (Hanning-typ)
N=length(h);
for n=0:1:N-1
    w(n+1)=0.5*(1-cos(2*pi*n/(N-1)));
end
    
% Uppdatera impulssvaret
h2=w.*h;
 
input('Forts med fönsterhantering.....');
 
% Filtrera med uppdaterade impulssvaret och rita grafen
y2=conv(x,h2);
subplot(313); plot(t(1:100),y2(100:199),'r');
 
 % Rita frekvensgång före/efter fönsterhantering
figure(2); freqz(h,1); hold on; freqz(h2,1);

