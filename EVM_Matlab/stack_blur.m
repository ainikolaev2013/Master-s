%gaussian blur on a stack

function blurred_stack=blur_stack(Stack, hsize, sigma);

if (exist('hsize') ~= 1)
    %[49 49] works much slower than [3 3] does.
  hsize = [49 49];
end

if (exist('sigma') ~= 1) 
  sigma = 25;
end

H = fspecial('gaussian', hsize, sigma);

blurred_stack=zeros(size(Stack));


for i=1:size(Stack,1)
   blurred_stack(i,:,:,:)= imfilter(Stack(i,:,:,:),H,'replicate');
end

end
