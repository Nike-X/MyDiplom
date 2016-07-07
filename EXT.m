a = imread('Lenna.bmp');

% transformation
[DCTA, dctBlocksA, lsbBlocksA] = transform(a);
[DCTD, dctBlocksD, lsbBlocksD] = transform(d);
[DCTC, dctBlocksC, lsbBlocksC] = transform(c);

% compute MSE and PSNR
[MSE, PSNR] = parameters(a,d)
[MSE2, PSNR2] = parameters(a,c)

%distribution of coefs values
[x] = coef_value_distr(dctBlocksA);
[y] = coef_value_distr(dctBlocksD);
[z] = coef_value_distr(dctBlocksC);
%[chi] = chi_square(x,y)
chi_square = sum((y - x)./x)
chi_square_jsteg = sum((z - x)./x)