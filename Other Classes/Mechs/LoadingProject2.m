dt = 0.001;

ID = 0.0318;
A = (ID/2)^2*pi;
P = 1034200;

h_chamber = 0.122;
V_chamber = h_chamber*A;

h = 3;
l = 0.1;

v = -.001;
g = 9.81;

f=0;
k=0;

mass = 80;

V=[];
H=[];

T = 0;
while v < 0
    T = T + dt;
    %Find force
    if h < 0
        break;
    elseif h < l
        presure = (P*V_chamber)/(A*(h_chamber-h));
        f = -g + presure*A + k*(h-l);
    else
        f = -g;
    end
    v = v +(f*dt)/mass;
    V = [V,v];
    h = h + v*dt;
    H = [H,h];
end

yyaxis left
plot((1:length(V))/dt,V);
yyaxis right
plot((1:length(H))/dt,H);