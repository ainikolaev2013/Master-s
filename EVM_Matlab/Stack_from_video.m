%function to cut a rectangle out of a video and save it as a stack

function Stack=Stack_from_video(vidFile, cropwindow)


fprintf('Processing %s\n', vidFile);


[~,vidName] = fileparts(vidFile);

    % Read video
vid = VideoReader(vidFile);

%Only for Win Server 2008 till codecs are OK
lastFrame = read(vid, inf);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
    temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

    startIndex = 1;
    endIndex = len;

    temp.cdata = read(vid, startIndex);
    [rgbframe, ~] = frame2im(temp);
    rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

    % compute  stack
    disp(['Building stack for ' vidName])

    cropped = imcrop(frame,cropwindow);
    % create  stack
    Stack = zeros(endIndex - startIndex +1, size(cropped,1),size(cropped,2),size(cropped,3));
    Stack(1,:,:,:) = cropped;

    k = 1
    for j=startIndex+1:endIndex
            k = k+1
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

            cropped = imcrop(frame,cropwindow);
            Stack(k,:,:,:) = cropped;
    end;
    disp(['Stack for ' vidName ' has been built.'])




end
