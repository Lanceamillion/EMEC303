%% EMEC 303 
%  Least Squares fitting
clear; clc;

%% Create Noisy data
% Number of data points
N = 500;

% Create N random data points from 0 to 5
x = linspace(0,5,N) + 0.5*randn(1,N);

% Data values
y = 6.5 - 3*x + sin(2*pi*x/5) + 1.25*randn(1,N);

% Plot points
figure(1); clf(1);
plot(x,y,'.k');
axis([-2 7 -15 15]);

%matrix Sol
M = zeros(2,2);
b = zeros(2,1);

M(1,1) = N;
M(1,2) = sum(x);
M(2,1) = sum(x);
M(2,2) = sum(x.^2);

b(1,1) = sum(y);
b(2,1) = sum(y.*x);

a = M\b

ytrend = a(1) + a(2)*x;

hold on
plot(x,ytrend)


%Sr
Sr = 0;
for i = 1:N
    Sr = Sr + (y(i)-a(1)-a(2)*x(i))^2;
end

%St
St = 0;
for i = 1:N
    St = St + (y(i)-mean(y))^2;
end

%Coeff det
R2 = (St-Sr)/St;

%Standard error
Syx = sqrt(Sr/(N-2));
disp("Standard error :" + Syx);