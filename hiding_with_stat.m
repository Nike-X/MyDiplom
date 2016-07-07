function [ newImage ] = hiding_with_stat(DCT, steg)

[Y C] = quantization_tables(85);
count = 1;

for i = 1:8:size(DCT,1)
    for j = 1:8:size(DCT,2)
        dctBlock = DCT(i:(i+7),j:(j+7));
        
        dctBlock = dctBlock(:)+192;
%         for k = 1:64
% %             a = dec2bin(noisyQuantizedBlock(k),9);
% %             a(9) = steg(count);
% %             count = count + 1;
% %             noisyQuantizedBlock(k) = bin2dec(a);
%             if count <= length(steg) && (dctBlock(k) == 5+192 || dctBlock(k) == -5+192 || dctBlock(k) == 4+192 || dctBlock(k) == -4+192 || dctBlock(k) == 6+192 || dctBlock(k) == -6+192 || dctBlock(k) == 7+192 || dctBlock(k) == -7+192)
%              %if count <= length(steg) %&& (noisyQuantizedBlock(k) ~= 0+192 || noisyQuantizedBlock(k) == 1+192 || noisyQuantizedBlock(k) == -1+192)% || noisyQuantizedBlock(k) == 7+192)
%                 a = dec2bin(dctBlock(k),9);
%                 a(9) = steg(count);
%                 count = count + 1;
%                 dctBlock(k) = bin2dec(a);
%             end
%         end
        dctBlock = reshape(dctBlock,8,8) - 192;
               
        %assemble image
        newCoefBlock = double(dctBlock) .* Y;
        newBlock = idct2(newCoefBlock)+128;
        newImage(i:(i+7),j:(j+7)) = newBlock;
        
    end
end

end

