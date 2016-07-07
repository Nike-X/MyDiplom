clc
close all;

[Y C] = quantization_tables(85);
image = imread('Lenna.bmp');
steg = message_read_my('message.txt');
%image = rgb2gray(image);
% image = imresize(image,0.5);
% imshow(image);

%% split into blocks
%newImage = image;
noisyImage = image;
kImage = image;
%noisyImage = imnoise(image, 'gaussian', 0, 0.001);
% imshow(noisyImage)
% dctBlocks = zeros(8,8,size(image,1)*size(image,2)/64);
dctBlocks = [];
noisyDctBlocks = [];
kDctBlocks = [];
P = 5;
count = 1;
count2 = 1;
for i = 1:8:size(image,1)
    for j = 1:8:size(image,2)
%         imageBlock = image(i:(i+7),j:(j+7));
%         imageBlock = double(imageBlock) - 128;
%         coefBlock = dct2(imageBlock);
%         quantizedBlock = round(coefBlock ./ Y);
%         dctBlocks = cat(3,dctBlocks,quantizedBlock);
        %I = cat(2,I,quantizedBlock);
%           dctBlocks(:,:,i*(size(image,1)/8-1)+j) = quantizedBlock;
        % for noisy image
        noisyImageBlock = noisyImage(i:(i+7),j:(j+7));
        noisyImageBlock = double(noisyImageBlock) - 128;
        noisyCoefBlock = dct2(noisyImageBlock);
        noisyQuantizedBlock = round(noisyCoefBlock ./ Y);
        noisyQuantizedBlock = noisyQuantizedBlock(:)+192;
        for k = 1:64
%             a = dec2bin(noisyQuantizedBlock(k),9);
%             a(9) = steg(count);
%             count = count + 1;
%             noisyQuantizedBlock(k) = bin2dec(a);
            if count <= length(steg) && (noisyQuantizedBlock(k) == 5+192 || noisyQuantizedBlock(k) == -5+192 || noisyQuantizedBlock(k) == 4+192 || noisyQuantizedBlock(k) == -4+192 || noisyQuantizedBlock(k) == 6+192 || noisyQuantizedBlock(k) == -6+192 || noisyQuantizedBlock(k) == 7+192 || noisyQuantizedBlock(k) == -7+192)
             %if count <= length(steg) %&& (noisyQuantizedBlock(k) ~= 0+192 || noisyQuantizedBlock(k) == 1+192 || noisyQuantizedBlock(k) == -1+192)% || noisyQuantizedBlock(k) == 7+192)
                a = dec2bin(noisyQuantizedBlock(k),9);
                a(9) = steg(count);
                count = count + 1;
                noisyQuantizedBlock(k) = bin2dec(a);
            end
        end
        noisyQuantizedBlock = reshape(noisyQuantizedBlock,8,8) - 192;
        noisyDctBlocks = cat(3,noisyDctBlocks,noisyQuantizedBlock);
        % for KJ image
%         kImageBlock = kImage(i:(i+7),j:(j+7));
%         kImageBlock = double(kImageBlock) - 128;
%         kCoefBlock = dct2(kImageBlock);
%         kQuantizedBlock = round(kCoefBlock ./ Y);
%         kQuantizedBlock = kQuantizedBlock(:);
%         if abs(kQuantizedBlock(14)) - abs(kQuantizedBlock(37)) <= P && steg(count2) == '0'
%             kQuantizedBlock(14) = P + kQuantizedBlock(10);
%         elseif abs(kQuantizedBlock(3)) - abs(kQuantizedBlock(37)) >= -P && steg(count2) == '1'
%             kQuantizedBlock(37) = P + kQuantizedBlock(14);
%         end
%         count2 = count2 + 1;
%         kQuantizedBlock = reshape(kQuantizedBlock,8,8);
%         kDctBlocks = cat(3,kDctBlocks,kQuantizedBlock);
%         %assemble compressed image
%         newCoefBlock = quantizedBlock .* Y;
%         newBlock = idct2(newCoefBlock)+128;
%         newImage(i:(i+7),j:(j+7)) = uint8(newBlock);
        %assemble noisy image
        noisyNewCoefBlock = noisyQuantizedBlock .* Y;
        noisyNewBlock = idct2(noisyNewCoefBlock)+128;
        noisyNewImage(i:(i+7),j:(j+7)) = uint8(noisyNewBlock);
%         %assemble KJ image
%         kNewCoefBlock = kQuantizedBlock .* Y;
%         kNewBlock = idct2(kNewCoefBlock)+128;
%         kNewImage(i:(i+7),j:(j+7)) = uint8(kNewBlock);
    end
end

% imshow(newImage)
% imshow(noisyNewImage)
% imshow(kNewImage)
% imwrite(newImage,'newLenna.png');

% 
% MSE1 = sum((image(:) - newImage(:)).^2)/(size(image,1)*size(image,2))
% PSNR1 = 10 * log10(255^2/MSE1)

% % MSE for images
% MSE2 = sum((image(:) - noisyNewImage(:)).^2)/(size(image,1)*size(image,2))
% PSNR2 = 10 * log10(255^2/MSE2)
% 
% MSE3 = sum((image(:) - kNewImage(:)).^2)/(size(image,1)*size(image,2))
% PSNR3 = 10 * log10(255^2/MSE3)
% 
% % MSE for DCT
% dctMSE = sum((dctBlocks(:) - noisyDctBlocks(:)).^2)/(size(dctBlocks(:),1))
% dctMSE2 = sum((dctBlocks(:) - kDctBlocks(:)).^2)/(size(dctBlocks(:),1))

%% coef density
% dctBlocks2 = dctBlocks;
% dctBlocks2(dctBlocks2==0) = NaN;
% dctBlocks2(~isnan(dctBlocks2)) = 1;
% dctBlocks2(isnan(dctBlocks2)) = 0;
% dctDensity = sum(dctBlocks2,3);
% res1 = dctDensity/max(max(dctDensity));
% 
% figure, imshow(dctDensity/max(max(dctDensity)),'InitialMagnification',1500);
% impixelregion

%for compressed image
% dctBlocks3 = dctBlocks;
% dctBlocks3(dctBlocks3==0) = NaN;
% dctBlocks3(~isnan(dctBlocks3)) = 1;
% dctBlocks3(isnan(dctBlocks3)) = 0;
% dctDensity3 = sum(dctBlocks3,3);
% res2 = dctDensity3/max(max(dctDensity3));
% med1 = sum((image(:) - newImage(:)).^2)/(size(image,1)*size(image,2));

% for noisy image
% noisyDctBlocks2 = noisyDctBlocks;
% noisyDctBlocks2(noisyDctBlocks2==0) = NaN;
% noisyDctBlocks2(~isnan(noisyDctBlocks2)) = 1;
% noisyDctBlocks2(isnan(noisyDctBlocks2)) = 0;
% noisyDctDensity = sum(noisyDctBlocks2,3);
% res3 = noisyDctDensity/max(max(noisyDctDensity));
%med1 = max(abs(res1(:) - res3(:)))%sum((res1(:) - res3(:)).^2)/(size(res1,1)*size(res1,2))

% figure, imshow(noisyDctDensity/max(max(noisyDctDensity)),'InitialMagnification',1500);
% impixelregion
% imshow(dctDensity);
% impixelregion

% % for KJ image
% kDctBlocks2 = kDctBlocks;
% kDctBlocks2(kDctBlocks2==0) = NaN;
% kDctBlocks2(~isnan(kDctBlocks2)) = 1;
% kDctBlocks2(isnan(kDctBlocks2)) = 0;
% kDctDensity = sum(kDctBlocks2,3);
% res4 = kDctDensity/max(max(kDctDensity));
% med2 = max(abs(res1(:) - res4(:)))

% figure, imshow(kDctDensity/max(max(kDctDensity)),'InitialMagnification',1500);
% impixelregion

%% histogram
% dctBlocks3 = dctBlocks;
% h = dctBlocks3(:);
% h(h==0) = NaN;
% h(h==1 | h==-1) = NaN;
% range = max(h)-min(h)+1;
%histogram(h,range)

% rzlt = hist(h,range);
%ax1 = (-200:1:200);
% figure
% hist(h,range)
% axis([-20 20 0 1500]);
% set(get(gca,'child'),'FaceColor','c','EdgeColor','k');
% grid on
% figure, plot(rzlt);
% rzlt(-min(h)+1+3)

% for noisy image
% h1 = noisyDctBlocks(:);
% h1(h1==0) = NaN;
% h1(h1==1 | h1==-1) = NaN;
% range = max(h1)-min(h1)+1;
% 
% figure
% hist(h1,range)
% axis([-20 20 0 1500]);
% set(get(gca,'child'),'FaceColor','c','EdgeColor','k');
% grid on

% for KJ image
% h2 = kDctBlocks(:);
% h2(h2==0) = NaN;
% h2(h2==1 | h2==-1) = NaN;
% range = max(h2)-min(h2)+1;
% 
% figure
% hist(h2,range)
% axis([-20 20 0 1500]);
% set(get(gca,'child'),'FaceColor','c','EdgeColor','k');
% grid on

%%%%%
% hystMed1 = sum((h - h1).^2)/(size(h,1));

%posR = rzlt((-min(h)+1):end);
%figure, plot(rzlt);
% figure, histogram(posR,1:numel(posR))
%%
% u = [];
% for ind = (-min(h)+1):(-min(h)+48)
%     a = rzlt(ind);
%     b = rzlt(ind+1);
%     c = a+b;
%     prc = b/c*100;
%     u = [u prc];
% end
% plot(u)


%% comparison
% diff = newImage-image;
% figure, imshow(10*diff)
% max(max(diff))
% impixelregion