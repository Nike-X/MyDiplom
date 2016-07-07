function [DCT dctBlocks lsbBlocks] = transform(image)
[Y C] = quantization_tables(85);
dctBlocks = [];
lsbBlocks = [];
for i = 1:8:size(image,1)
    for j = 1:8:size(image,2)
        imageBlock = image(i:(i+7),j:(j+7));
        imageBlock = double(imageBlock) - 128;
        coefBlock = dct2(imageBlock);
        quantizedBlock = round(coefBlock ./ Y);
        dctBlocks = cat(3,dctBlocks,quantizedBlock);
        
        % LSB blocks
        lsbBlock = bitget(abs(quantizedBlock),1);
        lsbBlocks = cat(3,lsbBlocks,lsbBlock);
%         for k = 1:64
%             a = dec2bin(noisyQuantizedBlock(k),9);
%             lsb = a(9);
%             count = count + 1;
%             lsbBlock(k) = bin2dec(lsb);
%         end
        
        % assemble DCT blocks
        DCT(i:(i+7),j:(j+7)) = uint8(quantizedBlock);
    end
end

end

