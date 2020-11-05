% Shallow water equations
clear; clc

% Parameters
Lx=2;       % Domain size
Ly=1;  
b =1;       % Dampening coefficient
g =9.8;     % Gravity
H =0.1;     % Height of water (unperturbed)
Nx=128;      % Number of grid points
Ny=64;
dt=0.0001;  % Timestep
Tfinal=5; % Simulation time

% Create grid
x=linspace(0,Lx,Nx);
y=linspace(0,Ly,Ny);
dx=x(2)-x(1);
dy=y(2)-y(1);

% Initial condition
t=0;
u=zeros(Nx,Ny); % u=0
v=zeros(Nx,Ny); % v=0
% h=Gaussian
xo=0.5;
yo=0.5;
sigma=0.05;
h=zeros(Nx,Ny);
for i=1:Nx
    for j=1:Ny
        % 1D Gaussian
       % h(i,j)=0.5*exp(-((x(i)-xo)^2)/(2*sigma^2));
        
        % 2D Gaussiankihbiubiuu5yrwsryturhpoiuvyrwedfyiuj,
        h(i,j)=0.5*exp(-((x(i)-xo)^2+(y(j)-yo)^2)/(2*sigma^2));
    end
end

% Preallocate arrays
hnew=zeros(Nx,Ny);
unew=zeros(Nx,Ny);
vnew=zeros(Nx,Ny);

% Loop over time
Nt=Tfinal/dt;
for n=1:Nt
    % Update time
    t=t+dt;
    
    % Loop over interior points
    for i=2:Nx-1
        for j=2:Ny-1
            % Compute derivatives
            dudx=(u(i+1,j)-u(i-1,j))/(2*dx);
            dvdy=(v(i,j+1)-v(i,j-1))/(2*dy);
            dhdx=(h(i+1,j)-h(i-1,j))/(2*dx);
            dhdy=(h(i,j+1)-h(i,j-1))/(2*dy);
            % Update height & velocity
            hnew(i,j) = h(i,j) + dt*(-H*(dudx+dvdy));
            unew(i,j) = u(i,j) + dt*(-g*dhdx-b*u(i,j));
            vnew(i,j) = v(i,j) + dt*(-g*dhdy-b*v(i,j));
        end
    end
    % Transfer solution
    h=hnew;
    u=unew;
    v=vnew;
    
    % Apply BC's
    % Left
    h( 1, :) = h( 2, :); 
    u( 1, :) =-u( 2, :);
    v( 1, :) = v( 2, :);
    % Right
    h(Nx, :) = h(Nx-1, :); 
    u(Nx, :) =-u(Nx-1, :);
    v(Nx, :) = v(Nx-1, :);
    % Bottom
    h( :, 1) = h( :, 2); 
    u( :, 1) = u( :, 2);
    v( :, 1) =-v( :, 2);
    % Top
    h(:,Ny) = h( :,Ny-1); 
    u(:,Ny) = u( :,Ny-1);
    v(:,Ny) =-v(:,Ny-1);
    
    % Plot
    if rem(n,100)==1
        surf(x,y,H+h')
        shading interp
        axis equal
        zlim([0,0.5])
        drawnow
    end
end
    
    
    