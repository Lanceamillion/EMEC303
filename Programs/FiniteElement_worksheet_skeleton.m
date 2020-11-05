clear; clc

N=50; % Number of elements
H=5; % Height
Db=1; % Diameter of base
g=9.8; % Gravitational acceleration
rho=1600; % Density
E=20e6; % Modulus

% Undeformed node locations
y=linspace(0,H,N+1);
dy=y(2)-y(1);

% Undeformed element locations
ym=0.5*(y(1:N)+y(2:N+1));

% Diameter at y location
D=@(y) Db-Db*y/H;

% Volume of ith element
V=@(i) pi*(D(y(i  ))/2)^2*(H-y(i  )) ...
      -pi*(D(y(i+1))/2)^2*(H-y(i+1));
  
% Compute stiffness of each element
k=zeros(1,N);
for i=1:N
    Area=pi/4*D(ym(i))^2;
    k(i)=Area*E/dy;
end

% Prealloate the matrix
K=zeros(N+1,N+1);
F=zeros(N+1,1);

% Fill in matrices
for i=2:N
    K(i,i  )=k(i-1) + k(i);  % Diagonal k(i-1) + k(i)
    K(i,i-1)=-k(i-1);        % Lower diagonal -k(i-1)
    K(i,i+1)=-k(i);        % Upper diagonal -k(i)
    F(i,1  )=V(i)*g*rho;
end
% First row U=0
K(1,1)=1;
F(1,1)=0;
% Last row F=0
K(N+1,N+1)=k(N);
K(N+1,N  )=-k(N);
F(N+1,1  )=0;

% Solve for the displacements
U=K\F;

% Plot the object
figure(1); clf(1)
plot(y,0,'o','Markersize',10) % Undeformed object
hold on
plot(y'+U,0.1,'x','Markersize',10) % Deformed object
ylim([-0.5,0.5])

% Strain
stain=zeros(1,N);
for i=1:N
    strain(i)=U(i+1)-U(i);
end
figure(2); clf(2)
plot(strain,'-o')

% Stress
stress = strain*E;
disp(['Max Stress = ',num2str(max(stress)),'Pa'])