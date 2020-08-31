%% EMEC 303 HW1
%  Lance Nichols
%  Section-002
%  8/31/2020

% Pressure drop through pipe with length L and flow rate Q
dwdt=@(w)4*w-3;

h=.5;
ti=1;
w=1;

for t = 1:0.5:3
    %disp("t: " + num2str(t) + " w: " + num2str(w))
    fprintf("t: %4.3f w: %4.3f \n",t,w)
    w = dwdt(w)*h+w; 
end
    