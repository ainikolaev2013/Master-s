%Test 64x64 stacks for 16 line

dataDir = 'F:\SPBSU\Masters\EVM_Matlab\data\16';
list=dir([dataDir '\*.mat']);
resultsDir='./output/16';

level=4;

for iterator =1:numel(list)
disp (list(iterator).name);

StackFile=fullfile(dataDir, list(iterator).name);
StackFile;
[~,StackName] = fileparts(StackFile);
   
%    Gdown_stack=1;
    
    disp('Spacial filtering...')
    Gdown_stack = build_GDown_stack_stack4(StackFile, level);
    disp('Finished filtering...')

dataf=spectrum_cell(squeeze(Gdown_stack(:,:,:,1)));

fig=plot([2:300]/length(dataf)*25, abs(dataf(3:300+1)), 'r');
title([StackName  ' channel 1'])
  saveas(fig, fullfile(resultsDir,[StackName '-spectrum.png']));
    

save(fullfile(resultsDir,['Gdown_stack_' StackName '.mat']), 'Gdown_stack');

%graphs
fig=plot(squeeze(Gdown_stack(:,:,:,1)));
title([StackName  ' channel 1 graph'])
 saveas(fig, fullfile(resultsDir,[StackName '-graph1.png']));

fig=plot(squeeze(Gdown_stack(:,:,:,2)));
title([StackName  ' channel 2 graph'])
 saveas(fig, fullfile(resultsDir,[StackName '-graph2.png']));
 
 fig=plot(squeeze(Gdown_stack(:,:,:,1)));
title([StackName  ' channel 3 graph'])
 saveas(fig, fullfile(resultsDir,[StackName '-graph3.png']));


end;
