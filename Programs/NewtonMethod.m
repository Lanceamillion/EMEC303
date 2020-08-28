%% EMEC 303 HW1
%  Lance Nichols
%  Section-002
%  8/26/2020

% Define Fuction
syms x
f = x.^2-5;
% Compute the derivitive
fp = diff(f,x);
% Make both matlabFunctions
f = matlabFunction(f);
fp = matlabFunction(fp);

% Plot funcion
figure(1); 
clf(1);
xp = linspace(-2,2,100);
plot(xp,f(xp))

% Initial guess
xr = 1;
% Perameters
N = 100; %Number of iterations allowed
Nc = 1; %Current iteration starting at 1 bc MatLab
tol = 1e-5; %Tolerance

while Nc<N
   xro = xr; %Old xr update
   xr = xro - f(xro)/fp(xro);
   if abs(xr-xro)<tol
       fprintf('Converged root: %5.5f \n',xr)
       break
   end
   Nc =+ 1; 
end