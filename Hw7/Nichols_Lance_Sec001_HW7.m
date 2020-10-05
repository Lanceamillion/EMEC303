%% EMEC 303 HW7
%  Lance Nichols
%  Section-002
%  10/2/2020

clear; clc;
%% Problem 1: Diffusion in a 2D system
% * (a) See attached

% (b) 2D plate heated from the middle

% Givens
sigma = 0.1;
A = 1;
S = @(x,y) A*exp(-((x-.5)^2+(y-.5)^2)/(2*sigma^2));

% Conditions
N = 4;

%assume square
x = linspace(0,1,N);
y = linspace(0,1,N);
dx = x(2)-x(1);

MatA = zeros(N*N,N*N);
MatB = zeros(N*N,1);

% Boundires
for j = 1:N
    for i = 1:N
        if i == 1 || i == N || j == 1 || j == N
            MatA((j-1)*N+i,(j-1)*N+i) = 1;
            MatB((j-1)*N+i,1) = 10;
        else
            MatA((j-1)*N+i,(j-1)*N+i) = -4/dx^2;
            MatA((j-1)*N+i,(j-1)*N+i+1) = 1/dx^2;
            MatA((j-1)*N+i,(j-1)*N+i-1) = 1/dx^2;
            MatA((j-1)*N+i,(j-1)*N+i+N) = 1/dx^2;
            MatA((j-1)*N+i,(j-1)*N+i-N) = 1/dx^2;
            MatB((j-1)*N+i,1) = -S(x(i),y(j));
        end 
    end
end

% Solve
MatSol = MatA\MatB;

MatT = zeros(N,N);

for j = 1:N
    for i = 1:N
        MatT(j,i) = MatSol((j-1)*N+i,1);
    end
end

figure(1);
contourf(x,y,MatT,'LineColor', 'none');
colormap(hot)
colorbar
title("1.b: 2D plate heated from the middle")
xlabel("x (m)")
ylabel("y (m)")
pbaspect([1 1 1])

% (c) 2D plate heated from the middle but only cooled on top and bottom edges.

% Givens
sigma = 0.1;
A = 1;
S = @(x,y) A*exp(-((x-.5)^2+(y-.5)^2)/(2*sigma^2));

% Conditions
N = 20;

%assume square
x = linspace(0,1,N);
y = linspace(0,1,N);
dx = x(2)-x(1);

MatA = zeros(N*N,N*N);
MatB = zeros(N*N,1);

% Boundires
for j = 1:N
    for i = 1:N
        if j == 1 || j == N
            MatA((j-1)*N+i,(j-1)*N+i) = 1;
            MatB((j-1)*N+i,1) = 10;
        elseif i == 1 || i == N
            MatA((j-1)*N+i,(j-1)*N+i) = -1;
            MatA((j-1)*N+i,(j-1)*N+i-1) = 1;
            MatB((j-1)*N+i,1) = 0;
        else
            MatA((j-1)*N+i,(j-1)*N+i) = -4/dx^2;
            MatA((j-1)*N+i,(j-1)*N+i+1) = 1/dx^2;
            MatA((j-1)*N+i,(j-1)*N+i-1) = 1/dx^2;
            MatA((j-1)*N+i,(j-1)*N+i+N) = 1/dx^2;
            MatA((j-1)*N+i,(j-1)*N+i-N) = 1/dx^2;
            MatB((j-1)*N+i,1) = -S(x(i),y(j));
        end 
    end
end

% Solve
MatSol = MatA\MatB;

MatT = zeros(N,N);

for j = 1:N
    for i = 1:N
        MatT(j,i) = MatSol((j-1)*N+i,1);
    end
end

figure(2);
contourf(x,y,MatT,'LineColor', 'none');
colormap(hot)
colorbar
title("1.c: 2D plate heated from the middle but only cooled on top and bottom edges.")
xlabel("x (m)")
ylabel("y (m)")
pbaspect([1 1 1])

% (c) 2D plate heated from the middle Liebmann's

% Givens
sigma = 0.1;
A = 1;
S = @(x,y) A*exp(-((x-.5)^2+(y-.5)^2)/(2*sigma^2));

% Conditions
N = 20;
Niter=10000; % Max number of iterations
tol = 1e-6;  % Convergence tolerance
%assume square
x = linspace(0,1,N);
y = linspace(0,1,N);
dx = x(2)-x(1);

MatT = zeros(N,N);

NewMatT=MatT;
for n=1:Niter
    %Set Boundries
    for j = 1:N
         for i = 1:N
             if j == 1 || j == N || i == 1 || i == N
                 MatT(i,j) = 10;
             end 
         end
    end
    %Solve Intierior Points
    for i=2:N-1
        for j=2:N-1
            NewMatT(i,j) = (S(x(i),y(j))*dx^2+MatT(i-1,j)+MatT(i+1,j)+MatT(i,j-1)+MatT(i,j+1))/4;
        end
    end
    %Check if converged
    res=max(abs(NewMatT(:)-MatT(:)));
    if res<tol
        break
    end
    %Set Matrix
    MatT=NewMatT;
    
end

%Set Boundries
for j = 1:N
    for i = 1:N
        if j == 1 || j == N || i == 1 || i == N
            MatT(i,j) = 10;
        end
    end
end
figure(3);
contourf(x,y,MatT,'LineColor', 'none');
colormap(hot)
colorbar
title("1.d: 2D plate heated from the middle Liebmann's")
xlabel("x (m)")
ylabel("y (m)")
pbaspect([1 1 1])

% (e) see attached