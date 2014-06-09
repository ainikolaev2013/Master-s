%test sin
tic
%dct_result=[];
%dct_5Hz_result=[];
omp=[];
omp_5Hz=[];
%mit=[];
for externaliterator = 1:100
    gen_sin;
    x_5Hz=ideal_bandpassing(x,1,30/60, 300/60,25);
 %   dct_result=[dct_result; length(findpeaks(dct_filt(x,1)))];
 %   dct_5Hz_result=[dct_5Hz_result; length(findpeaks(dct_filt(x_5Hz,1)))];
    omp=[omp; length(findpeaks(filter_sparse_noiterator(x,1)))];
    %omp_5Hz=[omp_5Hz; length(findpeaks(filter_sparse_noiterator(x_5Hz,1)))];
    %mit=[mit; length(findpeaks(ideal_bandpassing(x,1,30/60,70/60,25)))];
    externaliterator
end;
toc