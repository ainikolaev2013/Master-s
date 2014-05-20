%Test 256x256 stacks for hand

%dataDir = 'F:\SPBSU\Masters\EVM_Matlab\data\hand';
dataDir = './output/hand'; %for one night batch only!
list=dir([dataDir '\*192.mat']);
resultsDir='./output/hand';

level=4;

for iterator =1:numel(list)
disp (list(iterator).name);

StackFile=fullfile(dataDir, list(iterator).name);
StackFile;
[~,StackName] = fileparts(StackFile);
   
%    Gdown_stack=1;
    
    disp('Spacial filtering...')
    Gdown_stack = build_GDown_stack_stack192(StackFile, level);
    disp('Finished filtering...')
%ntsc spectrum
NTSC_stack=rgb2ntsc(squeeze(Gdown_stack));

%dataf=spectrum_cell(squeeze(Gdown_stack(:,:,:,1)));
dataf=spectrum_cell(squeeze(NTSC_stack(:,1)));

fig=plot([2:300]/length(dataf)*25, abs(dataf(3:300+1)), 'r');
title([StackName  ' NTSC'])
  saveas(fig, fullfile(resultsDir,[StackName '-spectrum.png']));
    

save(fullfile(resultsDir,[StackName 'Gdown_stack.mat']), 'Gdown_stack');
save(fullfile(resultsDir,[StackName 'NTSC_stack.mat']), 'NTSC_stack');
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

 
 fig=plot(squeeze(NTSC_stack(:,1)));
title([StackName  ' NTSC graph'])
 saveas(fig, fullfile(resultsDir,[StackName '-NTSCgraph.png']));

end;
