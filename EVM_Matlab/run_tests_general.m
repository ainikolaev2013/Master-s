%Run various filters
%The input is expected to be a 64x64 stack of video
tic

dataDir = './data/hand';
list=dir([dataDir '\*.mat']);

globalresultsDir='./Results';

%useful to make sense of what was run when
runID=datestr(now, 'yyyymmddHHMM');


Overall_run=[];


for iterator =1:numel(list)

disp (list(iterator).name);


StackFile=fullfile(dataDir, list(iterator).name);
StackFile;
[~,StackName] = fileparts(StackFile);

%parse the file name
Record=strsplit(StackName, '_');
%file name
Record(1);
%cut name
Record(2);
%stack number
Record(3);
%noise level
Record(4);


%setting parameters
if strcmp(Record(1),'face')
%DCT K parameter
K= 0.006;
%MIT parameters
samplingRate=30;
fl=40/60;
fh=70/60;
%OMP K_target value
K_target=5;
%determines saving location
record_type='face';
elseif strcmp(Record(1),'6351') && strcmp(Record(2),'cut1')
K= 0.005;
samplingRate=25;
fl=40/60;
fh=70/60;
K_target=10;
record_type='hand';
elseif strcmp(Record(1),'6351') && strcmp(Record(2),'cut2')
K= 0.005;
samplingRate=25;
fl=40/60;
fh=70/60;
K_target=10;
record_type='hand';
elseif strcmp(Record(1),'6353') && strcmp(Record(2),'cut1')
K= 0.005;
samplingRate=25;
fl=40/60;
fh=70/60;
K_target=10;
record_type='hand';
else
K= 0.005;
samplingRate=25;
fl=40/60;
fh=70/60;
K_target=10;
record_type='hand';
end

%create the 1x1 stack
level=4;  %64x64 input stacks!
disp('Spacial filtering...')
Stack1x1 = build_GDown_stack_stack4(StackFile, level);
disp('Finished filtering...')

%looking into the first channel
%this should actually be ntsc
%Stack1=squeeze(Stack1x1(:,:,:,1));
Stack1ntsc=rgb2ntsc(squeeze(Stack1x1));
Stack1=Stack1ntsc(:,1);


%have the 64x64 stack at hand
load(StackFile, 'Stack');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Our algorithm
disp('DCT algorithm...');

dct_stack=dct_filt(Stack1, K);
disp('DCT filtering done.');

dct_result=length(findpeaks(dct_stack))



disp('DCT finished.');
%TO DO save the results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MIT algorithm
disp('MIT algorithm...');

disp('Temporal filtering...')
MIT_stack = ideal_bandpassing(Stack1, 1, fl, fh, samplingRate);
disp('Temporal filtering done.')

MIT_result=length(findpeaks(MIT_stack))

disp('MIT finished.');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%JADE algorithm
%input data needs to be represented in a different fashion here
disp('JADE...');
disp('Normalization...');
%RGB is needed here 
normalized1x1=normalize_data(squeeze(Stack1x1));
disp('JADE filtering...');
JADE_stack=filter_jade(normalized1x1);
disp('JADE filtering done.');


JADE_result=length(findpeaks(JADE_stack))
disp('JADE finished.');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OMP algorithm
disp('OMP...');

disp('OMP filtering...');


OMP_stack=filter_sparse_noiterator(Stack1, K_target);
disp('OMP filtering done.');

OMP_result=length(findpeaks(OMP_stack))



disp('OMP finished.');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Results_save=[];
load(fullfile(globalresultsDir,['Results.mat']), 'Results_save')

Results_save=[Results_save; runID  Record(1) Record(3) Record(4) 'DCT' num2str(K) dct_result];
Results_save=[Results_save; runID  Record(1) Record(3) Record(4) 'MIT' 'n/a' MIT_result];
Results_save=[Results_save; runID  Record(1) Record(3) Record(4) 'JADE' 'n/a' JADE_result];
Results_save=[Results_save; runID  Record(1) Record(3) Record(4) 'OMP' num2str(K_target) OMP_result];


Results_run = [runID  Record(1) Record(3) Record(4) 'DCT' num2str(K) dct_result;
runID  Record(1) Record(3) Record(4) 'MIT' 'n/a' MIT_result;
runID  Record(1) Record(3) Record(4) 'JADE' 'n/a' JADE_result;
runID  Record(1) Record(3) Record(4) 'OMP' num2str(K_target) OMP_result];


%run results asving location determination
 

resultsDir=strcat('./output/', record_type, '/results');

save_loc_cell=fullfile(resultsDir, strcat(runID, Record(1), '_', Record(3), '_', Record(4), '_Results.mat'));
save_loc=save_loc_cell{1}

%save(fullfile(resultsDir,[runID 'Results.mat']), 'Results_run');

save(save_loc, 'Results_run');

save(fullfile(globalresultsDir,['Results.mat']), 'Results_save');


Overall_run= [Overall_run; Results_run];
%Results_save
Results_run;
clear('Stack');
clear('Stack1');
clear('Record');
clear('Results_save');
clear('Results_run');

end;


toc