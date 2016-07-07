clear;
clc;
tic
I = imread('foto.bmp');
I = RGB2gray(I);
M = size(I,1);
N = size(I,2);
blocksize = 8;



QUANT_MATRIX = [16 11 10 16 24 40 51 61;
                12 12 14 19 26 58 60 55;
                14 13 16 24 40 57 69 56;
                14 17 22 29 51 87 80 62;
                18 22 37 56 68 109 103 77;
                24 35 55 64 81 104 113 92;
                49 64 78 87 103 121 120 101;
                72 92 95 98 112 100 103 99];
            

I = (double(I)) - 128;
fun = @(block_struct) dct2(block_struct.data);
Ir = blockproc(I,[8 8], fun);
fun2 = @(block_struct) round(block_struct.data ./ QUANT_MATRIX);
I_res = blockproc(Ir,[8 8], fun2);

I_res(I_res == 0) = NaN;
I_res(I_res == -1) = NaN;
I_res(I_res == 1) = NaN;

% change = I_res;
% change(change == 2) = 3;
% change(change == -2) = -3;
% change(change == 3) = 2;
% change(change == -3) = -2;

%change(change) = 0;
% fun3 = @(block_struct) round(block_struct.data .* QUANT_MATRIX);
% image = blockproc(change,[8 8], fun3);
% fun4 = @(block_struct) idct2(block_struct.data);
% image = blockproc(image,[8 8], fun4);
% image = image + 128;
% image = uint8(image);
% imshow(image)

% num = 1:1:10;
% num_minus = -1:-1:-10;
% acc = zeros(1,10);
% acc_minus = zeros(1,10);
% 
% for i = 1:length(num)
%     acc(i) = numel(find(I_res == num(i)));
%     acc_minus(i) = numel(find(I_res == num_minus(i)));
% end
% 
% result2 = [fliplr(acc_minus) acc]
% abs(result - result2) ./ ((result + result2) ./ 2)

tmp = I_res;
%tmp(tmp == 0)=NaN;

for i = 1:size(tmp,1)
    for j = 1:size(tmp,2)
        if isfinite(tmp(i, j))
            tmp(i, j) = bitget(abs(tmp(i, j)),1);
        end
    end
end


%%%%%%%%%
X = [];
Z = [];

for i = 1:8:M
    for j = 1:8:N
        X = cat(3,X,I(i:i+7,j:j+7));
        Z = cat(3,Z,tmp(i:i+7,j:j+7));
    end
end
toc

count = 0;
on = 0;
for i = 1:size(tmp,1)
    for j = 1:size(tmp,2)
       if isfinite(tmp(i, j))
           count = count+1;
           if (tmp(i, j)) == 1
               on = on + 1;
           end
       end
    end
end