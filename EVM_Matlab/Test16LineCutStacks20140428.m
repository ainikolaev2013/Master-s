%16 line test videos creation of cut out stacks
%Only Krechmar videos are taken as they are more stable
dataDir = 'E:\Grad School\Master''s\CanonVideos\16 line test\cuts\K';

list=dir ([dataDir '\*.mp4']);

resultsDir='./output/16';



file='MVI_5372cut';
filename=[file '.mp4']
x0=160;
y0=600;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack1.mat']), 'Stack');
clear('Stack');

x0=560;
y0=600;
width=63;
height=63;
cropwindow = [x0 y0 width height];
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack2.mat']), 'Stack');
clear('Stack');

file='MVI_5374cut';
filename=[file '.mp4']
x0=190;
y0=610;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack1.mat']), 'Stack');
clear('Stack');

x0=540;
y0=620;
width=63;
height=63;
cropwindow = [x0 y0 width height];
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack2.mat']), 'Stack');
clear('Stack');

file='MVI_5375cut';
filename=[file '.mp4']
x0=170;
y0=590;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack1.mat']), 'Stack');
clear('Stack');

x0=530;
y0=575;
width=63;
height=63;
cropwindow = [x0 y0 width height];
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack2.mat']), 'Stack');
clear('Stack');

file='MVI_5376cut';
filename=[file '.mp4']
x0=200;
y0=600;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack1.mat']), 'Stack');
clear('Stack');

x0=530;
y0=600;
width=63;
height=63;
cropwindow = [x0 y0 width height];
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack2.mat']), 'Stack');
clear('Stack');


file='MVI_5377cut';
filename=[file '.mp4']
x0=170;
y0=580;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack1.mat']), 'Stack');
clear('Stack');

x0=540;
y0=600;
width=63;
height=63;
cropwindow = [x0 y0 width height];
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack2.mat']), 'Stack');
clear('Stack');

file='MVI_5378cut';
filename=[file '.mp4']
x0=150;
y0=600;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack1.mat']), 'Stack');
clear('Stack');

x0=505;
y0=600;
width=63;
height=63;
cropwindow = [x0 y0 width height];
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack2.mat']), 'Stack');
clear('Stack');

file='MVI_5379cut';
filename=[file '.mp4']
x0=175;
y0=580;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack1.mat']), 'Stack');
clear('Stack');

x0=530;
y0=600;
width=63;
height=63;
cropwindow = [x0 y0 width height];
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack2.mat']), 'Stack');
clear('Stack');


file='MVI_5380cut';
filename=[file '.mp4']
x0=160;
y0=600;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack1.mat']), 'Stack');
clear('Stack');

x0=540;
y0=600;
width=63;
height=63;
cropwindow = [x0 y0 width height];
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack2.mat']), 'Stack');
clear('Stack');

file='MVI_5381cut';
filename=[file '.mp4']
x0=200;
y0=610;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack1.mat']), 'Stack');
clear('Stack');

x0=550;
y0=600;
width=63;
height=63;
cropwindow = [x0 y0 width height];
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack2.mat']), 'Stack');
clear('Stack');

file='MVI_5382cut';
filename=[file '.mp4']
x0=185;
y0=610;
width=63;
height=63;
cropwindow = [x0 y0 width height];
vidFile = fullfile(dataDir, filename);
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack1.mat']), 'Stack');
clear('Stack');

x0=540;
y0=610;
width=63;
height=63;
cropwindow = [x0 y0 width height];
Stack=Stack_from_video(vidFile, cropwindow);
save(fullfile(resultsDir,[file 'test_stack2.mat']), 'Stack');
clear('Stack');

