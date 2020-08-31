% BISECTION METHOD
%Define function ~= j--> not equal to
f= @(x) (pi*x.^2.*(12-x)/3)-100;
%Define end points of interval
xlow=0;
xh=8;
%Error Tolerance
tol=1e-5;

%evaluat funtion at end points
fl=f(xlow);
fh=f(xh);
%Check root is in interval
if sign(fl)==sign(fh)
    error ('f(xlow) and f(xh) must have different signs')
end
%plot function
x = linspace(xlow,xh,1000);
figure(1);clf(1)
plot(x,f(x))
xlabel('x')
ylabel('y')
set(gca, 'Fontsize',16)
hold on
% initiate xr and xrold
xr = xlow;
%iterate until converged
count=0;
while abs(xlow-xh)>tol
    count=count+1;
    %Estimate root
    xr = 0.5*(xlow+xh); %bisection method
    %update xlow or xh
    if sign(f(xr)) == sign(f(xlow))
        xlow = xr; %lower subinterval
    else
        xh=xr; 
    end
    disp(count)
end
root = xr;
disp(root)
%add root to plot
plot(root, f(root),'ro')
text(root, -10,['Root:', num2str(root)])