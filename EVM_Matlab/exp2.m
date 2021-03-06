function exp2
    %vidFile = 'F:\SPBSU\Masters\EVM_Matlab\data\warped.avi';
    vidFile = 'c:\ResearchProjects\pulse_data\3780_cut1.mp4';

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
    rgbframe = im2double(rgbframe);
    intervalx = [100:600];
    intervaly = [350:850];
    rgbframe = rgbframe(intervalx, intervaly, 1:3);
    rgbframe = rgb2gray(rgbframe);
    
    % set optical flow parameters (see Coarse2FineTwoFrames.m for the definition of the parameters)
    alpha = 0.012;
    ratio = 0.75;
    minWidth = 20;
    nOuterFPIterations = 7;
    nInnerFPIterations = 1;
    nSORIterations = 30;

    para = [alpha,ratio,minWidth,nOuterFPIterations,nInnerFPIterations,nSORIterations];
    
    outName = 'warped_mar.avi';
    
    vidOut = VideoWriter(outName);
    vidOut.FrameRate = fr;

    open(vidOut);

    
    
    for i = 1:len
        temp.cdata = read(vid, i);
        [rgbframe2, ~] = frame2im(temp);
        rgbframe2 = im2double(rgbframe2);
        rgbframe2 = rgbframe2(intervalx, intervaly, 1:3);
        rgbframe2gr = rgb2gray(rgbframe2);
        [vx,vy,warpI2] = Coarse2FineTwoFrames(rgbframe,rgbframe2gr,para);
        sz = size(rgbframe);
        [y x] = ndgrid( 1:sz(1), 1:sz(2) );
        timg2(:, :, 1) = interp2( x, y, rgbframe2(:, :, 1), x + vx, y + vy );
        timg2(:, :, 2) = interp2( x, y, rgbframe2(:, :, 2), x + vx, y + vy );
        timg2(:, :, 3) = interp2( x, y, rgbframe2(:, :, 3), x + vx, y + vy );
        norm(vx)
        writeVideo(vidOut,im2uint8(timg2));
    end
    
    close(vidOut);
    
end