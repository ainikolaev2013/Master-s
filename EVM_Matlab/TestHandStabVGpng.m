%Test 64x64 videos for hand

dataDir = 'F:\SPBSU\Masters\EVM_Matlab\data\hand';
list=dir([dataDir '\*.avi']);
resultsDir='./output/hand';

level=4;

for iterator =1:numel(list)
vid = (list(iterator).name)


%Stack=Stack_from_video_nocrop(fullfile(dataDir, vid));



    
vidFile=fullfile(dataDir, list(iterator).name);
vidFile;
[~,vidName] = fileparts(vidFile);
   
%    Gdown_stack=1;
    
    disp('Spacial filtering...')
    Gdown_stack = build_GDown_stack_stack4_nofile(Stack, level);
    disp('Finished filtering...')

    
fl=50/60;
fh=70/60;
% Temporal filtering
disp('Temporal filtering...')
F_stack = ideal_bandpassing(Gdown_stack, 1, fl, fh, 25);
disp('Finished')
    
    
    
%ntsc spectrum
NTSC_stack=rgb2ntsc(squeeze(Gdown_stack));
NTSCF_stack=rgb2ntsc(squeeze(F_stack));

%dataf=spectrum_cell(squeeze(Gdown_stack(:,:,:,1)));
dataf=spectrum_cell(squeeze(NTSC_stack(:,1)));
dataFf=spectrum_cell(squeeze(NTSCF_stack(:,1)));

fig=plot([2:300]/length(dataf)*25, abs(dataf(3:300+1)), 'r');
title([vidName  ' NTSC'])
  saveas(fig, fullfile(resultsDir,[vidName '-spectrum.png']));
  
fig=plot([2:300]/length(dataFf)*25, abs(dataFf(3:300+1)), 'r');
title([vidName  ' NTSCF'])
  saveas(fig, fullfile(resultsDir,[vidName '-spectrumF.png']));

save(fullfile(resultsDir,[vidName 'Gdown_stack.mat']), 'Gdown_stack');
save(fullfile(resultsDir,[vidName 'NTSC_stack.mat']), 'NTSC_stack');
save(fullfile(resultsDir,[vidName 'F_stack.mat']), 'F_stack');
save(fullfile(resultsDir,[vidName 'NTSCF_stack.mat']), 'NTSCF_stack');

%graphs
fig=plot(squeeze(Gdown_stack(:,:,:,1)));
title([vidName  ' channel 1 graph'])
 saveas(fig, fullfile(resultsDir,[vidName '-graph1.png']));

 fig=plot(squeeze(F_stack(:,:,:,1)));
title([vidName  ' channel 1F graph'])
 saveas(fig, fullfile(resultsDir,[vidName '-graph1F.png']));
 
% fig=plot(squeeze(Gdown_stack(:,:,:,2)));
% title([StackName  ' channel 2 graph'])
%  saveas(fig, fullfile(resultsDir,[StackName '-graph2.png']));
%  
%  fig=plot(squeeze(Gdown_stack(:,:,:,1)));
% title([StackName  ' channel 3 graph'])
%  saveas(fig, fullfile(resultsDir,[StackName '-graph3.png']));

 fig=plot(squeeze(NTSC_stack(:,1)));
title([vidName  ' NTSC graph'])
 saveas(fig, fullfile(resultsDir,[vidName '-NTSCgraph.png']));
 fig=plot(squeeze(NTSCF_stack(:,1)));
title([vidName  ' NTSCF graph'])
 saveas(fig, fullfile(resultsDir,[vidName '-NTSCFgraph.png']));
 
end;
