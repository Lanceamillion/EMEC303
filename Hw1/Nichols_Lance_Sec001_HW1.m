%% EMEC 303 HW1
%  Lance Nichols
%  Section-002
%  8/21/2020

%% Problem 1
%
% * Picture on D2L ✓
% * MatLab installed ✓

%% Problem 2

% A) write the MATLAB script that does the following steps
%  a) Create an array of 20 zeros
A = zeros(20,1);
%  b) Put a 1 in the second entry in the array, i.e.,A= [0,1,0,...,0]
A(2) = 1;
%  c) Loop over the third to twentieth entries and compute the value by adding the previous two values.For exampleA(3) =A(1) +A(2) andA(4) =A(2) +A(3).
for i = 3:20
   A(i) = A(i-1)+A(i-2);
end
%  d) Display the final result along with the name of this famous sequence of numbers
disp("Final Result:");
disp(A);
disp("The Fibonacci Sequence")
% B) Create a line plot of the functionsy= sin(x) andy= cos(x) on the intervalx= [-pi;pi] with 1000 grid points.  Label your axes, adjust the font size so the  gure looks good, add a legend with line types that are easily distinguishable.
% Create and populate the domain
x = linspace(-pi,pi,1000);
% Calculate values for the functions
y1 = sin(x);
y2 = cos(x);
% Graph the result
plot(x,y1);
hold on
plot(x,y2);
xlabel('x');
ylabel('y');
title('Plot of the Sine and Cosine Function');
legend('sin(x)','cos(x)');
hold off
% C) Find a picture that depicts your summer and use MATLAB to display the image with a title and caption describing the activity.
figure;
I = imread('20200821_171221.jpg');
imshow(I);
title('Running thru the grass');
xlabel('Me running to pick up a balloon in eastern Montana');
% D) Using the Publish feature in MATLAB, save your code and output as a pdf ✓
