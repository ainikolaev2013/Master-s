%add specific amounts of noise to the stacks in the folder
dataDir = './data/face';
list=dir([dataDir '\*.mat']);
resultsDir='f:\spbSU\masters\evM_Matlab\output\face\noisy';



for iterator =1:numel(list)
disp (list(iterator).name);

StackFile=fullfile(dataDir, list(iterator).name);
StackFile;
[~,StackName] = fileparts(StackFile);
Name=strsplit(StackName, '_');
file=Name(1);
load(StackFile, 'Stack');

Stack_work=Stack;


for sigma = 0.001:0.004:0.013
%sigma
noisy_stack=add_noise(Stack_work, sigma);
Stack=noisy_stack;
save(fullfile(resultsDir, strcat(file, '_test_stack1_', strrep(num2str(sigma),'.',''), '.mat')), 'Stack');

end;



 
end;
