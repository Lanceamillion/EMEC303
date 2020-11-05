%% EMEC 303 HW8
%  Lance Nichols
%  Section-002
%  10/26/2020

clear all; clc; close all;

%% Problem 1: Transient 1D Diffusion

%(a)

%Givens

L = 0.1;
D = 1e-5;

n = 100;
dt = .01;

LAtIndex = linspace(0,L,n);
dx = LAtIndex(2);
T = zeros(1,n);

%Inital conditons
t = 0;

for i = 1:n
    T(i) = sin(2*pi*LAtIndex(i)/L);
end
hold on
Tnew = T;
for N = 1:10000
    t = t + dt;
    for i = 2:n-1
        Tnew(1,i) = T(1,i)+dt*D*((T(1,i-1)-2*T(1,i)+T(1,i+1))/dx^2);
    end
    T = Tnew;
    T(1) = 0;
    T(n) = 0;
    if rem(N,100)==1
        figure(1)
        plot(LAtIndex,T)
        title("(a)")
        xlabel("Lenght (x)")
        ylabel("Temp (C)")
        ylim([-1,1])
    end
end
hold off
%(b)

%Givens

L = 0.1;
D = 1e-5;

n = 100;
dt = .01;

LAtIndex = linspace(0,L,n);
dx = LAtIndex(2);
T = zeros(1,n);

%Inital conditons
t = 0;

for i = 1:n
    T(i) = sin(2*pi*LAtIndex(i)/L);
end

Tnew = T;
for N = 1:10000
    t = t + dt;
    for i = 2:n-1
        Tnew(1,i) = T(1,i)+dt*D*((T(1,i-1)-2*T(1,i)+T(1,i+1))/dx^2);
    end
    T = Tnew;
    T(1) = -1;
    T(n) = 1;
    if rem(N,100)==1
        hold on
        figure(2)
        plot(LAtIndex,T)
        title("(b)")
        xlabel("Lenght (x)")
        ylabel("Temp (C)")
        ylim([-1,1])
        hold off
    end
end

%(c)

%Givens

L = 0.1;
D = 1e-5;

n = 100;
dt = .01;

LAtIndex = linspace(0,L,n);
dx = LAtIndex(2);
T = zeros(1,n);

%Inital conditons
t = 0;

for i = 1:n
    T(i) = heaviside(LAtIndex(i)/0.1-.25)-heaviside(LAtIndex(i)/0.1-.75);
end

Tnew = T;
for N = 1:10000
    t = t + dt;
    for i = 2:n-1
        Tnew(1,i) = T(1,i)+dt*D*((T(1,i-1)-2*T(1,i)+T(1,i+1))/dx^2);
    end
    T = Tnew;
    T(1) = 0;
    T(n) = 0;
    if rem(N,100)==1
        hold on
        figure(3)
        plot(LAtIndex,T)
        title("(c)")
        xlabel("Lenght (x)")
        ylabel("Temp (C)")
        ylim([-1,1])
        hold off
    end
end

%% Problem 2: Advection-Diffusion Diffusion

% (a)

%Givens

L = 2;
D = 0.001;

n = 100;
dt = .01;
u=.5;

Cal=@(x,t) cos((2*pi*(x-u*t-.5))/L)*exp(-D*(2*pi/L)^2*t);

chart = 4;

LAtIndex = linspace(0,L,n);
dx = LAtIndex(2);
CLax = zeros(1,n);
CUp = zeros(1,n);

%Inital conditons
t = 0;

for i = 1:n
    CLax(i) = sin(2*pi*LAtIndex(i)/L);
    CUp(i) = sin(2*pi*LAtIndex(i)/L);
end

CnewLax=CLax;
CnewUp=CUp;
for N = 1:10000
    t = t + dt;
    for i = 2:n-1
        %Upwind
        CnewUp(1,i)= CUp(1,i)+dt*((D*(CUp(1,i-1)-2*CUp(1,i)+CUp(1,i+1))/(dx^2))+(-u*(CUp(1,i)-CUp(1,i-1))/dx));
        %Lax-Wendroff
        CnewLax(1,i)=CLax(1,i)+dt*(-u*(CLax(1,i+1)-CLax(1,i-1))/(2*dx)+(u^2*dt)/2*(CLax(1,i+1)-2*CLax(1,i)+CLax(1,i-1))/dx^2+D*(CLax(1,i-1)-2*CLax(1,i)+CLax(1,i+1))/dx^2);
    end
    CnewLax(1,1)=CLax(1,1)+dt*(-u*(CLax(1,2)-CLax(1,n))/(2*dx)+(u^2*dt)/2*(CLax(n-1)-2*CLax(1,1)+CLax(1,2))/dx^2+D*(CLax(1,n)-2*CLax(1,1)+CLax(1,2))/dx^2);
    CnewLax(1,n)=CLax(1,1);
    CnewUp(1,1)=CUp(1,1)+dt*(D*(CUp(1,n-1)-2*CUp(1,1)+CUp(1,2))/dx^2+(-u*(CUp(1,1)-CUp(1,n-1))/dx));
    CnewUp(1,n)=CUp(1,1);
    
    CLax=CnewLax;
    CUp=CnewUp;
    if rem(N,2000)==1
        figure(chart)
        chart = chart + 1;
        plot(LAtIndex,CUp)
        hold on
        plot(LAtIndex,CLax)
        plot(LAtIndex,Cal(LAtIndex,t))
        ylim([-1,1])
        title("(2.a) At " + t + " seconds")
        xlabel("Lenght (x)")
        ylabel("concentration")
        legend("Upwind","Lax-Wendroff","Analytical")
        hold off
    end
end
%Lax-Wendroff is the closest to the Analytical

% (b)

%Givens

L = 2;
D = 0.001;

n = 100;
dt = .01;
u=.1;

Cal=@(x,t) cos((2*pi*(x-u*t-.5))/L)*exp(-D*(2*pi/L)^2*t);

chart = 9;

LAtIndex = linspace(0,L,n);
dx = LAtIndex(2);
CLax = zeros(1,n);
CUp = zeros(1,n);

%Inital conditons
t = 0;

for i = 1:n
    CLax(i) = sin(2*pi*LAtIndex(i)/L);
    CUp(i) = sin(2*pi*LAtIndex(i)/L);
end

CnewLax=CLax;
CnewUp=CUp;
for N = 1:10000
    t = t + dt;
    for i = 2:n-1
        %Upwind
        CnewUp(1,i)= CUp(1,i)+dt*((D*(CUp(1,i-1)-2*CUp(1,i)+CUp(1,i+1))/(dx^2))+(-u*(CUp(1,i)-CUp(1,i-1))/dx));
        %Lax-Wendroff
        CnewLax(1,i)=CLax(1,i)+dt*(-u*(CLax(1,i+1)-CLax(1,i-1))/(2*dx)+(u^2*dt)/2*(CLax(1,i+1)-2*CLax(1,i)+CLax(1,i-1))/dx^2+D*(CLax(1,i-1)-2*CLax(1,i)+CLax(1,i+1))/dx^2);
    end
    CnewLax(1,1)=CLax(1,1)+dt*(-u*(CLax(1,2)-CLax(1,n))/(2*dx)+(u^2*dt)/2*(CLax(n-1)-2*CLax(1,1)+CLax(1,2))/dx^2+D*(CLax(1,n)-2*CLax(1,1)+CLax(1,2))/dx^2);
    CnewLax(1,n)=CLax(1,1);
    CnewUp(1,1)=CUp(1,1)+dt*(D*(CUp(1,n-1)-2*CUp(1,1)+CUp(1,2))/dx^2+(-u*(CUp(1,1)-CUp(1,n-1))/dx));
    CnewUp(1,n)=CUp(1,1);
    
    CLax=CnewLax;
    CUp=CnewUp;
    if rem(N,2000)==1
        figure(chart)
        chart = chart + 1;
        plot(LAtIndex,CUp)
        hold on
        plot(LAtIndex,CLax)
        plot(LAtIndex,Cal(LAtIndex,t))
        ylim([-1,1])
        title("(2.b) At " + t + " seconds")
        xlabel("Lenght (x)")
        ylabel("concentration")
        legend("Upwind","Lax-Wendroff","Analytical")
        hold off
    end
end
% Upwind does best because of how it approximates values in low u
% situtaions

% (c)

%Givens

L = 2;
D = 0.001;

n = 100;
dt = .01;
u=0;

Cal=@(x,t) cos((2*pi*(x-u*t-.5))/L)*exp(-D*(2*pi/L)^2*t);

chart = 14;

LAtIndex = linspace(0,L,n);
dx = LAtIndex(2);
CLax = zeros(1,n);
CUp = zeros(1,n);

%Inital conditons
t = 0;

for i = 1:n
    CLax(i) = sin(2*pi*LAtIndex(i)/L);
    CUp(i) = sin(2*pi*LAtIndex(i)/L);
end

CnewLax=CLax;
CnewUp=CUp;
for N = 1:10000
    t = t + dt;
    for i = 2:n-1
        %Upwind
        CnewUp(1,i)= CUp(1,i)+dt*((D*(CUp(1,i-1)-2*CUp(1,i)+CUp(1,i+1))/(dx^2))+(-u*(CUp(1,i)-CUp(1,i-1))/dx));
        %Lax-Wendroff
        CnewLax(1,i)=CLax(1,i)+dt*(-u*(CLax(1,i+1)-CLax(1,i-1))/(2*dx)+(u^2*dt)/2*(CLax(1,i+1)-2*CLax(1,i)+CLax(1,i-1))/dx^2+D*(CLax(1,i-1)-2*CLax(1,i)+CLax(1,i+1))/dx^2);
    end
    CnewLax(1,1)=CLax(1,1)+dt*(-u*(CLax(1,2)-CLax(1,n))/(2*dx)+(u^2*dt)/2*(CLax(n-1)-2*CLax(1,1)+CLax(1,2))/dx^2+D*(CLax(1,n)-2*CLax(1,1)+CLax(1,2))/dx^2);
    CnewLax(1,n)=CLax(1,1);
    CnewUp(1,1)=CUp(1,1)+dt*(D*(CUp(1,n-1)-2*CUp(1,1)+CUp(1,2))/dx^2+(-u*(CUp(1,1)-CUp(1,n-1))/dx));
    CnewUp(1,n)=CUp(1,1);
    
    CLax=CnewLax;
    CUp=CnewUp;
    if rem(N,2000)==1
        figure(chart)
        chart = chart + 1;
        plot(LAtIndex,CUp)
        hold on
        plot(LAtIndex,CLax)
        plot(LAtIndex,Cal(LAtIndex,t))
        ylim([-1,1])
        title("(2.c) At " + t + " seconds")
        xlabel("Lenght (x)")
        ylabel("concentration")
        legend("Upwind","Lax-Wendroff","Analytical")
        hold off
    end
end
% No dispersion occors and the Lax-Wendroff term begins drifting

% (d) The scheme works by using a corrector that is based on the square of
% u