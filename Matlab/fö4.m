% Sammansatt insignal genom ett LTI-system
% Filnamn: Msos4_2.m     2010-04-13
 
% Generera insignalen x(t)
fs=11025;
f1=100;
f2=500;
t=0:1/fs:3;
x1=3*cos(2*pi*f1.*t);
x2=3*cos(2*pi*f2.*t);
x=x1+x2;
 
% Plotta insignalen x(t)
maxindex=200;
subplot(211); plot(t(1:maxindex),x(1:maxindex)); grid; title('Insignalen med 100 resp 500 Hz');
 
% Beräkna utsignalen y(t)
H1=1/(1+j*2*pi*f1);
H2=1/(1+j*2*pi*f2);
argH1=angle(H1);
argH2=angle(H2);
 
y=abs(H1)*3*cos(2*pi*f1.*t+argH1) + abs(H2)*3*cos(2*pi*f2.*t+argH2);
 
% Plotta utsignalen y(t)
subplot(212); plot(t(1:maxindex),y(1:maxindex)); grid; title('Utsignalen');
