% Parabolic PDE
% Cooling fin - heated from bottom
clear; clc

% Inputs
Nx=10;     % Grid points
Ny=10;
Nz=20;     
Nt=100000;  % Number of time steps
dt=1e-8; % Timestep
kcond=240; % Conductivity of aluminum W/(m K)
kconv=200; % Convection coefficient (free convection) W/(m^2 K)
Lx=0.05;  % m
Ly=0.05;  % m
Lz=0.2;  % m
Tair=20; % C
To=Tair; % C
Q=1000;  % W 

MaxTemp = [0,0,0,0];
MinTemp = [1000000,0,0,0];

% Create grid
x=linspace(0,Lx,Nx);
y=linspace(0,Ly,Ny);
z=linspace(0,Lz,Nz);
dx=x(2)-x(1);
dy=y(2)-y(1);
dz=z(2)-z(1);

% Initial Condition
t=0;
T=zeros(Nx,Ny,Nz)+To;

% Loop over time
Tnew=T;
for n=1:Nt
    
    % Update time
    t=t+dt;
    
    % Update the temp on interior grid points
    for k=2:Nz-1
        for j=2:Ny-1
            for i=2:Nx-1
                Tnew(i,j,k)=T(i,j,k)+dt*(kcond*( ...
                    (T(i-1,j,k)-2*T(i,j,k)+T(i+1,j,k))/dx^2 + ...
                    (T(i,j-1,k)-2*T(i,j,k)+T(i,j+1,k))/dy^2 + ...
                    (T(i,j,k-1)-2*T(i,j,k)+T(i,j,k+1))/dz^2));
                if Tnew(i,j,k) > MaxTemp(1)
                    MaxTemp(1) = Tnew(i,j,k);
                    MaxTemp(2) = i;
                    MaxTemp(3) = j;
                    MaxTemp(4) = k;
                end
                if Tnew(i,j,k) < MinTemp(1)
                    MinTemp(1) = Tnew(i,j,k);
                    MinTemp(2) = i;
                    MinTemp(3) = j;
                    MinTemp(4) = k;
                end
            end
        end
    end
    T=Tnew;
    
    % Convection boundary conditions (bottom BC set above)
    i= 1; T(i,:,:)=(kcond/dx*T(i+1,:,:)+kconv*Tair)/(kcond/dx+kconv); % Left
    i=Nx; T(i,:,:)=(kcond/dx*T(i-1,:,:)+kconv*Tair)/(kcond/dx+kconv); % Right
    j= 1; T(:,j,:)=(kcond/dy*T(:,j+1,:)+kconv*Tair)/(kcond/dy+kconv); % Front
    j=Ny; T(:,j,:)=(kcond/dy*T(:,i-1,:)+kconv*Tair)/(kcond/dy+kconv); % Back
    k= 1; T(:,:,k)=+Q/(Nx*Ny*dx*dy*kcond)*dz+(T(:,:,k+1)); % Bottom
    k=Nx; T(:,:,k)=(kcond/dz*T(:,:,k-1)+kconv*Tair)/(kcond/dz+kconv); % Top
    
    % Plot
    if rem(n,5000)==0
        % Plot planes through data
        figure(1); clf(1)
        title(['Time =',num2str(t)])
        % xy plane
        subplot(1,3,1)
        contourf(x,y,squeeze(T(:,:,Nz/2))')
        colorbar
        axis equal
        xlabel('x')
        ylabel('y')
        title('View from top')
        set(gca,'Fontsize',20)
        % xz plane
        subplot(1,3,2)
        contourf(x,z,squeeze(T(:,Ny/2,:))')
        colorbar
        axis equal
        xlabel('x')
        ylabel('z')
        title('View from front')
        set(gca,'Fontsize',20)
        % yz plane
        subplot(1,3,3)
        contourf(y,z,squeeze(T(Nx/2,:,:))')
        colorbar
        axis equal
        xlabel('y')
        ylabel('z')
        title('View from side')
        set(gca,'Fontsize',20)
        % Title
        sgtitle(['Time = ',num2str(t)],'FontSize',24)
        drawnow
    end
end