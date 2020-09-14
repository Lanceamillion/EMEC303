% Higher Order ODE
clear; clc

% Inputs
E=10^8;
I=50;
L=10;
w=@(x) 500*x;

% Define the ODEs
% Let u1=y    => u1'=u2
%     u2=y'   => u2'=u3
%     u3=y''  => u3'=u4
%     u4=y''' => u4'=w(x)/(E*I)
f=@(x,u) [
    u(2);
    u(3);
    u(4);
    w(x)/(E*I) ];

% Initial Conditions
% u @ x=0
uo=[0,0,0,0];

% Define where to compute solution
xspan=[0,L];

% Solve ODE
[x,u]=ode45(f,xspan,uo);

% Try solve this with Euler's
h = .01;
N = round(L/h);
x_euler = 0;
u_euler = uo;
% Loop over
for i = 1:N-1
   x_euler(i+1)= x_euler(i)+h;
   u_euler(i+1,:)= u_euler(i,:)+h*f(x_euler(i),u_euler(i,:))';
end
% Plot the dispacement
plot(x,u(:,1))
hold on
plot(x_euler,u_euler(:,1))
xlabel('x')
ylabel('Displacement')
set(gca,'Fontsize',20)