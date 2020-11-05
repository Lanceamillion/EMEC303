clear; clc

N=5; % Number of elements
k=10; % N/m
f=1; % N
A=0.1;  % m^2
L=1;    % m
E = 10^7; % modulus

% Undeformed node locations
x=linspace(0,L,N+1);
Le = x(2)-x(1); % length of each element

% Prealloate the matrix
K=zeros(N+1,N+1);
F=zeros(N+1,1);

% Fill in matrices
for i=2:N
    K(i,i  )=k + k;  % Diagonal k(i-1) + k(i)
    K(i,i-1)=-k;     % Lower diagonal -k(i-1)
    K(i,i+1)=-k;     % Upper diagonal -k(i)
    F(i,1  )=0;
end
% First row
K(1,1)=1;
% Last row
K(N+1,N+1)=k;
K(N+1,N  )=-k;
F(N+1,1  )=f;

% Solve for the displacements
U=K\F;

% Plot the object
figure(1); clf(1)
plot(x,zeros(1,length(x))+0.1,'ok','Markersize',10) % Undeformed object
hold on
plot(x'+U,zeros(1,length(x))-0.1,'or','Markersize',10) % Deformed object
legend('Undeformed','Deformed');
xlabel('x');
set(gca,'fontsize',18)
ylim([-0.5,0.5]);
yticks([]);

% Strain
strain=zeros(1,N);
for i=1:N
    strain(i)=(U(i+1)-U(i))/Le;
end

figure(2); clf(2)
plot(strain)


% Stress
stress = strain*E;