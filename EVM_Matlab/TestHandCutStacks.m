%16 line test videos creation of cut out stacks
%Only Krechmar videos are taken as they are more stable
dataDir = 'E:\Grad School\Master''s\CanonVideos\20140514Hand\cuts';

list=dir ([dataDir '\*.mp4']);

resultsDir='./output/hand';



file='MVI_6351cut';
filename=[file '.mp4']
x0=400;
y0=125;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '6351_1_noise0.mat']), 'Stack');
clear('Stack');

x0=900;
y0=300;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '6351_2_noise0.mat']), 'Stack');
clear('Stack');


file='MVI_6353cut';
filename=[file '.mp4']
x0=250;
y0=120;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '6353_1_noise0.mat']), 'Stack');
clear('Stack');

x0=310;
y0=250;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '6353_2_noise0.mat']), 'Stack');
clear('Stack');

file='MVI_6355cut';
filename=[file '.mp4']
x0=250;
y0=120;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '6355_1_noise0.mat']), 'Stack');
clear('Stack');

x0=400;
y0=150;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '6355_2_noise0.mat']), 'Stack');


file='MVI_6356cut';
filename=[file '.mp4']
x0=100;
y0=300;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '6356_1_noise0.mat']), 'Stack');
clear('Stack');

x0=345;
y0=225;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '6356_2_noise0.mat']), 'Stack');

file='MVI_6357cut';
filename=[file '.mp4']
x0=350;
y0=130;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '6357_1_noise0.mat']), 'Stack');
clear('Stack');

x0=235;
y0=325;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file '6357_2_noise0.mat']), 'Stack');