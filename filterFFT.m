function [ filtered ] = filterFFT( fft, minFreq, maxFreq, freq )
%Indices
%an = f*n/s
%n = an/freq * sampleSize
sampleSize = size(fft, 2)*2;
maxFreq = ceil((maxFreq)/freq*sampleSize); 
minFreq = max(1, ceil((minFreq)/freq*sampleSize));
filtered = zeros(1, size(fft,2));
filtered(minFreq:maxFreq) = fft(minFreq:maxFreq);

end

