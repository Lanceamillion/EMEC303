%% EMEC 303 HW11
%  Lance Nichols
%  Section-002
%  10/26/2020

clear all; clc; close all;

%% Problem 1: Fourier Series/Transform

%(a) A0 = 0 this is because the mean value is centered around y=0. Ak = 0
%because it is an odd function.

%(b)
% Fit a square wave using Fourier series
figure(1); clf(1)
% f(t)= sum 2/(pi*k*wo)^2 * sin(k*wo*pi) * sin(k*wo*t)
N =10000;                   % Number of points in solution
t =linspace(-4,4,N);        % Create time array
f =zeros(1,N);              % Initialize fit to zero
T =4;                       % Period is 2s from plot
wo=2*pi/T;                  % Fundemental frequency = 2pi/T
sub = 1;

% Create series
for k=1:5000
    bk = (-6*cos(2*wo*k)+3*cos(4*wo*k)+3)/(2*k*wo);
    f = f+bk*sin(k*wo*t);
    
    % Plot current series
    figure(1)
    if k == 1 || k == 5 || k == 50 || k == 500 || k == 5000
        subplot(5,1,sub);
        plot(t,f,'k','linewidth',2);
        xlabel('t','Fontsize',20)
        ylabel('f(t)','Fontsize',20)
        title(['k=',num2str(k)],'Fontsize',20)
        axis([-4,4,-4,4])
        set(gca,'Fontsize',20)
        sub = sub + 1;
    end
end
%As more terms are added the solution becomes closer to the square wave.

%(c)

k=1:50;
figure(2)
stem((k*T^-1),(-6*cos(2*wo*k)+3*cos(4*wo*k)+3)./(2*k*wo))
xlabel('Frq (Hz)','Fontsize',20)
ylabel('Amplitude','Fontsize',20)
title('Frq vs Amplitude','Fontsize',20)

%(d)
% The dominant frequancy is 0.25 Hz this makes sense as it is the frequancy
% of the square wave.

%(e)
% amplitude decays as the frequancy increases. This makes sense as higher
% amplitude waves just exist on top of the main waves that form the shape.