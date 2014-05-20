%16 line test videos creation of cut out stacks
%Only Krechmar videos are taken as they are more stable
dataDir = 'E:\Grad School\Master''s\CanonVideos\20140514Hand\cuts';

list=dir ([dataDir '\*.mp4']);

resultsDir='./output/hand/stab';



file='MVI_6351cut';
filename=[file '.mp4']
x0=400;
y0=125;
width=63;
height=63;

lu = ([y0; x0]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);


x0=900;
y0=300;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab2.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);



file='MVI_6353cut';
filename=[file '.mp4']
x0=250;
y0=120;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

x0=310;
y0=250;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab2.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

file='MVI_6355cut';
filename=[file '.mp4']
x0=250;
y0=120;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

x0=400;
y0=150;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab2.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

file='MVI_6356cut';
filename=[file '.mp4']
x0=100;
y0=300;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

x0=345;
y0=225;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab2.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

file='MVI_6357cut';
filename=[file '.mp4']
x0=350;
y0=130;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

x0=235;
y0=325;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab2.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

file='MVI_6357cut1';
filename=[file '.mp4']
x0=350;
y0=130;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

x0=235;
y0=325;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab2.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

file='MVI_6357cut2';
filename=[file '.mp4']
x0=350;
y0=130;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

x0=235;
y0=325;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab2.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

file='MVI_6357cut3';
filename=[file '.mp4']
x0=350;
y0=130;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab1.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);

x0=235;
y0=325;
width=63;
height=63;
lu = ([y0; x0] - [1; 1]);
rd = ([y0+height; x0+width] + [1; 1]);
vidFile = fullfile(dataDir, filename);
outName = fullfile(resultsDir, [file 'stab2.avi']);
stabilize_region_ain(vidFile, lu, rd, outName);