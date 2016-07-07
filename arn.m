clc;
clear;

cam = imread('Lenna.bmp');
lena_RGB = imread('foto.bmp');
% cam = rgb2gray(cam);


 
% lena_RGB(1,:) = 255;
% lena_RGB(:,1) = 255;
lena = rgb2gray(lena_RGB);
% cam(1,:) = 255;
% cam(:,1) = 255;
% cam = rgb2gray(cam);
cam_dct = dct2(cam);
lena_dct = dct2(lena);

I = lena_RGB;
N = length(I);
A = [1,1;1,2];
x = 0.85;
n = 35;

% H = magic(N);
% I = double(I);
% I = mod(I+H.*n^2,255);

for k = 1:n
    im2 = zeros(N,N);
for i = 1:N
    for j = 1:N
       m = mod([i,j]*A,N)+1;
       im2(m(1),m(2)) = I(i,j);
    end
end
    I = im2;
end

imwrite(uint8(im2), 'transformed.bmp')
imshow(uint8(I))
% 
% % % zero diag
% % z = diag(diag(im2));
% % im2 = im2 - z;
% 
% cam_dct = dct2(cam);
% lena_dct = dct2(im2);
% blend = (x*cam_dct + (1-x)*lena_dct);
% 
% res = idct2(blend);
% result = uint8(res);
% imwrite(result, 'result2.bmp')
% imshow(result)
