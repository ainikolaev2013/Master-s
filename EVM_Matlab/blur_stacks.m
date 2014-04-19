%blur all the stacks in a folder, which are saved in the .mat files
%save them into separate .mat files

dataDir = 'data';

list=what('./data');

resultsDir='./output/blurred_oldfiles';

for iterator =1:numel(list.mat)
disp (list.mat(iterator));
load(fullfile(dataDir, list.mat{iterator}), 'Stack');
Blurred_Stack=stack_blur(Stack);
disp (['Blurred stack for ' list.mat{iterator} ' has been built.']);
save(fullfile(resultsDir,['Blurred' list.mat{iterator}]), 'Blurred_Stack');
disp (['Blurred stack for ' list.mat{iterator} ' saved.']);

end;
