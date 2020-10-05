% Liebmann's Method
% Iterative Fintie Difference
% Gauss Sidel
clear; clc

% Inputs
Tl=10;  % Temperature on 4 sides
Tr=20;
Tb=10;
Tt=20;
Nx=40;  % Number of grid points
Ny=40;
Lx= 1;  % Domain size
Ly= 2; 
Niter=10000; % Max number of iterations
tol = 1e-6;  % Convergence tolerance

% Grid
x=linspace(0,Lx,Nx);
y=linspace(0,Ly,Ny);
dx=x(2)-x(1);
dy=y(2)-y(1);

% Create an initial guess for the solution
T=zeros(Nx,Ny);

% Apply BC
for j=1:Ny
    if j > Ny/2
        T(1,j) = 10;
    end
end

% Iterate
Tnew=T;
for n=1:Niter
    % Loop over interior grid points
    for i=2:Nx-1
        for j=2:Ny-1
            Tnew(i,j)=0.25*(T(i-1,j)+T(i+1,j) ...
                + T(i,j-1) + T(i,j+1));
        end
    end
    % Check if converged
    res=max(abs(Tnew(:)-T(:)));
    if res<tol
        break
    end
    
    for j=1:Ny
        if j > Ny/2
            T(1,j) = 10;
            Tnew(Nx,j) = Tnew(Nx-1,j);
        end
        if j <= Ny/2
            T(Nx,j) = 0;
            Tnew(1,j) = Tnew(2,j);
        end
    end
    for i=1:Nx
        Tnew(i,1) = Tnew(i,2);
        Tnew(i,Nx) = Tnew(i,Nx-1);
    end
    
    % Transfer Tnew into T
    T=Tnew;
    
    % Plot current solution
    if rem(n,100)==0
        contourf(x,y,T')
        xlabel('x')
        ylabel('y')
        zlabel('T(x,y)')
        set(gca,'Fontsize',20)
        drawnow
    end
end