%normalize stack
%Take the input stack in the form of (frame_number, x_coordinate,
%y_coordinate, channel) and then for each pixel of each channel of every
%frame substract the mean for that channel (averaged over the whole stack)
%and divide by the standard deviation for that channel (again, computed
%over the whole stack). This normalization is described on page 5 of the
%MIT 2010 article in (3).

function normalized_data=normalize_data(data)
 normalized_data=zeros(size(data,1), size(data,2));
    
for iterator=1:size(data,2)
    temp_data=data(:,iterator);
    
    stack_mean(iterator)=mean(temp_data(:));
    stack_std(iterator)=std(temp_data(:));
    for frame=1:size(temp_data,1)
                temp_data(frame)=(temp_data(frame)-stack_mean(iterator))/stack_std(iterator);
                normalized_data(frame,iterator)=temp_data(frame);
    end
   
    
end;

end