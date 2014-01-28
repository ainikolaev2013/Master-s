function cnt = pulsecounter(Gdown_stack, cellx, celly, margin, thr)
    fl = 30/60;
    fh = 150/60;
%    samplingRate = 24;
   samplingRate = 50; % 25 for 3779
    filtered_stack = ideal_bandpassing(Gdown_stack, 1, fl, fh, samplingRate);
    plot(filtered_stack (:, cellx, celly, 1));
    len = length(filtered_stack (:, cellx, celly, 1));
    data = filtered_stack (margin:len-margin, cellx, celly, 1);
    inds = find(data>thr);
    cnt = 0;
    if (length(inds) > 0)
        cnt = 1;
    end
    for i = 2:length(inds)
        if (inds(i) == inds(i-1)+1)
            cnt = cnt;
        else
            cnt = cnt+1;
        end
    end
    plot(1:length(data), data, 1:length(data), thr)
    cnt
end