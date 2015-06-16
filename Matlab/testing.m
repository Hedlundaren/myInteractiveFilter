% ellipt.m - Compare minimum-phase and zero-phase
%            lowpass impulse responses.

dosounds = 1;
N = 8;     % filter order
Rp = 0.5;  % passband ripple (dB)
Rs = 60;   % stopband ripple (-dB)
Fs = 8192; % default sampling rate (Windows Matlab)
Fp = 2000; % passband end
Fc = 2200; % stopband begins [gives order 8]
Ns = 4096; % number of samples in impulse responses

[B,A] = nellip(Rp, Rs, Fp/(0.5*Fs), Fc/(0.5*Fs)); % Octave
% [B,A] = ellip(N, Rp, Rs, Fp/(0.5*Fs)); % Matlab

% Minimum phase case:
imp = [1,zeros(1,Ns/2-1)]; % or 'h1=impz(B,A,Ns/2-1)'
h1 = filter(B,A,imp); % min-phase impulse response
hmp = filter(B,A,[h1,zeros(1,Ns/2)]); % apply twice

% Zero phase case:
h1r = fliplr(h1); % maximum-phase impulse response
hzp = filter(B,A,[h1r,zeros(1,Ns/2)]); % min*max=zp
% hzp = fliplr(hzp); % not needed here since symmetric

elliptplots; % plot impulse- and amplitude-responses

% Let's hear them!
while(dosounds)
  sound(hmp,Fs);
  pause(0.5);
  sound(hzp,Fs);
  pause(1);
end
