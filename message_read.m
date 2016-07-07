clc;

fID = fopen('message3.txt');
msg = fread(fID);
fclose(fID);

msg = num2cell(msg);
msg = cellfun(@(x) dec2bin(x,8), msg, 'UniformOutput', false);

steg = cellfun(@(x) [x], msg, 'UniformOutput', false);
steg = cell2mat(steg')
length(steg)