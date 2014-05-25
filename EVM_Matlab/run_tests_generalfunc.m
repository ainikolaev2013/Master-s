%Run various filters
%The input is expected to be a 64x64 stack of video
tic

dataDir = './data/face';
list=dir([dataDir '\*.mat']);

globalresultsDir='./Results';

%useful to make sense of what was run when
runID=datestr(now, 'yyyymmddHHMM');


Overall_run=[];


%5Hz filtration added
for iterator =1:numel(list)
Results_run=[];
disp (list(iterator).name);


StackFile=fullfile(dataDir, list(iterator).name);
StackFile;
Overall_run=run_test(StackFile, runID, globalresultsDir, Overall_run);
end;

toc