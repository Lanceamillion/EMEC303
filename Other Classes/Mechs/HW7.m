format long

%% 7.1

A = [-1550
    -1537
    1520
    0
    0
    2609];
v = .33;
E = 68.9*10^9;
B = [1-v v v 0 0 0
    v 1-v v 0 0 0
    v v 1-v 0 0 0
    0 0 0 1-2*v 0 0
    0 0 0 0 1-2*v 0
    0 0 0 0 0 1-2*v];

Stress = (E/((1+v)*(1-2*v))*B)*(A/(10^6));

D = zeros(3,3);
D(1,1) = Stress(1);
D(1,2) = Stress(6);
D(2,1) = Stress(6);
D(2,2) = Stress(2);
D(3,3) = Stress(3);

[~,p] = eig(D);

disp(p)

%% 7.3
A = [1500
    500
    -400
    0
    -300
    100];
v = .28;
E = 189.6*10^9;
B = [1-v v v 0 0 0
    v 1-v v 0 0 0
    v v 1-v 0 0 0
    0 0 0 1-2*v 0 0
    0 0 0 0 1-2*v 0
    0 0 0 0 0 1-2*v];

Stress = (E/((1+v)*(1-2*v))*B)*(A/(10^6));

D = zeros(3,3);
D(1,1) = Stress(1);
D(1,2) = Stress(6);
D(2,1) = Stress(6);
D(2,2) = Stress(2);
D(3,3) = Stress(3);

[~,p] = eig(D);

disp(p)

%% 7.4

%Givens
ep_a = 2000e-6;
ep_b = 1800e-6;
ep_c = -1500e-6;

S_y = 925e6;
E = 120e9;
v = 0.361;

%Solve
ep_x = ep_a;
ep_y = ep_c;
ep_xy = ep_b - .5*(ep_a+ep_c);
ep_z = -v/(1-v)*(ep_x+ep_y);

A = [ep_x
    ep_y
    ep_z
    0
    0
    ep_xy];

B = [1-v v v 0 0 0
    v 1-v v 0 0 0
    v v 1-v 0 0 0
    0 0 0 1-2*v 0 0
    0 0 0 0 1-2*v 0
    0 0 0 0 0 1-2*v];

%Calculate Stress

Stress = (E/((1+v)*(1-2*v))*B)*(A/(10^6));

%Make Tensor

D = zeros(3,3);
D(1,1) = Stress(1);
D(1,2) = Stress(6);
D(2,1) = Stress(6);
D(2,2) = Stress(2);
D(3,3) = Stress(3);

[~,p] = eig(D);

%Using Tresca

sigma_prime = abs(p(1,1) - p(3,3))*10^6;

N = S_y/sigma_prime;

disp(N)