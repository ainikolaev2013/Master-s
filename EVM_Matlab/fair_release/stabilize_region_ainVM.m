function stabilize_region_ainVM(vidFile, ...
...    start_frame, end_frame, 
lu, rd, outName)    
    vidFile_real = vidFile;
    vid = VideoReader(vidFile);
    %Only for Win Server 2008 till codecs are OK
    lastFrame = read(vid, inf);
    vidreal = VideoReader(vidFile_real);
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    fr = vid.FrameRate;
    nChannels = 3;
    temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

    % firstFrame
    init_frame = 1;
    temp.cdata = read(vid, init_frame);
    [rgbframe, ~] = frame2im(temp);    
    rgbframe = im2double(rgbframe);
    rgbframe = rgb2gray(rgbframe);
            

    vidOut = VideoWriter(outName, 'Uncompressed AVI');
    %vidOut.FrameRate = 30;
    vidOut.FrameRate = fr;
    len = vid.NumberOfFrames;
    
    open(vidOut);
    
    sz = size(rgbframe);
    [y x] = ndgrid( 1:sz(1), 1:sz(2) );
    
    winrx = rd(1) - lu(1) + 1;
    winry = rd(2) - lu(2) + 1;
    margin = 10;
    
    clu = lu;
    crd = rd;
        
 %   for i = start_frame:end_frame        
     for i = 1:len
         i
        temp.cdata = read(vid, i);
        [rgbframe2, ~] = frame2im(temp);
        rgbframe2 = im2double(rgbframe2);        
%        rgbframe2 = rgbframe2(intervalx, intervaly, 1:3);
        rgbframe2 = rgb2gray(rgbframe2);      
                
        temp.cdata = read(vidreal, i);
        [rgbframer, ~] = frame2im(temp);
        rgbframer = im2double(rgbframer);        
%        rgbframe2 = rgbframe2(intervalx, intervaly, 1:3);
        rgbframer = rgb2gray(rgbframer); 
        
        rgbframe_n = rgbframe(lu(1):rd(1), lu(2):rd(2));
        rgbframe2_n = rgbframe2(clu(1)-margin:crd(1)+margin, clu(2)-margin:crd(2)+margin);
        for level = 4:4
            resize_coef = 2^level/(winrx);
            MLdata{level}.m = [2^level 2^(level)];
            MLdata{level}.omega = [0 winrx 0 winry];
            MLdata{level}.omegat = [-margin winrx+margin -margin winry+margin];
            MLdata{level}.R = 255*imresize(rgbframe_n, resize_coef);
            %MLdata{level}.R = MLdata{level}.R - mean(mean(MLdata{level}.R));
            MLdata{level}.T = 255*imresize(rgbframe2_n, resize_coef);
            %MLdata{level}.T = MLdata{level}.T - mean(mean(MLdata{level}.T));
        end  
        
        resize_coef = 1;
        level = level+1;
        MLdata{level}.m = [winrx winry];
        MLdata{level}.omega = [0 winrx 0 winry];
        MLdata{level}.omegat = [-margin winrx+margin -margin winry+margin];
        MLdata{level}.R = 255*imresize(rgbframe_n, resize_coef);
        %MLdata{level}.R = MLdata{level}.R - mean(mean(MLdata{level}.R));
        MLdata{level}.T = 255*imresize(rgbframe2_n, resize_coef);
        
        
        viewImage('reset','viewImage','viewImage2D','colormap',bone(256),'axis','off');
        inter('reset','inter','linearInter2D','regularizer','moments','theta',1e-1);
        distance('reset','distance','NCC');
        trafo('reset','trafo','translation2D');
        
        w0inp = [0; 0];
        wc = MLPIR(MLdata,w0inp, 'plotIter',0,'plotMLiter',0,'pause','off');        
        doDerivative = 0;
        xc = getCenteredGrid(MLdata{level}.omega,MLdata{level}.m); 
        [yc,dy] = trafo(wc,xc,'doDerivative',doDerivative);
        %my algo
        rgbframer_n = 255*rgbframer(clu(1)-margin:crd(1)+margin, clu(2)-margin:crd(2)+margin);
        [Tc,dT] = inter(rgbframer_n,MLdata{level}.omegat,yc,'doDerivative',doDerivative);
        
        val = reshape(Tc, MLdata{level}.m(1), MLdata{level}.m(2));
        
        writeVideo(vidOut,im2uint8(val/255));    
    end
    
    close(vidOut);
    
    
end