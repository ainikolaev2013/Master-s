dataDir = './data';
resultsDir = './output';
mkdir(resultsDir);

filename = '3780_cut3_stabforehead_stack.mat';  



    inFile = fullfile(dataDir, filename);

load(inFile);
    Gdown_stack=stack_blur(Stack);
    %These are the actual pixels that we are looking at.
    cellx = 26;
    celly = 26;
    margin = 50;
    thr = 0*1e-4;    
    %I'm not sure this is still relevant, yet let's keep it for now.
    %cntinterval = [351:800];
    cntinterval = [1:size(Stack,1)];
    %figure(1);        
    %count true pulse
    %cnt = pulsecounter(Gdown_stack(cntinterval ,:,:,:), cellx, celly, margin, thr);
    %add noise to frames and build stack for noise frames
    %noiselevel = 75/255; no longer relevant
    iterator_noiselevel=0;
    Gdown_stack_noisy = Gdown_stack;
    sigma = 0.001;
    iterator_sigma=0;
    cnt_spn=[];
    itnum = 100;  %100
    KMAX = 80;   %80
    for sigma=0:0.001:0.005   % needs to be changed to 0.005
        iterator_sigma=iterator_sigma+1;
    %do 100 random trials
    for it = 1:itnum
        %add noise (in fact it is added to every pixel, but later we sum up
        %them so we can just add a random noise to a sum directly        
        datatrue = reshape(Gdown_stack(cntinterval, cellx, celly, 1:3), ...
            length(cntinterval), 3);  %alternatively---824
      %  datargb = ntsc2rgb(datatrue);
       datargb = datatrue; %we're in RGB space so far.
        datargbnoisy = datargb + sigma*randn(size(datargb));
        datantscnoisy = rgb2ntsc(datargbnoisy);
        Gdown_stack_noisy(cntinterval, cellx, celly, 1:3) = datantscnoisy;         
                
        data = datantscnoisy(:, 1);
        %required for JADE
  %      normalized_datargbnoisy=normalize_data(datargbnoisy);
        
   %     datajd = filter_jade(normalized_datargbnoisy);
    %    Gdown_stack_flt = Gdown_stack_noisy(cntinterval ,:,:,:);
        
        %This is the result of using JADE filtering.
     %   Gdown_stack_flt(:, cellx, celly, 1) = datajd(:);
       
        %Save the results
      %  Result_JADE(iterator_sigma, it)={datajd(:)};
        %count the pulse on filtered stack
       % cnt_jd(it) = pulsecounter(Gdown_stack_flt, cellx, celly, margin, thr);                
        n = length(data);
        samplingRate = 25;
        wl = 30/60;
        wh = 150/60;
        Freq = 1:n;
        Freq = (Freq-1)/n*samplingRate;
        mask = Freq > wl & Freq < wh;

        Dimensions(1) = 1;
        mask = mask(:);
        mask = repmat(mask, Dimensions);

       
        for K_target = 1:KMAX
            %we actually need NTSC here and data is already in NTSC
            %do filtering with K_target components
            data_spflt = filter_sparse(data,K_target);
%            figure(5);
            %substitute results of sparse filtering to the stack
            Gdown_stack_flt = Gdown_stack_noisy(cntinterval ,:,:,:);
            Gdown_stack_flt(:, cellx, celly, 1) = data_spflt(:);
            %count the pulse on filtered stack
            %cnt_spn(it,K_target) = pulsecounter(Gdown_stack_flt, cellx, celly, margin, thr); 
            %Result_SPFLT(iterator_sigma, it, K_target)={data_spflt(:)};
            %compute variance
            
            %sum of squares of differences
            %SPFLT_result=sum((data-data_spflt).*(data-data_spflt));
            
            %pulsecounting
        
            SPFLT_result = pulsecounter(Gdown_stack_flt, cellx, celly, margin, thr);
    
            %reference pulsecounting
            SPFLT_ref_value= pulsecounter(Gdown_stack_noisy, cellx, celly, margin, thr);     
            
            disp([K_target SPFLT_result]);
            disp(['K_target: ' num2str(K_target) ', number of beats: ' num2str(SPFLT_result)]);
            
            SPFLT(iterator_sigma, it, K_target)=SPFLT_result;
            SPFLT_ref(iterator_sigma, it, K_target)=SPFLT_ref_value;
            
    end
        end
    end
    
     
   save(fullfile(resultsDir, [filename '_results.mat']), 'SPFLT', 'SPFLT_ref'); 
  
    %compute the average estimate ann its variance of n runs
    for K_target = 1:KMAX
   %     cnt_spn_avg(K_target)  = sum(cnt_spn(:,K_target)/itnum);
   %     vars(K_target) = var(cnt2spn(:,K_target));
   %     vars(K_target) = var(cnt_spn(:,K_target));
   
   %compute variance
   
    end
    %75 - 14

    cnt_spn;