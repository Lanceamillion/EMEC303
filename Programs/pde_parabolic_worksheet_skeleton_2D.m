% Parabolic PDE
% dT/dt = kcond*(d^2T/dx^2)-kconv*(T-Ta)
% T(0,t)=10, T(1,t)=20  - BCs
% T(x,0)=0;             - IC

clear; clc
axis([0,11,-1,1]);
% Inputs
Nx=50;
Ny=50;
Nt=20000;
dt=0.005;
kcond=0.01;
kconv=0.1;
Lx=1;
Ly=1;
Tl=100;
Tr=100;
To=100;
Ta=100;
S = @(x,y,t) 20*sin((2*pi*t)/(10))*exp(-((x-.5)^2+(y-.5)^2)/.01);


cmax = 0;
% Create grid
x=linspace(0,Lx,Nx);
y=linspace(0,Ly,Ny);
dx=x(2)-x(1);

% Initial Condition
t=0;
T=zeros(Ny,Nx)+To;

% Loop over time
Tnew=T;
for n=1:Nt
    
    % Update time
    t=t+dt;
    
    % Update the temp on interior grid points
    for i=2:Nx-1
        for j=2:Ny-1
            Tnew(i,j)=(kcond*((T(i-1,j)-4*T(i,j)+T(i+1,j)+T(i,j-1)+T(i,j+1))/(dx)^2)...
            -kconv*(T(i,j)-Ta)+S(x(i),y(j),t))*dt+T(i,j);
        end
    end
    T=Tnew;
    
     
    for i=1:Nx
        T(i,1) = T(i,2);
        T(i,Ny) = T(i,Ny-1);
    end    
    for j=1:Ny
        T(1,j) = T(2,j);
        T(Nx,j) = T(Nx-1,j);
    end
    [tmax, ndx] = max(max(T));
    if tmax > cmax
        cmax = tmax;
        tcmax = t;
    end
    % Update the boundary condition
    if rem(n,10)==0
        surf(x,y,T);
        colormap(hot)
        pause
    end
end
disp(cmax)