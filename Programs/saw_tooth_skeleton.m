% Fit a saw-tooth curve using Fourier series
figure(1); clf(1)
% f(t)= sum 2/(pi*k*wo)^2 * sin(k*wo*pi) * sin(k*wo*t)
N =10000;                   % Number of points in solution
t =linspace(-4,4,N);        % Create time array
f =zeros(1,N);              % Initialize fit to zero
T =2;                       % Period is 2s from plot
wo=2*pi/T;                      % Fundemental frequency = 2pi/T

% Create series
for k=1:25
    % ao and ak terms are zero because the function is odd or f(t)=-f(-t)
    
    bk=(2*(sin(k*wo) - k*wo*cos(k*wo)))/(k^2*wo^2);
    f=f+bk*sin(k*wo*t);
    
    % Plot current series
    figure(1)
   
    plot(t,f,'k','linewidth',2);
    xlabel('t','Fontsize',20)
    ylabel('f(t)','Fontsize',20)
    title(['k=',num2str(k)],'Fontsize',20)
    axis([-4,4,-1.5,1.5])
    set(gca,'Fontsize',20) 
    % Pause to watch how model improves as terms are added to sum
    pause
end



    