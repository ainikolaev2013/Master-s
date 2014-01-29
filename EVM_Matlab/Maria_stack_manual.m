%dataDir = 'E:\Grad School\Master''s\CanonVideos\Maria';
dataDir = 'C:\Users\admin\Desktop\Google Drive\Grad School\Master''s\CanonVideos\Maria\';
resultsDir = 'output';

filename = {'3780_cut1_stab'};

for i=1:numel(filename) 
%forehead
x0=175;
y0=120;
width=50;
height=50;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x0 y0 width height];
[~,vidName] = fileparts(vidFile);

    % Read video
    vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
    temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

    startIndex(i) = 1;
    endIndex(i) = len;

    temp.cdata = read(vid, startIndex(i));
    [rgbframe, ~] = frame2im(temp);
    rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

    % compute  stack
    disp(['Building stack for ' filename{i}])

    cropped = imcrop(frame,cropwindow);
    % create  stack
    Stack = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

            cropped = imcrop(frame,cropwindow);
            Stack(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} 'forehead_stack.mat']), 'Stack');
end;

%filename = {'3780_cut1_stab'};

for i=1:numel(filename) 
%right cheek
x0=120;
y0=260;
width=50;
height=50;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x0 y0 width height];
[~,vidName] = fileparts(vidFile);

    % Read video
    vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
    temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

    startIndex(i) = 1;
    endIndex(i) = len;

    temp.cdata = read(vid, startIndex(i));
    [rgbframe, ~] = frame2im(temp);
    rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

    % compute  stack
    disp(['Building stack for ' filename{i}])

    cropped = imcrop(frame,cropwindow);
    % create  stack
    Stack = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;
            cropped = imcrop(frame,cropwindow);
            Stack(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} 'leftcheek_stack.mat']), 'Stack');
end;

%filename = {'3780_cut1_stab'};

for i=1:numel(filename) 
%left cheek
x0=255;
y0=255;
width=50;
height=50;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x0 y0 width height];
[~,vidName] = fileparts(vidFile);

    % Read video
    vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
    temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

    startIndex(i) = 1;
    endIndex(i) = len;

    temp.cdata = read(vid, startIndex(i));
    [rgbframe, ~] = frame2im(temp);
    rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

    % compute  stack
    disp(['Building stack for ' filename{i}])

    cropped = imcrop(frame,cropwindow);
    % create  stack
    Stack = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

            cropped = imcrop(frame,cropwindow);
            Stack(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} 'rightcheek_stack.mat']), 'Stack');
end;


filename = {'3780_cut3_stab'};

for i=1:numel(filename) 
%forehead
x0=225;
y0=155;
width=50;
height=50;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x0 y0 width height];
[~,vidName] = fileparts(vidFile);

    % Read video
    vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
    temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

    startIndex(i) = 1;
    endIndex(i) = len;

    temp.cdata = read(vid, startIndex(i));
    [rgbframe, ~] = frame2im(temp);
    rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

    % compute  stack
    disp(['Building stack for ' filename{i}])

    cropped = imcrop(frame,cropwindow);
    % create  stack
    Stack = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;
            cropped = imcrop(frame,cropwindow);
            Stack(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} 'forehead_stack.mat']), 'Stack');
end;

for i=1:numel(filename) 
%right cheek
x0=175;
y0=300;
width=50;
height=50;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x0 y0 width height];
[~,vidName] = fileparts(vidFile);

    % Read video
    vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
    temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

    startIndex(i) = 1;
    endIndex(i) = len;

    temp.cdata = read(vid, startIndex(i));
    [rgbframe, ~] = frame2im(temp);
    rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

    % compute  stack
    disp(['Building stack for ' filename{i}])

    cropped = imcrop(frame,cropwindow);
    % create  stack
    Stack = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
            %    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;
            cropped = imcrop(frame,cropwindow);
            Stack(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} 'leftcheek_stack.mat']), 'Stack');
end;

for i=1:numel(filename) 
%left cheek
x0=305;
y0=285;
width=50;
height=50;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x0 y0 width height];
[~,vidName] = fileparts(vidFile);

    % Read video
    vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
    temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

    startIndex(i) = 1;
    endIndex(i) = len;

    temp.cdata = read(vid, startIndex(i));
    [rgbframe, ~] = frame2im(temp);
    rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

    % compute  stack
    disp(['Building stack for ' filename{i}])

    cropped = imcrop(frame,cropwindow);
    % create  stack
    Stack = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
            %    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;
            cropped = imcrop(frame,cropwindow);
            Stack(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} 'rightcheek_stack.mat']), 'Stack');
end;

filename = {'3780_cut2_stab2'};

for i=1:numel(filename) 
%forehead
x0=240;
y0=150;
width=50;
height=50;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x0 y0 width height];
[~,vidName] = fileparts(vidFile);

    % Read video
    vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
    temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

    startIndex(i) = 1;
    endIndex(i) = len;

    temp.cdata = read(vid, startIndex(i));
    [rgbframe, ~] = frame2im(temp);
    rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

    % compute  stack
    disp(['Building stack for ' filename{i}])

    cropped = imcrop(frame,cropwindow);
    % create  stack
    Stack = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;
            cropped = imcrop(frame,cropwindow);
            Stack(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} 'forehead_stack.mat']), 'Stack');
end;

for i=1:numel(filename) 
%right cheek
x0=175;
y0=295;
width=50;
height=50;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x0 y0 width height];
[~,vidName] = fileparts(vidFile);

    % Read video
    vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
    temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

    startIndex(i) = 1;
    endIndex(i) = len;

    temp.cdata = read(vid, startIndex(i));
    [rgbframe, ~] = frame2im(temp);
    rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

    % compute  stack
    disp(['Building stack for ' filename{i}])

    cropped = imcrop(frame,cropwindow);
    % create  stack
    Stack = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
            %    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;
            cropped = imcrop(frame,cropwindow);
            Stack(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} 'leftcheek_stack.mat']), 'Stack');
end;

for i=1:numel(filename) 
%left cheek
x0=310;
y0=290;
width=50;
height=50;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x0 y0 width height];
[~,vidName] = fileparts(vidFile);

    % Read video
    vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
    temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

    startIndex(i) = 1;
    endIndex(i) = len;

    temp.cdata = read(vid, startIndex(i));
    [rgbframe, ~] = frame2im(temp);
    rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

    % compute  stack
    disp(['Building stack for ' filename{i}])

    cropped = imcrop(frame,cropwindow);
    % create  stack
    Stack = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
            %    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;
            cropped = imcrop(frame,cropwindow);
            Stack(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} 'rightcheek_stack.mat']), 'Stack');
end;



disp('Stacks have been built.')

    




