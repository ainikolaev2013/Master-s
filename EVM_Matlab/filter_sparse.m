function data_spflt = filter_sparse(data,K_target)
    opts = [];
    opts.slowMode = 0;
    opts.printEvery     = 25;
    %K_target = 25;
    
    winsize = length(data);%min([400 length(data)]);
   
    data_spflt = zeros(size(data));
    for i = 1:winsize:length(data)-winsize+1
        i
        windata = data(i:i+winsize-1);
        datalen = length(windata);    
        A = dctmtx(datalen)';
        b = windata;%(datainterval);
        [xk] = OMP( A, b, K_target, [],opts);        
        windata_spflt = A*xk;        
        data_spflt(i:i+winsize-1) = windata_spflt(:);
    end    
%    figure(1);
%    plot(data_spflt);
end