clear
f = @(t) cos(2*pi*t)+0.9*cos(20*pi*t);

lowDirac = 1; %Hz
highDirac = 10; %Hz
region = 4; %Hz

period = 0.025;
t = 0:period:10;
freq = 1/period;
sampleSize = size(t, 2);

%%%%%%%%%%%%%%%% FFT %%%%%%%%%%%%%%%%%
samples = f(t);
fhat = fft(samples);

%fhat has to be normalized by the sample size (see instructions)
module = abs(fhat/sampleSize);
%only keep the positive spectrum
halfTransform = module(1:floor(sampleSize/2)+1);
%Since power was divided with the negative spectrum, we double the values
halfTransform(1:end-1) = 2*halfTransform(1:end-1);
%frequency axis (btw respects shannon sampling theorem) (0->f/2)
a = freq*(0:(sampleSize/2))/sampleSize;
figure(1);
plot(a, halfTransform);
title('Fourier Transform of f(t)');
xlabel('f (Hz)');
ylabel('fhat(w)');

%%%%%%%%%%%%%%%% IFFT %%%%%%%%%%%%%%%%%
f2 = ifft(fhat, 'symmetric');
figure(2);
fplot(f, 0:10);
hold on;
plot(t(1:size(f2, 2)), f2, 'r'); 
title('Inverse Fourier Transform of fhat(w)');
xlabel('t (s)');
ylabel('f(t)');

%%%%%%%%%%%%%% IFFT 2 %%%%%%%%%%%%%%%%%%%
%an = f*n/s
%n = an/freq * sampleSize
maxFreq = ceil((lowDirac+region)/freq*sampleSize);
fhatlow = zeros(1, size(a,2));
fhatlow(1:maxFreq) = halfTransform(1:maxFreq);
figure(3);
plot(a, fhatlow);
title('Filtered Fourier Transform of f(t)');
xlabel('f (Hz)');
ylabel('fhat''(w)');

f3 = ifft(fhatlow, 'symmetric');
figure(4);
plot(t(1:size(f3, 2)), f3, 'r'); 

%%%%%%%%%%%%%% IFFT 3 %%%%%%%%%%%%%%%%%%%
maxFreq = ceil((highDirac+region)/freq*sampleSize);
minFreq = ceil((highDirac-region)/freq*sampleSize);
fhathigh = zeros(1, size(a,2));
fhathigh(minFreq:maxFreq) = halfTransform(minFreq:maxFreq);
figure(5);
plot(a, fhathigh);
title('Filtered Fourier Transform of f(t)');
xlabel('f (Hz)');
ylabel('fhat''''(w)');

f4 = ifft(fhathigh, 'symmetric');
figure(6);
plot(t(1:size(f4, 2)), f4, 'r'); 