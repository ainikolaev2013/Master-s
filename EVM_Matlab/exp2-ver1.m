function exp2
    vidFile = 'F:\SPBSU\Masters\EVM_Matlab\data\MVI_3779.mov';

    % Read video
    vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
    
    vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

    % firstFrame
    temp.cdata = read(vid, 1);
    [rgbframe, ~] = frame2im(temp);
    rgbframe = im2double(rgb2gray(rgbframe));
    
    % set optical flow parameters (see Coarse2FineTwoFrames.m for the definition of the parameters)
    alpha = 0.012;
    ratio = 0.75;
    minWidth = 20;
    nOuterFPIterations = 7;
    nInnerFPIterations = 1;
    nSORIterations = 30;

    para = [alpha,ratio,minWidth,nOuterFPIterations,nInnerFPIterations,nSORIterations];
%where to write the output    
    outName = '.\output\warped_MVI_3779.avi';
    
    vidOut = VideoWriter(outName);
    vidOut.FrameRate = fr;

    open(vidOut);

    
     for i = 100:125 
  %  for i = 100:len
        %cut out the first few seconds
        temp.cdata = read(vid, i);
        [rgbframe2, ~] = frame2im(temp);
        rgbframe2 = im2double(rgb2gray(rgbframe2));
        [vx,vy,warpI2] = Coarse2FineTwoFrames(rgbframe,rgbframe2,para);
        norm(vx)
        writeVideo(vidOut,im2uint8(warpI2));
    end
    
    close(vidOut);
    
end