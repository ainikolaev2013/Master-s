%hand test videos creation of cut out stacks
dataDir = 'E:\Grad School\Master''s\CanonVideos\20140514Hand\cuts';

list=dir ([dataDir '\*.mp4']);

resultsDir='./output/hand';



% file='MVI_6351cut';
% filename=[file '.mp4']
% x0=400;
% y0=125;
% width=255;
% height=255;
% cropwindow = [x0 y0 width height];
% vidFile = fullfile(dataDir, filename);
% Stack=Stack_from_video(vidFile, cropwindow);
% save(fullfile(resultsDir,[file '_1_noise0_256.mat']), 'Stack', '-v7.3');
% clear('Stack');
% 
% x0=900;
% y0=300;
% width=255;
% height=255;
% cropwindow = [x0 y0 width height];
% vidFile = fullfile(dataDir, filename);
% Stack=Stack_from_video(vidFile, cropwindow);
% save(fullfile(resultsDir,[file '_2_noise0_256.mat']), 'Stack', '-v7.3');
% clear('Stack');


file='MVI_6353cut';
filename=[file '.mp4']
x0=250;
y0=120;
width=255;
height=255;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '_1_noise0_256.mat']), 'Stack', '-v7.3');
clear('Stack');

x0=310;
y0=250;
width=255;
height=255;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '_2_noise0_256.mat']), 'Stack', '-v7.3');
clear('Stack');

file='MVI_6355cut';
filename=[file '.mp4']
x0=250;
y0=120;
width=255;
height=255;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '_1_noise0_256.mat']), 'Stack', '-v7.3');
clear('Stack');

x0=400;
y0=150;
width=255;
height=255;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '_2_noise0_256.mat']), 'Stack', '-v7.3');


file='MVI_6356cut';
filename=[file '.mp4']
x0=100;
y0=300;
width=255;
height=255;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '_1_noise0_256.mat']), 'Stack', '-v7.3');
clear('Stack');

x0=345;
y0=225;
width=255;
height=255;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '_2_noise0_256.mat']), 'Stack', '-v7.3');

file='MVI_6357cut';
filename=[file '.mp4']
x0=350;
y0=130;
width=255;
height=255;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '_1_noise0_256.mat']), 'Stack', '-v7.3');
clear('Stack');

x0=235;
y0=325;
width=255;
height=255;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '_2_noise0_256.mat']), 'Stack', '-v7.3');