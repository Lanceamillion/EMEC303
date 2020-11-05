sig_xx = @(r) pi*r^2*200000;
tau_xy = @(r) 1500*r/(pi/2*(r)^4);

for r = linspace(.019,.02)
    A = zeros(3,3);
    A(1,1) = sig_xx(r);
    A(1,2) = tau_xy(r);
    A(2,1) = tau_xy(r);
    [a,p] = eig(A);
    disp(-p(1,1)+p(3,3) + " r " + r)
end