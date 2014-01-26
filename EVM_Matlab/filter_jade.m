function data_jadeflt = filter_jade(data)
    n = 3;            
    %min([400 length(data)]);
    %for i = 1:winsize:length(data)-winsize+1                
        X = data';
        B = jadeR(X,n);
        Y = B*X;        
        data_jadeflt = Y(2,:);                
    %end    
    
end