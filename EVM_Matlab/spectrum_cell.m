function spec = spectrum_cell(data)
    dataf = fft(hanning(length(data)).*(data - mean(data)));
    spec = dataf;%abs(dataf);
end