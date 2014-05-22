%DCT filter
%K should be chosen carefully
function dct_filtres=dct_filt(stack, K)

if nargin < 2
K=0.01
end

%performing DCT
disp('Performing the DCT...')
dct_stack=dct(stack);

%Zeroing out all values less than K
dct_stack(abs(dct_stack) < K) = 0;

%restoring the stack
disp('Restoring the signal...')
dct_filtres=idct(dct_stack);

end
