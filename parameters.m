function [MSE PSNR] = parameters(a, b)
MSE = sum((a(:) - b(:)).^2)/(size(a,1)*size(a,2));
PSNR = 10 * log10(255^2/MSE);

end

