%% EMEC 303 HW1
%  Lance Nichols
%  Section-002
%  8/31/2020

% Pressure drop through pipe with length L and flow rate Q
dwdt=@(w)2*cos(w)+.2;

h=.1;
w=2;

for t = 0:h:15.5
    %disp("t: " + num2str(t) + " w: " + num2str(w))
    fprintf("t: %4.3f w: %4.3f \n",t,w)
    yp = w + dwdt(t);
    w = w+(dwdt(t+h)+dwdt(t))*0.5*h;
end
    