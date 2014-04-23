function plotspec(freqnum, fps, dataf, color, len)
    plot([2:freqnum]/len*fps, dataf(3:freqnum+1), [color]);
end