%add specific amounts of noise to the stacks in the folder
tic
dataDir = './data/hand/';
list=dir([dataDir '\*.mat']);
resultsDir='f:\spbSU\masters\evM_Matlab\output\hand\noisy';



for iterator =1:numel(list)
disp (list(iterator).name);

StackFile=fullfile(dataDir, list(iterator).name);
StackFile;
[~,StackName] = fileparts(StackFile);
Name=strsplit(StackName, '_');
file=Name(1);
load(StackFile, 'Stack');

Stack_work=Stack;


for sigma =  0.001:0.004:0.013
%sigma
noisy_stack=add_noise(Stack_work, sigma);
Stack=noisy_stack;


save_loc_cell=fullfile(resultsDir, strcat(Name(1), '_', Name(2), '_', Name(3), '_', strrep(num2str(sigma),'.',''), '.mat'));
save_loc=save_loc_cell{1}

save(save_loc, 'Stack');


end;

for sigma = 0.002:0.011:0.221
%sigma
noisy_stack=add_noise(Stack_work, sigma);
Stack=noisy_stack;

save_loc_cell=fullfile(resultsDir, strcat(Name(1), '_', Name(2), '_', Name(3), '_', strrep(num2str(sigma),'.',''), '.mat'));
save_loc=save_loc_cell{1}

save(save_loc, 'Stack');

end;

for sigma = 0.001:0.050:2.051
%sigma
noisy_stack=add_noise(Stack_work, sigma);
Stack=noisy_stack;

save_loc_cell=fullfile(resultsDir, strcat(Name(1), '_', Name(2), '_', Name(3), '_', strrep(num2str(sigma),'.',''), '.mat'));
save_loc=save_loc_cell{1}

save(save_loc, 'Stack');

end;

end;

toc