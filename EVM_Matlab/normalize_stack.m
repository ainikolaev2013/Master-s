%normalize stack
%Take the input stack in the form of (frame_number, x_coordinate,
%y_coordinate, channel) and then for each pixel of each channel of every
%frame substract the mean for that channel (averaged over the whole stack)
%and divide by the standard deviation for that channel (again, computed
%over the whole stack). This normalization is described on page 5 of the
%MIT 2010 article in (3).

function normalized_stack=normalize_stack(Stack)
 normalized_stack=zeros(size(Stack,1), size(Stack,2), size(Stack,3), size(Stack,4));
    
for iterator=1:size(Stack,4)
    temp_stack=Stack(:,:,:,iterator);
    
    stack_mean(iterator)=mean(temp_stack(:));
    stack_std(iterator)=std(temp_stack(:));
    for frame=1:size(temp_stack,1)
        for x=1:size(temp_stack,2)
            for y=1:size(temp_stack,3)
                temp_stack(frame,x,y)=(temp_stack(frame,x,y)-stack_mean(iterator))/stack_std(iterator);
                normalized_stack(frame,x,y,iterator)=temp_stack(frame,x,y);
            end
        end
    end
   
    
end;

end