clc
close all

% open first image
% a = imread('imageA.png');
tic
% a = imread('gato.bmp');
% if size(a,3) > 1
%     a = a(:,:,1);
% end

% imshow(a)
% [steg len irreg] = message_read_my('message.txt');
%[steg2 irregularity] = random_message(len)
%bx = noisyNewImage;
%a = cat(3, a, a, a);

imshow(c)

% transformation
% [DCTA, dctBlocksA, lsbBlocksA] = transform(a);
% [DCTB dctBlocksB lsbBlocksB] = transform(b);
[DCTC dctBlocksC lsbBlocksC] = transform(c);
%[DCTD dctBlocksD lsbBlocksD] = transform(d);


% Hiding
%[b] = hiding_with_stat(DCTA, steg);

% generate second image as first with added noise
% b = imread('foto.bmp');
% b = b(:,:,1);

% % show both images
% figure, imshow([a b],'InitialMagnification',50);
% round(rand(1704))
% compute MSE and PSNR
% [MSE PSNR] = parameters(a,b)
% [MSE2 PSNR2] = parameters(a,c)

% compute difference
% [kGr] = perceptionDifferenceGrey(a,b)
% [kGr2] = perceptionDifferenceGrey(a,c)

% % probability of nonzero coef
% nonzero_coef_prob(dctBlocksA);
nonzero_coef_prob(dctBlocksC);

%distribution of coefs values
[bincounts, h1, range] = coef_value_distr(dctBlocksA);
[y h, range] = coef_value_distr(dctBlocksC);
% [z] = coef_value_distr(dctBlocksC)
% %[chi] = chi_square(x,y)
% chi_square = sum((y - x)./x)
% chi_square_jsteg = sum((z - x)./x)

% probability of nonzero LSB
% [irregularityA] = nonzero_LSB_prob(lsbBlocksA)
% [irregularityB] = nonzero_LSB_prob(lsbBlocksB)
% [irregularityC] = nonzero_LSB_prob(lsbBlocksC)

toc
