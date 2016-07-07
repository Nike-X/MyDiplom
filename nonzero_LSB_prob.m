function [ irregularity ] = nonzero_LSB_prob(lsbBlocks)

dctBlocks2 = lsbBlocks;
% dctBlocks2(dctBlocks2==0) = NaN;
% dctBlocks2(~isnan(dctBlocks2)) = 1;
% dctBlocks2(isnan(dctBlocks2)) = 0;
dctDensity = sum(dctBlocks2,3);
length(dctBlocks2(:))
ones_LSB = sum(dctDensity(:))/length(dctBlocks2(:));
irregularity = ((1 - ones_LSB) - ones_LSB)/ones_LSB;
%res1 = dctDensity/max(max(dctDensity));

% figure, imshow(dctDensity/max(max(dctDensity)),'InitialMagnification',1500);
% impixelregion

end