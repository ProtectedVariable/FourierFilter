function [ nfft ] = getPlotableFFT( fft )
nfft = abs(fft(ceil(size(fft, 2)/2):end))/size(fft,2)*2;
end

