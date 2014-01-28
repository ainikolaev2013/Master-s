dataDir = 'E:\Grad School\Master''s\CanonVideos\Maria';
resultsDir = 'output';

filename = {'3780_cut1_stab'};

for i=1:numel(filename) 
%forehead
x_left=175;
x_right=120;
y_top=225;
y_bottom=170;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x_left x_right y_top y_bottom];
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
    Stack{i} = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack{i}(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
            frame = rgb2ntsc(rgbframe);

            cropped = imcrop(frame,cropwindow);
            Stack{i}(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} '_stack.mat']), 'Stack');
end;

%filename = {'3780_cut1_stab'};

for i=1:numel(filename) 
%right cheek
x_left=120;
x_right=260;
y_top=170;
y_bottom=310;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x_left x_right y_top y_bottom];
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
    Stack{i} = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack{i}(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
            frame = rgb2ntsc(rgbframe);

            cropped = imcrop(frame,cropwindow);
            Stack{i}(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} '_stack.mat']), 'Stack');
end;

%filename = {'3780_cut1_stab'};

for i=1:numel(filename) 
%left cheek
x_left=255;
x_right=255;
y_top=305;
y_bottom=305;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x_left x_right y_top y_bottom];
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
    Stack{i} = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack{i}(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
            frame = rgb2ntsc(rgbframe);

            cropped = imcrop(frame,cropwindow);
            Stack{i}(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} '_stack.mat']), 'Stack');
end;


filename = {'3780_cut3_stab'};

for i=1:numel(filename) 
%forehead
x_left=225;
x_right=155;
y_top=275;
y_bottom=205;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x_left x_right y_top y_bottom];
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
    Stack{i} = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack{i}(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
            frame = rgb2ntsc(rgbframe);

            cropped = imcrop(frame,cropwindow);
            Stack{i}(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} '_stack.mat']), 'Stack');
end;

for i=1:numel(filename) 
%right cheek
x_left=175;
x_right=300;
y_top=225;
y_bottom=350;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x_left x_right y_top y_bottom];
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
    Stack{i} = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack{i}(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
            frame = rgb2ntsc(rgbframe);

            cropped = imcrop(frame,cropwindow);
            Stack{i}(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} '_stack.mat']), 'Stack');
end;

for i=1:numel(filename) 
%left cheek
x_left=305;
x_right=285;
y_top=355;
y_bottom=335;
    
    inFile = fullfile(dataDir, [filename{i} '.avi']);

fprintf('Processing %s\n', inFile);

vidFile=inFile;

cropwindow = [x_left x_right y_top y_bottom];
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
    Stack{i} = zeros(endIndex(i) - startIndex(i) +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack{i}(1,:,:,:) = cropped;

    k = 1;
    for j=startIndex(i)+1:endIndex(i)
            k = k+1;
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
            frame = rgb2ntsc(rgbframe);

            cropped = imcrop(frame,cropwindow);
            Stack{i}(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' filename{i} ' has been built.'])
    save(fullfile(resultsDir,[filename{i} '_stack.mat']), 'Stack');
end;

disp('Stacks have been built.')

    




