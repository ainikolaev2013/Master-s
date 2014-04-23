%make Gdown_stacks of the 16th line files


dataDir = 'E:\Grad School\Master''s\CanonVideos\16 line test';

list=dir ('E:\Grad School\Master''s\CanonVideos\16 line test\*.MOV');

resultsDir='./output/16';

level=5;


for iterator =1:numel(list)
disp (list(iterator).name);

vidFile=fullfile(dataDir, list(iterator).name);
vidFile;

 vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
    
    
    startIndex = 1;
    endIndex = len-10;
    
    disp('Spatial filtering...')
    Gdown_stack = build_GDown_stack(vidFile, startIndex, endIndex, level);
    disp('Finished')


save(fullfile(resultsDir,['Blurred' vidFile]), 'Gdown_stack');



end;
