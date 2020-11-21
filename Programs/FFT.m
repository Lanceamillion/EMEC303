clear; clc
[f,sampleRate] = audioread("tuning_fork_A4.wav");
[f,sampleRate] = audioread("violin_A4.wav");
[f,sampleRate] = audioread("Mariah_Carey.mp3");

Ns = length(f);
T = Ns/sampleRate;
t = linspace(0,T,Ns);
Nt = floor(Ns/2)-1;

figure(1);  clf(1)
plot(t,f)
xlabel('t (s)')
ylabel('f(t)')
title("Audio data in time domain")

F = fft(f);

a0 = F(1)/Ns;
ak = +2*real(F(2:Nt+1))/Ns;
bk = -2*imag(F(2:Nt+1))/Ns;

amp = sqrt(ak.^2+bk.^2);
frq = (1:Nt)/T;

figure(2);  clf(2)
plot(frq,amp)
xlabel('Frq')
ylabel('Amp')
title("Audio data in frequency domain")

sound(f,sampleRate);