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
dctBlocks = [];
noisyDctBlocks = [];
kDctBlocks = [];
tmp = '0';
count = 1;
count2 = 1;
for i = 1:8:size(image,1)
    for j = 1:8:size(image,2)
        noisyImageBlock = noisyImage(i:(i+7),j:(j+7));
        noisyImageBlock = double(noisyImageBlock) - 128;
        noisyCoefBlock = dct2(noisyImageBlock);
        noisyQuantizedBlock = round(noisyCoefBlock ./ Y);
        noisyQuantizedBlock = zigZag(noisyQuantizedBlock)+192;
        for k = 19:-1:2
             if count <= length(steg) 
                a = dec2bin(noisyQuantizedBlock(k),9);
                if a(9) ~= steg(count)% && (noisyQuantizedBlock(k) ~= 0+192 || noisyQuantizedBlock(k) ~= 1+192 || noisyQuantizedBlock(k) ~= -1+192)
                    b = a;
                    b(9) = steg(count);
                    b = bin2dec(b);
                    for z = 2:k-1
                        if noisyQuantizedBlock(z) == b% && noisyQuantizedBlock(z) ~= 0
                            t = noisyQuantizedBlock(k);
                            noisyQuantizedBlock(k) = b;
                            noisyQuantizedBlock(z) = t;
                            count = count + 1;
                            break
                        else 
                            noisyQuantizedBlock(k) = b;
                            count = count + 1;
                        end
                    end 
                    %a(9) = steg(count);
%                     count = count + 1;
%                     noisyQuantizedBlock(k) = bin2dec(a);
                else
                    count = count + 1;
                    %noisyQuantizedBlock(k) = bin2dec(a);
                end
            end
        end
        %noisyQuantizedBlock - 192
        noisyQuantizedBlock1 = invZigzag(noisyQuantizedBlock) - 192;
        %noisyDctBlocks = cat(3,noisyDctBlocks,noisyQuantizedBlock);
        %assemble noisy image
        noisyNewCoefBlock = noisyQuantizedBlock1 .* Y;
        noisyNewBlock = idct2(noisyNewCoefBlock)+128;
        noisyNewImage(i:(i+7),j:(j+7)) = uint8(noisyNewBlock);
    end
end

d = noisyNewImage;