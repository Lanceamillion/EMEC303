% BISECTION METHOD
%Define function ~= j--> not equal to
f= @(x) x.^2-5;
%Define end points of interval
xlow=0;
xh=10;
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
xrold = xh;
%iterate until converged
count=0;
while abs(xr-xrold)>tol
    count=count+1;
    
    % store xrold
    xrold=xr;
    %Estimate root
%     xr = 0.5*(xlow+xh); %bisection method
    xr= xlow-fl*(xh-xlow)/(fh-fl); % linear interpolation
    %update xlow or xh
    if sign(f(xr)) == sign(f(xlow))
        xlow = xr; %lower subinterval
    else
        xh=xr; 
    end
end
root = xr;
% display
fprintf('Iter=%5i','xr=%5.5f','fr=%5.5e' ,count,xr,f(xr))
%add root to plot
plot(root, f(root),'ro')
text(root, -10,['Root:', num2str(root)])