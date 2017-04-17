clear
f = @(t) cos(2*pi*t)+0.9*cos(20*pi*t);

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
%frequency axis
a = freq*(0:(sampleSize/2))/sampleSize;
figure(1);
plot(a, halfTransform);
title('Fourier Transform of f(t)');
xlabel('f (Hz)');
ylabel('fhat(w)');

%%%%%%%%%%%%%%%% IFFT %%%%%%%%%%%%%%%%%
f2 = ifft(fhat, 'symmetric');
figure(2);
plot(t(1:size(f2, 2)), f(t(1:size(f2, 2))), 'b');
hold on;
plot(t(1:size(f2, 2)), f2, 'r'); 
title('Inverse Fourier Transform of fhat(w)');
xlabel('t (s)');
ylabel('f(t)');