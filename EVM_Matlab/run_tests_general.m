%Run various filters
%The input is expected to be a 64x64 stack of video
tic

dataDir = './data/face';
list=dir([dataDir '\*.mat']);

globalresultsDir='./Results';

%useful to make sense of what was run when
runID=datestr(now, 'yyyymmddHHMM');


Overall_run=[];


%5Hz filtration
for iterator =1:numel(list)
Results_run=[];
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
fh=80/60;
%OMP K_target value
K_target=5;
%determines saving location
record_type='face';
elseif strcmp(Record(1),'6351') && strcmp(Record(2),'cut1')
K= 0.007;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=7;
record_type='hand';
elseif strcmp(Record(1),'6351') && strcmp(Record(2),'cut2')
K= 0.007;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=7;
record_type='hand';
elseif strcmp(Record(1),'6353') && strcmp(Record(2),'cut1')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=40;
record_type='hand';
elseif strcmp(Record(1),'6353') && strcmp(Record(2),'cut2')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=40;
record_type='hand';
elseif strcmp(Record(1),'6355') && strcmp(Record(2),'cut1')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=9;
record_type='hand';
elseif strcmp(Record(1),'6355') && strcmp(Record(2),'cut2')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=9;
record_type='hand';
elseif strcmp(Record(1),'6356') && strcmp(Record(2),'cut1')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=9;
record_type='hand';
elseif strcmp(Record(1),'6356') && strcmp(Record(2),'cut2')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=9;
record_type='hand';
elseif strcmp(Record(1),'6357') && strcmp(Record(2),'cut1')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=13;
record_type='hand';
elseif strcmp(Record(1),'6357') && strcmp(Record(2),'cut2')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=13;
record_type='hand';
else
K= 0.006;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=5;
record_type='hand';
end

%create the 1x1 stack
level=4;  %64x64 input stacks!
disp('Spacial filtering...')
Stack1x1 = build_GDown_stack_stack4(StackFile, level);
Stack1x1 = ideal_bandpassing(Stack1x1, 1, 30/60, 300/60, samplingRate);

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

for K = 0.001:0.0005:0.030

dct_stack=dct_filt(Stack1, K);
disp('DCT filtering done.');

dct_result=length(findpeaks(dct_stack));
Results_run=[Results_run; runID  Record(1) Record(3) Record(4) 'DCT 5Hz' num2str(K) dct_result];

end

disp('DCT finished.');
%TO DO save the results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MIT algorithm
for low = 30:10:50
    for high = 70:10:100
disp('MIT algorithm...');

fl=low/60;
fh=high/60;
disp('Temporal filtering...')
MIT_stack = ideal_bandpassing(Stack1, 1, fl, fh, samplingRate);
disp('Temporal filtering done.')

MIT_result=length(findpeaks(MIT_stack));
Results_run=[Results_run; runID  Record(1) Record(3) Record(4) 'MIT 5Hz' strcat(num2str(fl*60), '-', num2str(fh*60)) MIT_result];
disp('MIT finished.');
    end
end


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


JADE_result=length(findpeaks(JADE_stack));
Results_run=[Results_run; runID  Record(1) Record(3) Record(4) 'JADE 5Hz' 'n/a' JADE_result];
disp('JADE finished.');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OMP algorithm
disp('OMP...');

disp('OMP filtering...');

for K_target = 1:40

OMP_stack=filter_sparse_noiterator(Stack1, K_target);
disp('OMP filtering done.');

OMP_result=length(findpeaks(OMP_stack));
Results_run=[Results_run; runID  Record(1) Record(3) Record(4) 'OMP 5Hz' num2str(K_target) OMP_result];
end


disp('OMP finished.');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



load(fullfile(globalresultsDir,['Results.mat']), 'Results_save')

%run results saving location determination
 

resultsDir=strcat('./output/', record_type, '/results');

save_loc_cell=fullfile(resultsDir, strcat(runID, Record(1), '_', Record(3), '_', Record(4), '_Results.mat'));
save_loc=save_loc_cell{1}

%save(fullfile(resultsDir,[runID 'Results.mat']), 'Results_run');
save(save_loc, 'Results_run');


Results_save=[Results_save; Results_run];
save(fullfile(globalresultsDir,['Results.mat']), 'Results_save');


Overall_run= [Overall_run; Results_run]
%Results_save
%Results_run
clear('Stack');
clear('Stack1');
clear('Record');
clear('Results_save');
clear('Results_run');

end;

%NO 5Hz filtration
for iterator =1:numel(list)
Results_run=[];
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
fh=80/60;
%OMP K_target value
K_target=5;
%determines saving location
record_type='face';
elseif strcmp(Record(1),'6351') && strcmp(Record(2),'cut1')
K= 0.007;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=7;
record_type='hand';
elseif strcmp(Record(1),'6351') && strcmp(Record(2),'cut2')
K= 0.007;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=7;
record_type='hand';
elseif strcmp(Record(1),'6353') && strcmp(Record(2),'cut1')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=40;
record_type='hand';
elseif strcmp(Record(1),'6353') && strcmp(Record(2),'cut2')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=40;
record_type='hand';
elseif strcmp(Record(1),'6355') && strcmp(Record(2),'cut1')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=9;
record_type='hand';
elseif strcmp(Record(1),'6355') && strcmp(Record(2),'cut2')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=9;
record_type='hand';
elseif strcmp(Record(1),'6356') && strcmp(Record(2),'cut1')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=9;
record_type='hand';
elseif strcmp(Record(1),'6356') && strcmp(Record(2),'cut2')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=9;
record_type='hand';
elseif strcmp(Record(1),'6357') && strcmp(Record(2),'cut1')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=13;
record_type='hand';
elseif strcmp(Record(1),'6357') && strcmp(Record(2),'cut2')
K= 0.015;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=13;
record_type='hand';
else
K= 0.006;
samplingRate=25;
fl=40/60;
fh=80/60;
K_target=5;
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

for K = 0.001:0.0005:0.030

dct_stack=dct_filt(Stack1, K);
disp('DCT filtering done.');

dct_result=length(findpeaks(dct_stack));
Results_run=[Results_run; runID  Record(1) Record(3) Record(4) 'DCT' num2str(K) dct_result];

end

disp('DCT finished.');
%TO DO save the results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MIT algorithm
for low = 30:10:50
    for high = 70:10:100
disp('MIT algorithm...');

fl=low/60;
fh=high/60;
disp('Temporal filtering...')
MIT_stack = ideal_bandpassing(Stack1, 1, fl, fh, samplingRate);
disp('Temporal filtering done.')

MIT_result=length(findpeaks(MIT_stack));
Results_run=[Results_run; runID  Record(1) Record(3) Record(4) 'MIT' strcat(num2str(fl*60), '-', num2str(fh*60)) MIT_result];
disp('MIT finished.');
    end
end


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


JADE_result=length(findpeaks(JADE_stack));
Results_run=[Results_run; runID  Record(1) Record(3) Record(4) 'JADE' 'n/a' JADE_result];
disp('JADE finished.');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OMP algorithm
disp('OMP...');

disp('OMP filtering...');

for K_target = 1:40

OMP_stack=filter_sparse_noiterator(Stack1, K_target);
disp('OMP filtering done.');

OMP_result=length(findpeaks(OMP_stack));
Results_run=[Results_run; runID  Record(1) Record(3) Record(4) 'OMP' num2str(K_target) OMP_result];
end


disp('OMP finished.');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



load(fullfile(globalresultsDir,['Results.mat']), 'Results_save')

%run results saving location determination
 

resultsDir=strcat('./output/', record_type, '/results');

save_loc_cell=fullfile(resultsDir, strcat(runID, Record(1), '_', Record(3), '_', Record(4), '_Results.mat'));
save_loc=save_loc_cell{1}

%save(fullfile(resultsDir,[runID 'Results.mat']), 'Results_run');
save(save_loc, 'Results_run');


Results_save=[Results_save; Results_run];
save(fullfile(globalresultsDir,['Results.mat']), 'Results_save');


Overall_run= [Overall_run; Results_run]
%Results_save
%Results_run
clear('Stack');
clear('Stack1');
clear('Record');
clear('Results_save');
clear('Results_run');

end;
toc