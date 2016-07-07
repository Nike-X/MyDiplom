function nImage = dist_Noise(image,nInt)
%% split channels
imageR = double(image(:,:,1))/255;
imageG = double(image(:,:,2))/255;
imageB = double(image(:,:,3))/255;
% imageRspan = [min(min(imageR)) max(max(imageR))]

%% generate noise
noiseR = nInt*2*(rand(size(imageR)) - 1/2);
noiseG = nInt*2*(rand(size(imageR)) - 1/2);
noiseB = nInt*2*(rand(size(imageR)) - 1/2);
% noiseRspan = [min(min(noiseR)) max(max(noiseR))]

%% add noise
imageR = imageR + noiseR;
imageG = imageG + noiseG;
imageB = imageB + noiseB;
% imageRspan = [min(min(imageR)) max(max(imageR))]

%% clipping
imageR = min(imageR,ones(size(imageR)));
imageR = max(imageR,zeros(size(imageR)));
imageG = min(imageG,ones(size(imageG)));
imageG = max(imageG,zeros(size(imageG)));
imageB = min(imageB,ones(size(imageB)));
imageB = max(imageB,zeros(size(imageB)));
% imageRspan = [min(min(imageR)) max(max(imageR))]

%% result
nImage = cat(3,imageR,imageG,imageB);
nImage = uint8(round(255*nImage));
end
