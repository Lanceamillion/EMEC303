clear; clc;
%% Data
time=[      0    0.5500    1.1000    1.6500    2.2000    2.7500    3.3000    3.8500    4.4000    4.9500    5.5000    6.0500    6.6000    7.1500    7.7000    8.2500    8.8000    9.3500    9.9000];
f=[ 0.3491    0.2800   -0.4212   -0.1751    0.4671    0.0578   -0.4840    0.0642    0.4706   -0.1832   -0.4278    0.2913    0.3577   -0.3819   -0.2646    0.4493    0.1539   -0.4895   -0.0325];
% visualize data
figure(1); clf(1)
plot(time,f,'--o','Linewidth', 2)

for k=1:6
%% Fit data

% Fit f(t)=Ao+A1*cos(k*wo*t)+A2*sin(k*wo*t)
wo=pi; % <= Need to know frequency
N=length(time);
for i=1:N
    Z(i,1)=1;   
    Z(i,2)=cos(k*wo*time(i));
    Z(i,3)=sin(k*wo*time(i));
    Y(i,1)=f(i);
end
% Solve for constants
A=(Z'*Z)\(Z'*Y);

% Calculate Freq and Amplitude
freq(k) = k*wo/(2*pi);
Amp(k)=sqrt(A(2)^2+A(3)^2);


% Plot fit
hold on
t=0:0.01:10;
plot(t,A(1)+A(2)*cos(wo*t)+A(3)*sin(wo*t),'Linewidth', 2)
xlabel('time')
ylabel('f(t)')
legendInfo{k+1} = ['k = ' num2str(k)]; 

% Display amplitude
fprintf('k = %f,Freq = %5.5f, Amplitude = %5.5f \n',k,freq(k), Amp(k) );
end
legendInfo{1}='Given Data';
legend(legendInfo)

%% Plot Frequency and Amplitude
figure(2);clf(2)
stem(freq,Amp,'Linewidth', 4,'MarkerFaceColor', 'auto')
ylabel('Amplitude')
xlabel('Freq')