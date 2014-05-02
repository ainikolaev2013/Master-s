%Run various filters
%The input is expected to be a 64x64 stack of video
tic

dataDir = 'F:\SPBSU\Masters\EVM_Matlab\data\16';
list=dir([dataDir '\*.mat']);
resultsDir='./output/16';
globalresultsDir='./Results';

%useful to make sense of what was run when
runID=datestr(now, 'yyyymmddHHMM');

Results_save=[];

for iterator =1:numel(list)
disp (list(iterator).name);

StackFile=fullfile(dataDir, list(iterator).name);
StackFile;
[~,StackName] = fileparts(StackFile);

%parse the file name
Record=strsplit(StackName, '_');
%file name
Record(2);
%stack number
Record(3);
%noise level
Record(4);

%create the 1x1 stack
level=4;  %64x64 input stacks!
disp('Spacial filtering...')
Stack1x1 = build_GDown_stack_stack4(StackFile, level);
disp('Finished filtering...')

%looking into the first channel
Stack1=squeeze(Stack1x1(:,:,:,1));

%have the 64x64 stack at hand
load(StackFile, 'Stack');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Our algorithm
disp('DCT algorithm...');
dct_stack=dct_filt(Stack1);
disp('DCT filtering done.');

dct_result=length(findpeaks(dct_stack))

Results_save=[Results_save; runID  Record(2) Record(3) Record(4) 'DCT' dct_result]


disp('DCT finished.');
%TO DO save the results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MIT algorithm
disp('MIT algorithm...');
samplingRate=25;

%TO DO find out appropriate values, refer to ReproduceResults for examples
fl=40/60;
fh=70/60;
disp('Temporal filtering...')
MIT_stack = ideal_bandpassing(Stack1, 1, fl, fh, samplingRate);
disp('Temporal filtering done.')

MIT_result=length(findpeaks(MIT_stack))
Results_save=[Results_save; runID  Record(2) Record(3) Record(4) 'MIT' MIT_result]

disp('MIT finished.');

%TO DO save the results

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%JADE algorithm
%input data needs to be represented in a different fashion here
disp('JADE...');
disp('Normalization...');
normalized1x1=normalize_data(squeeze(Stack1x1));
disp('JADE filtering...');
JADE_stack=filter_jade(normalized1x1);
disp('JADE filtering done.');


JADE_result=length(findpeaks(JADE_stack))

Results_save=[Results_save; runID  Record(2) Record(3) Record(4) 'JADE' JADE_result]

disp('JADE finished.');

%TO DO save the results

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OMP algorithm
disp('OMP...');

disp('OMP filtering...');

%TO DO find out some real value
K_target=20;
OMP_stack=filter_sparse_noiterator(Stack1, K_target);
disp('OMP filtering done.');

OMP_result=length(findpeaks(OMP_stack))

Results_save=[Results_save; runID  Record(2) Record(3) Record(4) 'OMP' OMP_result]


disp('OMP finished.');
%TO DO save the results

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear('Stack');
clear('Stack1');
clear('Record');

%save(fullfile(resultsDir,[runID 'Results.mat']), 'Results_save');
%save(fullfile(globalresultsDir,['Results' runID '.mat']), 'Results_save');
%TO DO proper results saving

Results_save
clear('Stack');
clear('Stack1');
clear('Record');
clear('Results_save');

end;


toc