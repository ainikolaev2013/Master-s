%Hand videos creation of stabilized videos

dataDir = 'E:\Grad School\Master''s\CanonVideos\20140514Hand\cuts';

list=dir ([dataDir '\*.mp4']);

resultsDir='./output/hand/stab';
%%%%%
%for 64x64
%width=61;
%height=61;
%%%%%


%%%%%
%for 32x32
%width=29;
%height=29;
%%%%%



file='MVI_6351cut';
filename=[file '.mp4']

x1=1240;
y1=300;
width=61;
height=61;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file '_64_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);
width=29;
height=29;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
outName = fullfile(resultsDir, [file '_32_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

x1=1300;
y1=615;
width=61;
height=61;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file '_64_stab2.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);
width=29;
height=29;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
outName = fullfile(resultsDir, [file '_32_stab2.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

x1=1185;
y1=845;
width=61;
height=61;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file '_64_stab3.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);
width=29;
height=29;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
outName = fullfile(resultsDir, [file '_32_stab3.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);


file='MVI_6353cut';
filename=[file '.mp4']
x1=785;
y1=255;
width=61;
height=61;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file '_64_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);
width=29;
height=29;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
outName = fullfile(resultsDir, [file '_32_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

file='MVI_6355cut';
filename=[file '.mp4']
x1=285;
y1=275;
width=61;
height=61;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file '_64_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);
x1=265;
y1=255;
width=29;
height=29;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
outName = fullfile(resultsDir, [file '_32_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);


file='MVI_6356cut';
filename=[file '.mp4']
x1=290;
y1=350;
width=61;
height=61;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file '_64_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);
x1=275;
y1=335;
width=29;
height=29;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
outName = fullfile(resultsDir, [file '_32_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

file='MVI_6357cut';
filename=[file '.mp4']
x1=420;
y1=122;
width=61;
height=61;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file '_64_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);
x1=420;
y1=154;
width=29;
height=29;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
outName = fullfile(resultsDir, [file '_32_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

file='MVI_6357cut1';
filename=[file '.mp4']
x1=420;
y1=122;
width=61;
height=61;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file '_64_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);
x1=420;
y1=154;
width=29;
height=29;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
outName = fullfile(resultsDir, [file '_32_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

file='MVI_6357cut2';
filename=[file '.mp4']
x1=420;
y1=122;
width=61;
height=61;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file '_64_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);
x1=420;
y1=154;
width=29;
height=29;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
outName = fullfile(resultsDir, [file '_32_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);


file='MVI_6357cut3';
filename=[file '.mp4']
x1=420;
y1=122;
width=61;
height=61;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file '_64_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);
x1=420;
y1=154;
width=29;
height=29;
x0=x1-width;
y0=y1-height;
lu = ([y0; x0] - [1; 1]);
rd = ([y1; x1] + [1; 1]);
outName = fullfile(resultsDir, [file '_32_stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);