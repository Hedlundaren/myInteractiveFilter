% Fyrkantvågens Fourierserie 
% Fil: Msosf3_1      130415


for Fourierkoeff=1:1:50
    i=1;
for t=0:0.01:6
   sum=0.0;
   for n=-Fourierkoeff:1:Fourierkoeff
      if n==0
         sum=sum+0.5;
      else
         sum=sum+(1/(n*pi))*sin(n*pi/2)*exp(j*n*pi*t);
      end
   end
   x(i)=sum;
   t2(i)=t;
   i=i+1;
end
plot(t2,real(x(1:length(t2))));hold on;
input('Forts ....'); Fourierkoeff
clear;
 
end
