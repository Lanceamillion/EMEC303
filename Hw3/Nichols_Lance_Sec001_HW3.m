%% EMEC 303 HW3
%  Lance Nichols
%  Section-002
%  8/21/2020

%% Problem 1
vb_exp = [0,-0.3175,-0.9525,-2.2225,-3.175,-3.4925,-4.1275];
vc_exp = [0,-0.5312,-1.2351,-2.2332,-2.8575,-3.2375,-3.8925];

t_exp = [0,.08,.16,.24,.32,.40,.48];

%%% Analytic analysis
% Expected plot
Vin=@(t)t*-9.81;

% Cylinder Plot
figure(1); clf(1);
hold on
plot(t_exp,vc_exp);
plot(t_exp,Vin(t_exp),"--");
title('Falling Cylinder')
xlabel('Time (s)') 
ylabel('V (m/s)')
hold off
% Ball Plot
figure(2); clf(2);
hold on

plot(t_exp,vb_exp);
plot(t_exp,Vin(t_exp),"--");
title('Falling Ball')
xlabel('Time (s)') 
ylabel('V (m/s)')
hold off

%%% Numarical analysis
% Function
dvdt = @(V,CD,A,m)(0.5*1.225*V^2*CD*A)/m-9.81;

% Eulers Cylinder
h=.08;
v=0;
v1=zeros(1,7);
i = 2;
for t = 0:h:.40
    v = dvdt(v,0.82,0.003318,.02)*h+v;
    v1(i) = v;
    i = i+1;
end
figure(1);
hold on
plot(t_exp,v1);
legend("Experimental","Perdicted with no Drag","perdicted with drag");
hold off

% Eulers Sphere
h=.08;
v=0;
v2=zeros(1,7);
i = 2;
for t = 0:h:.40
    v = dvdt(v,0.41,0.003318,.04)*h+v;
    v2(i) = v;
    i = i+1;
end
figure(2);
hold on
plot(t_exp,v2);
legend("Experimental","Perdicted with no Drag","perdicted with drag");
hold off

%% Analysis and Write Up
% * (a) The experiment was completed using a ruler and my phone shooting at
% 25 fps The ruler wasn't in good focus aditionally paralax was not
% compencaded for and the computed veolocity could easily be introducing
% error.
% * (b) Done ✓
% * (c) Air resistance was ignored because an analytical solution may not be
% avalible for that complex of a diff eq. The Effect is that solution is
% linear.
% * (d) I used 0.08 second step size as it is two frames at 25 fps.
% * (e) Not much signifigance can be shown between the perdicted outcomes.
% Although the "with drag" solution is falling a little slower after .5
% seconds because the faster it falls the more drag it gets.
% * (f) Linear solutions are much simpler but at high velocites wind
% resistance matters and should be accounted for


