%Run various filters
%The input is expected to be a 64x64 stack of video


dataDir = 'F:\SPBSU\Masters\EVM_Matlab\data\16';
list=dir([dataDir '\*.mat']);
resultsDir='./output/16';

%useful to make sense of what was run when
runID=datestr(now, 'yyyymmddHHMM');


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
Stack1 = build_GDown_stack_stack4(StackFile, level);
disp('Finished filtering...')

%have the 64x64 stack at hand
load(StackFile, 'Stack');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Our algorithm
dct_stack=dct_filt(squeeze(Stack1(:,:,:,1)));
dct_result=length(findpeaks(dct_stack))


clear('Stack');
clear('Stack1');
clear('Record');
end;