function [steg len irreg] = message_read_my(filename)
fID = fopen(filename);
msg = fread(fID);
fclose(fID);

msg = num2cell(msg);
msg = cellfun(@(x) dec2bin(x,8), msg, 'UniformOutput', false);

steg = cellfun(@(x) [x], msg, 'UniformOutput', false);
steg = cell2mat(steg');
len = length(steg)

count = 0;
for i = 1:len
    if steg(i) == '1';
        count = count+1;
    end
end

irreg = len - 2*count;

end