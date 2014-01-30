    load('./data/3780_cut1_stabforehead_stack.mat');
    Gdown_stack=Stack;
    cellx = 2;
    celly = 2;
    margin = 50;
    thr = 0*1e-4;    
    cntinterval = [351:800];
    %figure(1);        
    %count true pulse
    cnt = pulsecounter(Gdown_stack(cntinterval ,:,:,:), cellx, celly, margin, thr);
    %add noise to frames and build stack for noise frames
    noiselevel = 75/255;
    Gdown_stack_noisy = Gdown_stack;
    sigma = 0.001;
    cnt_spn=[];
    itnum = 10;
    KMAX = 80;
    %do 100 random trials
    for it = 1:itnum
        %add noise (in fact it is added to every pixel, but later we sum up
        %them so we can just add a random noise to a sum directly        
        datatrue = reshape(Gdown_stack(cntinterval, cellx, celly, 1:3), ...
            length(cntinterval), 100);
        datargb = ntsc2rgb(datatrue);
        datargbnoisy = datargb + sigma*randn(size(datargb));
        datantscnoisy = rgb2ntsc(datargbnoisy);
        Gdown_stack_noisy(cntinterval, cellx, celly, 1:3) = datantscnoisy;         
                
        data = datantscnoisy(:, 1);
        datajd = filter_jade(datargbnoisy);
        Gdown_stack_flt = Gdown_stack_noisy(cntinterval ,:,:,:);
        Gdown_stack_flt(:, cellx, celly, 1) = datajd(:);
        %count the pulse on filtered stack
        cnt_jd(it) = pulsecounter(Gdown_stack_flt, cellx, celly, margin, thr);                
        
        for K_target = 1:KMAX
            %do filtering with K_target components
            data_spflt = filter_sparse(data,K_target);
%            figure(5);
            %substitute results of sparse filtering to the stack
            Gdown_stack_flt = Gdown_stack_noisy(cntinterval ,:,:,:);
            Gdown_stack_flt(:, cellx, celly, 1) = data_spflt(:);
            %count the pulse on filtered stack
            cnt_spn(it,K_target) = pulsecounter(Gdown_stack_flt, cellx, celly, margin, thr);                
        end
    end
    %compute the average estimate ann its variance of n runs
    for K_target = 1:KMAX
        cnt_spn_avg(K_target)  = sum(cnt_spn(:,K_target)/itnum);
   %     vars(K_target) = var(cnt2spn(:,K_target));
        vars(K_target) = var(cnt_spn(:,K_target));
    end
    %75 - 14
    cnt_spn;