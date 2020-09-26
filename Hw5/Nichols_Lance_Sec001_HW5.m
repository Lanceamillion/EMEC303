%% EMEC 303 HW4
%  Lance Nichols
%  Section-002
%  9/11/2020

clear; clc;
%% Problem 1: Damped spring system
% * (a) Done
% * (b) See Plot
% * (c) Undampted does not converge and continues to ossolate. This makes
% sense.
% * (d) c = 0 is the least stiff. c = (4*m*k)^(0.5) is the next stiffest. c
% = (4*m*k)^(0.5)-1. c = (4*m*k)^(0.5) is next. c = (4*m*k)^(0.5)+1 is the
% stiffest

m = 5;
k = 0.5;
cf = [0,(4*m*k)^0.5-1,(4*m*k)^0.5+1,(4*m*k)^0.5];
xspan = [0,50];
y0 = [1,1];
omega_o = (k/m)^.5;
A = 1;
B = 1/omega_o;

for i = 1:4
    c = cf(i);
    f = @(x,u) [u(2)
        -(c/m)*u(2)-(k/m)*u(1)];
    [t,y] = ode45(f,xspan,y0);
    hold on
    plot(t,y(:,1));
    hold off
end

fana = @(x) A*cos(omega_o*x)+B*sin(omega_o*x);
hold on 
plot(t,fana(t));%for c=0
hold off
legend("c=0","c=(4*m*k)^(0.5)-1","(4*m*k)^(0.5)+1","(4*m*k)^(0.5)","Analytical");
xlabel("Time")
ylabel("Position")

%% Problem 2: Hanging Chain
% * (a) Done
% * (b) See Plot
% * (c) The solution changes with a factor of the differance between T and w
% * (d) Two inital conditions are needed need for all values of T and w
L = 1;
w = 10;
T = 10;

tolerance = 0.001;
xspan = [0,L];
guess = 10;
error = 1000;
y0 = [0,guess];

rightEdgeGuess = -100;

f = @(x,u) [u(2)
    (w/T)*(1+(u(2)^2))^0.5];

while (error > tolerance)
    [x,y] = ode45(f,xspan,y0);
    rightEdgeGuess = y(end,1);
    error = abs(0-rightEdgeGuess);
    guess = guess - 0.0001*rightEdgeGuess;
    y0 = [0,guess];
end
figure(2);
plot(x,y(:,1));
xlabel('x');
ylabel('y');