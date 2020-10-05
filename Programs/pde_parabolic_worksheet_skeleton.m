% Parabolic PDE
% dT/dt = kcond*(d^2T/dx^2)-kconv*(T-Ta)
% T(0,t)=10, T(1,t)=20  - BCs
% T(x,0)=0;             - IC

clear; clc

% Inputs
Nx=50;
Nt=20000;
dt=0.005;
kcond=0.01;
kconv=0.1;
Lx=1;
Tl=100;
Tr=100;
To=100;
Ta=@(x,t) 100+heaviside(x-0.5)*100*heaviside(cos(2*pi*t/20));

cmax = 0;
% Create grid
x=linspace(0,Lx,Nx);
dx=x(2)-x(1);

% Initial Condition
t=0;
T=zeros(1,Nx)+To;

% Loop over time
Tnew=T;
for n=1:Nt
    
    % Update time
    t=t+dt;
    
    % Update the temp on interior grid points
    for i=2:Nx-1
        Tnew(i)=(kcond*((T(i-1)-2*T(i)+T(i+1))/(dx)^2)...
        -kconv*(T(i)-Ta(x(i),t)))*dt+T(i);
    end
    T=Tnew;
    
    % Update the boundary conditions
    T(1)=T(2);   % Left
    T(Nx)=T(Nx-1);  % Right
    
    [tmax, ndx] = max(T);
    if tmax > cmax
        cmax = tmax;
        tcmax = t;
    end
    % Plot
    if rem(n,100)==0
        figure(1); clf(1)
        % Plot temperature in bar
        plot(x,T,'linewidth',2)
        hold on
        % Plot temperature of air
        plot(x,Ta(x,t))
        xlabel('x')
        ylabel('T(x)')
        string=sprintf('Time = %7.3f',t);
        title(string)
        axis([0,Lx,90,210])
        legend('Temp of Bar','Temp of Air','Location','northwest')
        set(gca,'Fontsize',20)
        drawnow
    end
end

disp(cmax)
disp(tcmax)