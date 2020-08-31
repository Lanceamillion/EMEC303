% Newton-Raphson
clear; clc

% Symbolic math to compute the derivative
syms x y
u = x^2+x*y-10;
v = y+ 3*x*y^2-57;

dudx=diff(u,x);
dudy=diff(u,y);
dvdx=diff(v,x);
dvdy=diff(v,y);

% Covert symbolic functions into regular functions with inputs of (x,y)
u = matlabFunction(u);
v = matlabFunction(v);
dudx = matlabFunction(dudx,'Vars',[x y]);
dudy = matlabFunction(dudy,'Vars',[x y]);
dvdx = matlabFunction(dvdx,'Vars',[x y]);
dvdy = matlabFunction(dvdy,'Vars',[x y]);

% Initial guess for the root
xr=1;
yr=1;
% Maximum number of steps
N=1000;
tol=1e-5;

% Plot function
x=linspace(-5,5,100);
y=linspace(-5,5,100);
U=zeros(100,100);
V=zeros(100,100);
for i=1:100
    for j=1:100
        U(i,j)=u(x(i),y(j));
        V(i,j)=v(x(i),y(j));
    end
end
figure(1); clf(1);
% Plot u(x,y)
surf(x,y,U')
hold on
% Plot v(x,y)
surf(x,y,V')

% Iterate
for i=1:1000
    % Store the old value
    xro=xr;
    yro=yr;
    
    % Update xr & yr
    xr=xro-(u(xro,yro)*dvdy(xro,yro)-v(xro,yro)*dudy(xro,yro)) ...
        / (dudx(xro,yro)*dvdy(xro,yro)-dudy(xro,yro)*dvdx(xro,yro));
    yr=yro-(v(xro,yro)*dudx(xro,yro)-u(xro,yro)*dvdx(xro,yro)) ...
        / (dudx(xro,yro)*dvdy(xro,yro)-dudy(xro,yro)*dvdx(xro,yro));
    
    
            
    % Plot current guess for root
    hold on
    plot3(xr,yr,u(xr,yr),'o','Markersize',10)
    plot3(xr,yr,u(xr,yr),'o','Markersize',10)
    pause(1);
    
    % Output to command window
    fprintf('Iter=%5i, xr=%5.5f, yr=%5.5f, Error=%5.5e \n', ...
        i,xr,yr,max(abs(xr-xro),abs(yr-yro)))
    
    % Stop loop if converged
    if max(abs(xr-xro),abs(yr-yro))<tol
        fprintf('The root is (x,y)=(%5.10f,%5.10f) \n',xr,yr)
        break
    end
    
end
