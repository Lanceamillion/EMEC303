%% EMEC 303 HW1
%  Lance Nichols
%  Section-002
%  9/11/2020

% Define Fuction
syms x y
dydx = cos(x)*y;
% Make both matlabFunctions
dydx = matlabFunction(dydx);

h = 0.0001;
x = 0;
y = -1;
xend = 100;

count = 1;

t = x:h:xend;
ylst = zeros(1,length(t));
alx = -exp(sin(t));

for i = t
    ylst(count) = y;
    count = count + 1;
    k1 = dydx(i,y);
    k2 = dydx(i+0.5*h,y+0.5*k1*h);
    k3 = dydx(i+0.5*h,y+0.5*k2*h);
    k4 = dydx(i+h,y+k3*h);
    y = y + (k1 + k2*2 + k3*2 + k4)*h/6;
end


plot(t,alx);
hold on
plot(t,ylst);
hold off

disp(y);