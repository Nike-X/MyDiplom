clc
clear
close all

% open first image
a = imread('moria_map.jpg');
if size(a,3) > 1
    a = a(:,:,1);
end
imshow(a)

% transformation
[DCTA, dctBlocksA, lsbBlocksA] = transform(a);

%distribution of coefs values
[bincounts, h1, range] = coef_value_distr(dctBlocksA);