%make Gdown_stacks of the 16th line files


dataDir = 'E:\Grad School\Master''s\CanonVideos\16 line test\cuts\I';

list=dir ('E:\Grad School\Master''s\CanonVideos\16 line test\cuts\I\*.mp4');

resultsDir='./output/16';

level=4;


for iterator =1:numel(list)
disp (list(iterator).name);

vidFile=fullfile(dataDir, list(iterator).name);
vidFile;
[~,vidName] = fileparts(vidFile);
 vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
      startIndex = 1;
    endIndex = len-10;
    

   
   
%    Gdown_stack=1;
    
    disp('Spacial filtering...')
    Gdown_stack = build_GDown_stack_canon(vidFile, startIndex, endIndex, level);
    disp('Finished')


save(fullfile(resultsDir,['Gdown_stack_' vidName '.mat']), 'Gdown_stack');



end;

dataDir = 'E:\Grad School\Master''s\CanonVideos\16 line test\cuts\K';

list=dir ('E:\Grad School\Master''s\CanonVideos\16 line test\cuts\K\*.mp4');

for iterator =1:numel(list)
disp (list(iterator).name);

vidFile=fullfile(dataDir, list(iterator).name);
vidFile;
[~,vidName] = fileparts(vidFile);
 vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
      startIndex = 1;
    endIndex = len-10;
    

   
   
%    Gdown_stack=1;
    
    disp('Spacial filtering...')
    Gdown_stack = build_GDown_stack_canon(vidFile, startIndex, endIndex, level);
    disp('Finished')


save(fullfile(resultsDir,['Gdown_stack_' vidName '.mat']), 'Gdown_stack');



end;