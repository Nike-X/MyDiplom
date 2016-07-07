clc
close all;

[Y C] = quantization_tables(85);
image = imread('moria_map.jpg');
steg = message_read_my('message3.txt');
prop_45 = min(bincounts(25), bincounts(26));
prop_67 = min(bincounts(27), bincounts(28));

trash_45 = 0;
trash_67 = 0;

%% split into blocks
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
% for i = 1:8:size(image,1)
%     for j = 1:8:size(image,2)
%         noisyImageBlock = noisyImage(i:(i+7),j:(j+7));
%         noisyImageBlock = double(noisyImageBlock) - 128;
%         noisyCoefBlock = dct2(noisyImageBlock);
%         noisyQuantizedBlock = round(noisyCoefBlock ./ Y);
%         noisyQuantizedBlock = noisyQuantizedBlock(:)+192;
%         for k = 1:64          
%             if count <= length(steg) && (noisyQuantizedBlock(k) == 5+192 || noisyQuantizedBlock(k) == 4+192) && trash_45 <= prop_45
%                             q = dec2bin(noisyQuantizedBlock(k),9);
%                             q(9) = steg(count);
%                             count = count + 1;
%                             trash_45 = trash_45 + 1;
%                             noisyQuantizedBlock(k) = bin2dec(q);
%             end
% 
%             if count <= length(steg) && (noisyQuantizedBlock(k) == 7+192 || noisyQuantizedBlock(k) == 6+192) && trash_67 <= prop_67
%                             q = dec2bin(noisyQuantizedBlock(k),9);
%                             q(9) = steg(count);
%                             count = count + 1;
%                             trash_67 = trash_67 + 1;
%                             noisyQuantizedBlock(k) = bin2dec(q);
%             end
% 
%         end
%         noisyQuantizedBlock = reshape(noisyQuantizedBlock,8,8) - 192;
%         noisyDctBlocks = cat(3,noisyDctBlocks,noisyQuantizedBlock);
%         %assemble noisy image
%         noisyNewCoefBlock = noisyQuantizedBlock .* Y;
%         noisyNewBlock = idct2(noisyNewCoefBlock)+128;
%         noisyNewImage(i:(i+7),j:(j+7)) = uint8(noisyNewBlock);
%     end
% end
% 
% b = noisyNewImage;

for i = 1:8:size(image,1)
    for j = 1:8:size(image,2)
        kImageBlock = kImage(i:(i+7),j:(j+7));
        kImageBlock = double(kImageBlock) - 128;
        kCoefBlock = dct2(kImageBlock);
        kQuantizedBlock = round(kCoefBlock ./ Y);
        kQuantizedBlock = kQuantizedBlock(:)+192;
        for k = 1:64
%             a = dec2bin(noisyQuantizedBlock(k),9);
%             a(9) = steg(count);
%             count = count + 1;
%             noisyQuantizedBlock(k) = bin2dec(a);
            %if count <= length(steg) && (noisyQuantizedBlock(k) == 5+192 || noisyQuantizedBlock(k) == -5+192 || noisyQuantizedBlock(k) == 4+192 || noisyQuantizedBlock(k) == -4+192 || noisyQuantizedBlock(k) == 6+192 || noisyQuantizedBlock(k) == -6+192 || noisyQuantizedBlock(k) == 7+192 || noisyQuantizedBlock(k) == -7+192)
             if count <= length(steg) && (kQuantizedBlock(k) ~= 0+192 || kQuantizedBlock(k) ~= 1+192 || kQuantizedBlock(k) ~= -1+192)% || noisyQuantizedBlock(k) == 7+192)
                a = dec2bin(kQuantizedBlock(k),9);
                a(9) = steg(count);
                count = count + 1;
                kQuantizedBlock(k) = bin2dec(a);
            end
        end
        kQuantizedBlock = reshape(kQuantizedBlock,8,8) - 192;
        kDctBlocks = cat(3,kDctBlocks,kQuantizedBlock);
        %assemble noisy image
        kNewCoefBlock = kQuantizedBlock .* Y;
        kNewBlock = idct2(kNewCoefBlock)+128;
        kNewImage(i:(i+7),j:(j+7)) = uint8(kNewBlock);
    end
end

c = kNewImage;