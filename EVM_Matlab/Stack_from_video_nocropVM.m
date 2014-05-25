%function to save a video as a stack
function Stack=Stack_from_video_nocropVM(vidFile)


fprintf('Processing %s\n', vidFile);


[~,vidName] = fileparts(vidFile);

    % Read video
vid = VideoReader(vidFile);
%for VM only
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

    % create  stack
    %only for 65x65 videos!
    Stack = zeros(endIndex - startIndex +1, size(frame,1), size(frame,2), size(frame,3));
  
    Stack(1,:,:,:) = frame(:, :, :);

    k = 1
    for j=startIndex+1:endIndex
            k = k+1
            temp.cdata = read(vid, j);
            [rgbframe,~] = frame2im(temp);

            rgbframe = im2double(rgbframe);
%    frame = rgb2ntsc(rgbframe);
% No need for this on Canon 650D videos.
frame=rgbframe;

            Stack(k,:,:,:) = frame(:, :, :);
    end;
    disp(['Stack for ' vidName ' has been built.'])




end
