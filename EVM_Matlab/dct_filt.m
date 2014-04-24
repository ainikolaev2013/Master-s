%DCT filter
%K should be chosen carefully
function dct_filtres=dct_filt(stack)
K=0.01
dct_stack=dct(stack);
dct_stack(abs(dct_stack) < K) = 0;
dct_filtres=idct(dct_stack);

end
