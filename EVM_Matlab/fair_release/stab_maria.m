function stab_maria
%of.mat!!! 
    vidFile = 'C:\sampleprojects\FAIR\pulsedata\3780_cut1.mp4';
    
    start_frame = 1;
    end_frame = 500;
    
    %lu = [536; 66];
    %lu = ([370; 610] - [1; 1]);
    lu = ([395; 657] - [1; 1]);
%    lu = floor([47; 100]/2);
    %rd = [729; 729];
    rd = ([425; 685] + [1; 1]);
%     rd = floor([81; 205]/2)+1;
%     rd = [40; 109];
    % Read video

    outName = ['C:\sampleprojects\FAIR\pulsedata\stab_tr4_2.avi'];    
        
    stabilize_region(vidFile, start_frame, end_frame, lu, rd, outName);    
    
end