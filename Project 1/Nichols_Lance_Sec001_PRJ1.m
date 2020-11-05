%% EMEC 303 PRJ1
%  Lance Nichols
%  Section-002
%  10/9/2020

clear; clc; clf;

% Constants
k1 = 0.2;
k3 = 0.5;
A_in = 0.5;
C_air = 1005;
ro_air = 1.2;
dt = 1;
Time = 0:dt:(86400*2);
timeAdjusted = 0;


T1 = zeros(1,length(Time));
T2 = zeros(1,length(Time));

Q_track = zeros(1,length(Time));
Q_track(1) = 0;

T1(1) = 5;
T2(1) = 7;

% Changing variables
k2 = 10;
Q_in = 2500;

% Equations
Tout = @(t) -10*sin((2*pi*t)/86400);
Q1 = @(T1,t) k1*(T1-Tout(t));
Q2 = @(T1,T2,k2) k2*(T1-T2+5);
Q3 = @(T2,t) k3*(T2-Tout(t));

dT1dt = @(T1,T2,t,Q_in,k2) (-(3*6*2+3*5*2)*Q1(T1,t)...
    -(5*6)*Q2(T1,T2,k2)...
    +A_in*Q_in)/...
    (C_air*ro_air*(3*6*5));

dT2dt = @(T1,T2,t,k2) ((5*6)*Q2(T1,T2,k2)...
    -Q3(T2,t)*(3*6+(18^0.5)*10))/...
    (C_air*ro_air*(3*6*3*.5));

for i = 2:length(Time)
    T1(i) = T1(i-1) + dT1dt(T1(i-1),T2(i-1),Time(i),Q_in,k2);
    T2(i) = T2(i-1) + dT2dt(T1(i-1),T2(i-1),Time(i),k2);
%     if T1(i) > 22
%         Q_in = 0;
%     end
%     if T1(i) < 18
%         Q_in = 2500;
%     end
    if Time(i) > timeAdjusted + 60*60*2
        timeAdjusted = Time(i);
        if T2(i) > 20
            k2 = 3;
        else
            k2 = 5;
        end
        Q_in = 1600*((sin(2*pi*(Time(i)+60*60)/86400)+1)/2)+900;
        
    end
    Q_track(i) = Q_in;
end

error = (abs(sum(abs(T1-20)))+abs(sum(abs(T2-20))))/(2*length(Time));

plot(Time/(60*60),T1)
hold on
plot(Time/(60*60),T2)
legend("T1","T2",'location',"se")
xlabel("Time [h]")
title("Sinusodal Temperature Altering at 2-Hour Intervals")
ylabel("Temperature [C]")
text(1,5,"Error T: " + error)
hold off