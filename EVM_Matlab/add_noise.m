%adding epsilon gaussian noise
function noise_stack=add_noise(stack, sigma)

if nargin < 2 
    sigma = 0.001;
end

noise_stack=stack + sigma*rand(size(stack));

end