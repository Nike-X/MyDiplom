function [ bincounts, h, range ] = coef_value_distr(dctBlocks)

dctBlocks3 = dctBlocks;
h = dctBlocks3(:);

binranges = -20:20;
[bincounts] = histc(h,binranges);

y = [];
for i = 1:length(binranges)
    y(i) = bincounts(i)/sum(bincounts);
end

h(h==0) = NaN;
h(h==1 | h==-1) = NaN;
range = max(h)-min(h)+1;

hist(h,range)
axis([-20 20 0 1500]);
set(get(gca,'child'),'FaceColor','c','EdgeColor','k');
grid on
end

