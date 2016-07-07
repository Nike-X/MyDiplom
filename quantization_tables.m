function [Y C] = quantization_tables(Q)
% IJG standard tables
IJG_table_Y =  [16 11 10 16 24 40 51 61;
                12 12 14 19 26 58 60 55;
                14 13 16 24 40 57 69 56;
                14 17 22 29 51 87 80 62;
                18 22 37 56 68 109 103 77;
                24 35 55 64 81 104 113 92;
                49 64 78 87 103 121 120 101;
                72 92 95 98 112 100 103 99];
IJG_table_C =  [17	18	24	47	99	99	99	99;
                18	21	26	66	99	99	99	99;
                24	26	56	99	99	99	99	99;
                47	66	99	99	99	99	99	99;
                99	99	99	99	99	99	99	99;
                99	99	99	99	99	99	99	99;
                99	99	99	99	99	99	99	99;
                99	99	99	99	99	99	99	99];
            
% compute scalefactor
if (Q<50)
    S = 5000/Q;
else
    S = 200-2*Q;
end

% scale matrices
Y = floor((IJG_table_Y .* S + 50)/100);
Y = max(Y,ones(size(Y)));
C = floor((IJG_table_C .* S + 50)/100);
C = max(C,ones(size(C)));
end