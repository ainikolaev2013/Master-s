function windata_spflt = filter_sparse_noiterator(data,K_target)
    opts = [];
    opts.slowMode = 0;
    opts.printEvery     = 25;
    %K_target = 25;


    A = dctmtx(length(data))';
    b = data;%(datainterval);
    [xk] = OMP( A, b, K_target, [],opts);        
    windata_spflt = A*xk;        
      

end