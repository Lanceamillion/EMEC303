% Code does the following
% - generates data with noise, 
% - computes Fourier transform
% - filters data in frequency domain (removes low amplitudes)
% - computes inverser Fourier transform
% - plots filtered data

clear; clc

% Generate data using sin and cosine with noise
Ns=1000;
t=linspace(0,5,Ns);
data=sin(2*pi*t)+3*cos(2*pi*t*2)+1*randn(1,Ns);

% Period of data
T=max(t);          

% Perform Fourier transform
F=fft(data);

% Compute amplitude and Freq
Frq = F(1:Ns)/T;
Amp = sqrt((2*real(F(1:Ns)/Ns)).^2+(2*imag(F(1:Ns)/Ns)).^2);

% Plot Fourier transform
figure(1); clf(1)
subplot(2,1,1)
plot(t,data,'k.')
xlabel('t');ylabel('f(t)');title('data')
subplot(2,1,2)
stem(Frq,Amp)
xlabel('Freq');ylabel('Amp');title('FFT of discrete data')
axis([0,50,0,4])

% Filter data
cutoff=.8;
for k=1:Ns
    if Amp(k)<cutoff  % <=== This number sets the amount of filtering
        F(k)=0;
    end
end

% Perform inverse Fourier transform
f=ifft(F);

% Plot data and filtered data
figure(2); clf(2)
plot(t,data,'k.')
hold on
plot(t,f,'r','linewidth',3)
xlabel('t')
ylabel('f(t)')
axis([0,T,-8,8]);
legend('data',['filtered data with Amp > ',num2str(cutoff)])
