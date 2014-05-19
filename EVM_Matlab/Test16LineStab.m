%stabilize 16 line videos
dataDir = 'E:\Grad School\Master''s\CanonVideos\16 line test\cuts\K';

list=dir ('E:\Grad School\Master''s\CanonVideos\16 line test\cuts\K\*.mp4');


resultsDir='./output/16/stab';
mkdir(resultsDir);

%????? they have to be switched around
intervalx = [150:850];
%intervaly = [70:750];
intervaly = [70:700];

%failed earlier
for iterator =7:numel(list)
    tic
disp (list(iterator).name);

vidFile=fullfile(dataDir, list(iterator).name);
[~,vidName] = fileparts(vidFile);
outName=fullfile(resultsDir, [vidName '_stab.mp4']);


stabilize(vidFile, intervalx, intervaly, outName);
toc
end;