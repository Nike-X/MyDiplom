clc
close all;

[Y, C] = quantization_tables(85);
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
        kImageBlock = kImage(i:(i+7),j:(j+7));
        kImageBlock = double(kImageBlock) - 128;
        kCoefBlock = dct2(kImageBlock);
        kQuantizedBlock = round(kCoefBlock ./ Y);
        kQuantizedBlock = kQuantizedBlock(:)+192;
        for k = 2:64
            if count <= length(steg) && (kQuantizedBlock(k) ~= 0+192 && kQuantizedBlock(k) ~= 1+192)% || kQuantizedBlock(k) ~= -1+192)
                a = dec2bin(kQuantizedBlock(k),9);
                a(9) = steg(count);
                count = count + 1;
                kQuantizedBlock(k) = bin2dec(a);
            end
        end
        kQuantizedBlock1 = reshape(kQuantizedBlock,8,8) - 192;
        %kDctBlocks = cat(3,kDctBlocks,kQuantizedBlock);
        %assemble noisy image
        kNewCoefBlock = kQuantizedBlock1 .* Y;
        kNewBlock = idct2(kNewCoefBlock)+128;
        kNewImage(i:(i+7),j:(j+7)) = uint8(kNewBlock);
    end
end

c = kNewImage;