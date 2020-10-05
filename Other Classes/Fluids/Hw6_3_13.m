% velocities from z = 0 to z = 2
v = [0,8,14.3,20,19.5,15.6,8.3,6.2,3.7,2,0];
% Pressure table
p = zeros(1,11);
% Initial Value
p(1,11) = 3600;

% Constants
dn = 0.2;
ro_w = 1.940;
gamma_w = 62.4;

% Equation
dp = @(n,v) -ro_w*v^2/(n+10)*dn - gamma_w * dn;

% Iterate
for i = flip(1:10)
   p(i) = p(i+1) - dp(i*dn,v(11-i));
end

%Plot
plot(linspace(0,20,11)/10,p);
xlabel("z Height (ft)")
ylabel("Pressure (psf)")
    
disp(p)