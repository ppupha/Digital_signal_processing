I = double(imread('bimage6.bmp')) / 255; %bw image

figure(1);
imshow(I);
title('Original image');

PSF = fspecial('motion', 30, 80); 
%PSF = fspecial('disk', 10);

[J1, P1] = deconvblind(I, PSF);
figure(2);
imshow(J1);
title('Recovered image');
