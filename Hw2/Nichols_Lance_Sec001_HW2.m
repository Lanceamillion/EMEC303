% Fixed point iteration of pipe system
clear; clc

f=0.005;  % Friction factor
rho=1.23; % Density (kg/m^3)
D=0.01;   % Pipe diameter (m)
% Pressure drop through pipe with length L and flow rate Q
dP  =@(L,Q)   16/pi^2*f*L*rho/(2*D^5)*Q.^2;
dPdQ=@(L,Q) 2*16/pi^2*f*L*rho/(2*D^5)*Q;  %d(deltaP)/dQ

% Input parameters
Q1=1; % m^3/s
L2=2; % m
L3=1; % m
L4=2; % m
L5=4; % m
L6=1; % m
tol=1e-5;  % Convergence tolerance

% Inital pressure drop and flow rate guesses
Q2=0.6; % m^3/s - assumes equal split at each intersection
Q3=Q1-Q2;
Q5=0.05;
Q4=Q3-Q5;
Q6=Q3;

figure(1); clf(1)

% Iterate
alpha=.01;
N=2000;
Qs=zeros(N,5);
for n=1:N    
    % Store old values
    Q2o=Q2; Q3o=Q3; Q4o=Q4; Q5o=Q5; Q6o=Q6;
    
    % Update
    Q2=Q2o+alpha*(Q1 -Q2o-Q3o);
    Q3=Q3o-alpha*(Q3o-Q4o-Q5o);
    Q4=Q4o-alpha*(dP(L2,Q2o)-dP(L3,Q3o)-dP(L4,Q4o)-dP(L6,Q6o)) ...
        /(-dPdQ(L4,Q4o));
    Q5=Q5o-alpha*(dP(L5,Q5o)-dP(L4,Q4o))/dPdQ(L5,Q5o);
    Q6=Q6o-alpha*(Q6o-Q3o);
    
    
    % Display output
    fprintf('Iter=%2i  Q2=%5.3f  Q3=%5.3f  Q4=%5.3f  Q5=%5.3f Q6=%5.3f \n', ...
        n,Q2,Q3,Q4,Q5,Q6)
    
    % Plot flow rates versus iteration
    Qs(n,:)=[Q2,Q3,Q4,Q5,Q6];
    if mod(n,10)==1
        plot(1:n,Qs(1:n,:))
        legend('Q2','Q3','Q4','Q5','Q6')
        drawnow
    end
    
    % Check if converged
    if max([abs(Q2-Q2o),abs(Q3-Q3o),abs(Q4-Q4o),abs(Q5-Q5o)])<tol
        disp('Converged')
        break % Stop for loop
    end
end


