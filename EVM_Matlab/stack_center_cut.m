%obtaining the center pixel of a stack

function center_cut_stack=stack_center_cut(Stack);

stack_size=size(Stack);
center_x=(stack_size(2)+1)/2;
center_y=(stack_size(3)+1)/2;

center_cut_stack=zeros(stack_size(1), 3);


for i=1:size(Stack,1)
   center_cut_stack(i,:)= squeeze(squeeze(Stack(i,26,26,:)));
end

end
