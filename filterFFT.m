function [ filtered ] = filterFFT( fft, minFreq, maxFreq, SampleFreq )
center = size(fft,2)/2;
sampleSize = size(fft, 2);
%Convert frequency to fft indices
pMin = round(center+minFreq*ceil(sampleSize/SampleFreq));
pMax = round(center+maxFreq*floor(sampleSize/SampleFreq));
nMin = round(center-maxFreq*floor(sampleSize/SampleFreq));
nMax = round(center-minFreq*ceil(sampleSize/SampleFreq));

filtered = zeros(1, sampleSize);
filtered(pMin:pMax) = fft(pMin:pMax);
filtered(nMin:nMax) = fft(nMin:nMax);

end

