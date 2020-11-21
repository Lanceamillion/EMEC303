% Like for 1D signals, it's possible to filter images by applying a 
% Fourier transformation (fft2), multiplying with a filter in the frequency 
% domain,and transforming back into the space domain. Here is how you 
% can apply high- or low-pass filters to an image with Matlab:
% Adapted from(
% https://riptutorial.com/matlab/example/19910/filtering-using-a-2d-fft)
clear; clc

% load and visualize image
myimg=imread('Ash.JPG');  
figure(1);clf(1)
subplot(2,2,1)
imshow(myimg)
title('Original Image')

%spatial frequency mapped from the center to the edges with fftshift
ft = fftshift(fft2(myimg));% fftshift is used shift the quadrants of the 
%FFT around to see the lowest frequencies in the center of the plot.
subplot(2,2,2)
imshow(real(ft))
title('Spacial Frequency')

% generate disc-shaped binary mask
[x,y,~] = size(ft);
D = 10; % radius  % adjust this number to change mask
mask = fspecial('disk', max(1e-16,D)) == 0;
mask = imresize(padarray(mask, [floor((x/2)-D) floor((y/2)-D)]...
                                    , 1, 'both'), [x y]);
                               
% Mask freq domain image
masked_ft = ft .* mask;
subplot(2,2,3)
imshow(real(masked_ft))
title(['Masked FFT= ',num2str(D)]) 

% Inverse Fourier to see filtered image data
filtered_image = ifft2(ifftshift(masked_ft), 'symmetric');
subplot(2,2,4)
imshow(uint8(filtered_image))
title('Filtered Image')
