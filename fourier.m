clear
f = @(t) cos(2*pi*t)+0.9*cos(20*pi*t);

period = 0.025;
t = 0:period:10;
freq = 1/period;
sampleSize = size(t);
sampleSize = sampleSize(2);

samples = f(t);
fhat = fft(samples);

diracs = abs(fhat/sampleSize);
points = diracs(1:floor(sampleSize/2)+1);
points(2:end-1) = 2*points(2:end-1);

a = freq*(0:(sampleSize/2))/sampleSize;

plot(a,points) 
title('Fourier Transform of f(t)')
xlabel('f (Hz)')
ylabel('f(w)')