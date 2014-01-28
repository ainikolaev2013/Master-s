dataDir = 'E:\Grad School\Master''s\CanonVideos\Maria';
resultsDir = 'output';

%addpath(genpath('./ain'));

%mkdir(resultsDir);

x_left=144;
x_right=159;
y_top=144;
y_bottom=159;



filename = {'3780_cut1_stab', '3780_cut3_stab'};

for i=1:numel(filename) 

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
% No nee
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
  
% %to equalize them all
% disp('Harmonizing stack sizes')
% max_frames=min(endIndex);
%     
% 
%  for i=size(filename,1):size(filename,2)
%  disp(['Harmonizing' filename{i}])
%     if max_frames < size(Stack{i},1)
%         for j=size(Stack{i},1):-1:max_frames+1
%             disp(j)
%         Stack{i}(j,:,:,:)=[];
%         end;
%     end;
% end;
% disp('Harmonization completed')
 %filtering out what we don't need
 %not implemented yet
%    Filtered_Stack{i}=filter_freqs(Stack{i});
    




