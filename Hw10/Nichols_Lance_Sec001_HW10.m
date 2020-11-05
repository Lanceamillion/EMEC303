%% EMEC 303 HW10
%  Lance Nichols
%  Section-002
%  10/26/2020

clear all; clc; close all;

%% Problem 1: Least Squares Fit
disp("Problem 1:")
%(a) See Attached

x = [1,2,3,3.5,4.25,5,7,10];
y = [0.2,2.5,4,4.1,4.4,4,5,8.1];

%(b)

M = zeros(2,2);
b = zeros(2,1);

M(1,1) = length(x);
M(1,2) = sum(x);
M(2,1) = sum(x);
M(2,2) = sum(x.^2);

b(1,1) = sum(y);
b(2,1) = sum(y.*x);

a = M\b;


disp("a0: " + a(1));
disp("a1: " + a(2));

%(c)
Sr = sum((y-a(1)-a(2)*x).^2);
St = sum((y-mean(y)).^2);

R2 = (St-Sr)/St;

disp("R^2: " + R2);


%% Problem 2: Generalized least-squares fitting of "synthetic" data

%(a)
disp("Problem 2.a:")
N = 1000;
x = linspace(0,5,N);
a1 = -1; a2=4; a3=9;
y = a1+a2*x+a3*x.^2 + 5*randn(1,N);
figure(1); clf(1);
plot(x,y,'.')

% Generalized Least Squares

% Preallocating matrices
z{1}=@(x) 1;
z{2}=@(x) x;
z{3}=@(x) x.^2;

M=length(z);  % Number of basis functions (terms in fit a1+a2*x)
Z=zeros(N,M);
Y=zeros(N,1);
for i=1:N
    for j=1:M
        Z(i,j)=z{j}(x(i));
    end
    Y(i,1)= y(i);       % y value for the i^th data poit
end

% Solve for fit paramters (a's)
a=(Z'*Z)\(Z'*Y);

disp(a)

% Build fit function of x
Fit=@(x) 0;
for j=1:M
    Fit=@(x) Fit(x) + a(j).*z{j}(x);
end

% Plot data & fit
X=linspace(min(x),max(x),1000);
hold on
plot(X,Fit(X))
title("2.a")
xlabel('x')
ylabel('y')
set(gca,'Fontsize',20)

% Compute R^2 value
Sr=sum( ( y - Fit(x) ).^2 );
St=sum( ( y - mean(y) ).^2 );
R2=(St-Sr)/St;
fprintf('The R^2 value is %5.5f \n',R2)

% Compute S_y/x value
Syx=sqrt(Sr/(N-2));
fprintf('The S_y/x value is %5.5f \n',Syx)


%(b)
disp("Problem 2.b:")
N = 1000;
x = linspace(0,5,N);
y = 5-2*x.^2+5*exp(x)+20*sin(3*pi*x)+5*randn(1,N);
figure(2); clf(2);
plot(x,y,'.')

% Preallocating matrices
z{1}=@(x) 1;
z{2}=@(x) x;
z{3}=@(x) x.^2;
z{4}=@(x) exp(x);
z{5}=@(x) sin(3*pi*x);

M=length(z);  % Number of basis functions (terms in fit a1+a2*x)
Z=zeros(N,M);
Y=zeros(N,1);
for i=1:N
    for j=1:M
        Z(i,j)=z{j}(x(i));
    end
    Y(i,1)= y(i);       % y value for the i^th data poit
end

% Solve for fit paramters (a's)
a=(Z'*Z)\(Z'*Y);

disp(a)

% Build fit function of x
Fit=@(x) 0;
for j=1:M
    Fit=@(x) Fit(x) + a(j).*z{j}(x);
end

% Plot data & fit
X=linspace(min(x),max(x),1000);
hold on
plot(X,Fit(X))
title("2.b")
xlabel('x')
ylabel('y')
set(gca,'Fontsize',20)

% Compute R^2 value
Sr=sum( ( y - Fit(x) ).^2 );
St=sum( ( y - mean(y) ).^2 );
R2=(St-Sr)/St;
fprintf('The R^2 value is %5.5f \n',R2)

% Compute S_y/x value
Syx=sqrt(Sr/(N-2));
fprintf('The S_y/x value is %5.5f \n',Syx)