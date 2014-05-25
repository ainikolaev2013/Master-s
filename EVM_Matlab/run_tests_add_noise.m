%make noise and run tests
%this is needed due to the fact that the noisy files are very very large
%A file is taken, then a noisy version of it is produced.
%The noisy version is analyzed and then deleted

tic

dataDir = './data/face';
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
load(StackFile, 'Stack');
Stack_intact=Stack;
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
tempdir=strcat(dataDir, '/', Record(1), Record(2), Record(3), Record(4));

mkdir (tempdir{1});

for sigma =  0.001:0.004:0.013
%sigma
noisy_stack=add_noise(Stack_intact, sigma);
Stack=noisy_stack;


save_loc_cell=fullfile(tempdir, strcat(Record(1), '_', Record(2), '_', Record(3), '_', strrep(num2str(sigma),'.',''), '.mat'));
save_loc=save_loc_cell{1}

save(save_loc, 'Stack');

Overall_run=run_test(save_loc, runID, globalresultsDir, Overall_run)
delete(save_loc)
end;

for sigma =  0.001:0.050:2.051
%sigma
noisy_stack=add_noise(Stack_intact, sigma);
Stack=noisy_stack;


save_loc_cell=fullfile(tempdir, strcat(Record(1), '_', Record(2), '_', Record(3), '_', strrep(num2str(sigma),'.',''), '.mat'));
save_loc=save_loc_cell{1}

save(save_loc, 'Stack');

Overall_run=run_test(save_loc, runID, globalresultsDir, Overall_run)
delete(save_loc)
end;
  
for sigma =  0.002:0.011:0.221
%sigma
noisy_stack=add_noise(Stack_intact, sigma);
Stack=noisy_stack;


save_loc_cell=fullfile(tempdir, strcat(Record(1), '_', Record(2), '_', Record(3), '_', strrep(num2str(sigma),'.',''), '.mat'));
save_loc=save_loc_cell{1}

save(save_loc, 'Stack');

Overall_run=run_test(save_loc, runID, globalresultsDir, Overall_run)
delete(save_loc)
end;

rmdir (tempdir{1});
end;
toc