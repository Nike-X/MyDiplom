function [kGr] = perceptionDifferenceGrey(a,b)
%% convert to YCbCr
% a1 = rgb2ycbcr(a);
% b1 = rgb2ycbcr(b);

%% split into channels
% a1y = a1(:,:,1);
% a1cb = a1(:,:,2);
% a1cr = a1(:,:,3);
% 
% b1y = b1(:,:,1);
% b1cb = b1(:,:,2);
% b1cr = b1(:,:,3);

%% generate quantization tables
[Y C] = gen_100Qtables();

%% evaluate octets
% all blocks
tic;
kGrs = 0;
% kYs = 0;%zeros(1,100);
% kCbs = 0;%zeros(1,100);
% kCrs = 0;% zeros(1,100);
pr = 0;
DM = dctmtx(8);
% numblocks = floor(size(a1y)/8);
% disp(numblocks)

count = 0;

% for each octet
for h = 1:8:(size(a,1)-7)
    for w = 1:8:(size(a,2)-7) 
        % extract blockA
        aGr = a(h:(h+7),w:(w+7));
%         acb = a1cb(h:(h+7),w:(w+7));
%         acr = a1cr(h:(h+7),w:(w+7));
        % extract blockB
        bGr = b(h:(h+7),w:(w+7));
%         bcb = b1cb(h:(h+7),w:(w+7));
%         bcr = b1cr(h:(h+7),w:(w+7));
        
        % add differences
        [avgeGr deGr] = evaluate_block(aGr,bGr,Y,DM);
        kGr = deGr ./ avgeGr;
        kGrs = kGrs + kGr;
        
%         [avgeCb deCb] = evaluate_block(acb,bcb,C,DM);
%         kCb = deCb ./ avgeCb;
%         kCbs = kCbs + kCb;
%                 
%         [avgeCr deCr] = evaluate_block(acr,bcr,C,DM);
%         kCr = deCr ./ avgeCr;
%         kCrs = kCrs + kCr;
        
        count = count + 1;
    end
    if(pr ~= round(h/size(a,1)*10))
        disp([num2str(round(h/size(a,1)*10)) '0%']);
        pr = round(h/size(a,1)*10);
    end
end
toc;

kGr = sum(kGrs) ./ count;
% kCb = sum(kCbs) ./ count
% kCr = sum(kCrs) ./ count
end