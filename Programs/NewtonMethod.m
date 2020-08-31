%% EMEC 303 HW1
%  Lance Nichols
%  Section-002
%  8/26/2020

% Define Fuction
syms x
f = (pi*x.^2.*(12-x)/3)-100;
% Compute the derivitive
fp = diff(f,x);
% Make both matlabFunctions
f = matlabFunction(f);
fp = matlabFunction(fp);

% Plot funcion
%figure(1); 
%clf(1);
%xp = linspace(-2,2,100);
%plot(xp,f(xp))

% Initial guess
xr = 1;
% Perameters
N = 100; %Number of iterations allowed
Nc = 0; %Current iteration
tol = 1e-5; %Tolerance

while Nc<N
   Nc = Nc + 1;
   xro = xr; %Old xr update
   xr = xro - f(xro)/fp(xro);
   if abs(xr-xro)<tol
       fprintf('Converged root: %5.5f Iteration#: %i \n',xr,Nc)
       break
   end
end