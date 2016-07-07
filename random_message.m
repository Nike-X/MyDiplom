function [steg_random irregularity] = random_message(len)
steg_random = randsrc(1,len,[0 1; (1-0.5) 0.5]);
irregularity = sum(steg_random) / length(steg_random)

steg_random = num2str(steg_random);
steg_random(ismember(steg_random,' ,.:;!')) = [];
end