function [Y C] = gen_100Qtables()
Y = [];
C = [];
for Q = 1:100
    [Y1 C1] = quantization_tables(Q);
    Y = cat(3,Y,Y1);
    C = cat(3,C,C1);
end
end