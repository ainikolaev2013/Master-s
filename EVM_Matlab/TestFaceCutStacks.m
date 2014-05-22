%MIT Face Test
dataDir = './data/';

list=dir ([dataDir '\*.mp4']);

resultsDir='./output/face';



file='face';
filename=[file '.mp4']
x0=328;
y0=307;
width=63;
height=63;
%order reversed!
cropwindow = [y0 x0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack1_noise0.mat']), 'Stack');
clear('Stack');

x0=200;
y0=90;
width=63;
height=63;
%order reversed!
cropwindow = [y0 x0 width height];
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack2_noise0.mat']), 'Stack');
clear('Stack');

