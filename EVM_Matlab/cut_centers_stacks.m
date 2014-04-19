%cut out the center pixels for all the stacks in a folder, which are saved in the .mat files
%save them into separate .mat files

dataDir = './clean_set/data/test/blurred_oldfiles';

list=what('./clean_set/data/test/blurred_oldfiles');

resultsDir='./clean_set/data/test/single_pixel';

for iterator =1:numel(list.mat)
disp (list.mat(iterator));
load(fullfile(dataDir, list.mat{iterator}), 'Blurred_Stack');
Center_Cut_Stack=stack_center_cut(Blurred_Stack);
disp (['Center pixel stack for ' list.mat{iterator} ' has been built.']);
save(fullfile(resultsDir,['Center' list.mat{iterator}]), 'Center_Cut_Stack');
disp (['Center pixel stack for ' list.mat{iterator} ' saved.']);

end;
