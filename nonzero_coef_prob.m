function [ lsbBlocks ] = nonzero_coef_prob(dctBlocks)

dctBlocks2 = dctBlocks;
dctBlocks2(dctBlocks2==0) = NaN;
dctBlocks2(~isnan(dctBlocks2)) = 1;
dctBlocks2(isnan(dctBlocks2)) = 0;
dctDensity = sum(dctBlocks2,3);

figure, imshow(dctDensity/max(max(dctDensity)),'InitialMagnification',1500);
impixelregion


lsbBlocks = [];
dctBlocks3 = dctBlocks;
for z = 1:size(dctBlocks3, 3)
    block = dctBlocks3(:,:,z);
    block = block(:) + 256;
    binDctBlock = de2bi(block(:));
    binDctBlock = binDctBlock(:,1);
    lsbOnes = sum(binDctBlock);
    lsbBlocks = cat(1, lsbBlocks, lsbOnes);
    binDctBlock = reshape(binDctBlock,8,8);
    dctBlocks3(:,:,z) = binDctBlock;
end

dctDensity2 = sum(dctBlocks3,3);

figure, imshow(dctDensity2/size(dctBlocks3, 3),'InitialMagnification',1500);
impixelregion

figure
histfit(lsbBlocks)
grid on

end

