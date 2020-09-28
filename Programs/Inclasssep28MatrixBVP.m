%% EMEC 303
%  Lance Nichols
%  Section-002
%  9/28/2020

%% 2d potential flow problem
clear;clc;
% inputs
nx=40;
ny=40;
lx=1;
ly=1;
x=linspace(0,lx,nx);
y=linspace(0,ly,nx);
dx=x(2)-x(1);
dy=y(2)-y(1);
if dx~=dy
    error('dx must equal dy')
end
%boundary conditions and matrices
phi_ul=10;
phi_lr=0;
a=zeros(nx*ny,nx*ny);
b=zeros(nx*ny,1);
for i=2:nx-1
    for j=2:ny-1
    n=i+(j-1)*nx;%identify row
    a(n,n)=-4;%phi(i,j)
    a(n,n-1)=1;%phi(i-1,j)
    a(n,n+1)=1;%phi(i+1,j)
    a(n,n-nx)=1;%phi(i,j-1)
    a(n,n+nx)=1;%phi(i,j+1)
    b(n,1)=0;
    end
end
i=1;
for j=1:ceil(ny/2)%derivative boundary conditions
    n=i+(j-1)*nx;
    a(n,n)=1;
    a(n,n+1)=1;
    b(n,1)=0;
end
for j=ceil(ny/2)+1:ny
    n=i+(j-1)*nx;
    a(n,n)=1;
    b(n,1)=phi_ul;
end
%right side
i=nx;
for j=1:ceil(ny/2)%derivative boundary conditions
    n=i+(j-1)*nx;
    a(n,n)=1;
    b(n,1)=phi_lr;
end
for j=ceil(ny/2)+1:ny
    n=i+(j-1)*nx;
    a(n,n)=1;
    a(n,n-1)=-1;
    b(n,1)=0;
end
%bottom boundaries
j=1;
for i=2:nx-1
    n=i+(j-1)*nx;
    a(n,n)=1;
    a(n,n+nx)=-1;
    b(n,1)=0;
end

j=ny;
for i=2:nx-1
    n=i+(j-1)*nx;
    a(n,n)=1;
    a(n,n-nx)=-1;
    b(n,1)=0;
end
%solve
phiV=a\b;
%store as 2d array
phi=zeros(nx,ny);
for i=1:nx
    for j=1:ny
    n=i+(j-1)*nx;
    phi(i,j)=phiV(n);
    end
end
%plot
figure(1);clf(1);
surf(x,y,phi);
xlabel('x');
ylabel('y');
zlabel('\phi(x,y)');