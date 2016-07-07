function [avgSum diff] = evaluate_block(blockA,blockB,qm,DM)
%% compute DCT2
% dcta = dct2(blockA);
% dctb = dct2(blockB);
dcta = dctmtx_(blockA,DM);
dctb = dctmtx_(blockB,DM);

%% compute average
avgSum = sum(sum(abs(dcta)));

%% compute difference
Q = 80;
    
% choose table for quality
quant_matrix = qm(:,:,Q);

% quantize
a = round(dcta ./ quant_matrix);
b = round(dctb ./ quant_matrix);

% compare results
d = a-b;
d = abs(d);
diff = sum(sum(d));

end