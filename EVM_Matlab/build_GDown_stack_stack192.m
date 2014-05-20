% GDOWN_STACK = build_GDown_stack(VID_FILE, START_INDEX, END_INDEX, LEVEL)
% 
% Apply Gaussian pyramid decomposition on VID_FILE from START_INDEX to
% END_INDEX and select a specific band indicated by LEVEL
% 
% GDOWN_STACK: stack of one band of Gaussian pyramid of each frame 
% the first dimension is the time axis
% the second dimension is the y axis of the video
% the third dimension is the x axis of the video
% the forth dimension is the color channel
% 
% Copyright (c) 2011-2012 Massachusetts Institute of Technology, 
% Quanta Research Cambridge, Inc.
%
% Authors: Hao-yu Wu, Michael Rubinstein, Eugene Shih, 
% License: Please refer to the LICENCE file
% Date: June 2012
%
function GDown_stack = build_GDown_stack_stack192(StackFile, level)

 load(StackFile, 'Stack') 

    % Extract stack info
    sizeStack=size(Stack);
    stackHeight = sizeStack(2);
    stackWidth = sizeStack(3);
    nChannels = 3;
    startIndex=1;
    endIndex=sizeStack(1);

    
    % firstFrame
frame=squeeze(Stack(1,:,:,:));

    blurred = blurDnClr(frame,level);

    % create pyr stack
    GDown_stack = zeros(endIndex - startIndex +1, 1 , 1 ,size(blurred,3));
    GDown_stack(1,:,:,:) =  imresize(squeeze(blurred),1/12);

    k = 1;
    for iterator=startIndex+1:endIndex
            k = k+1;
            frame=squeeze(Stack(iterator,:,:,:));
            
            blurred = blurDnClr(frame,level);
            GDown_stack(k,:,:,:) = imresize(squeeze(blurred), 0.0625);

    end
    
end
