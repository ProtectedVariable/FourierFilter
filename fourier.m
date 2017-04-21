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
fhat = fftshift(fft(samples));

%fhat has to be normalized by the sample size (see instructions)
module = abs(fhat/sampleSize);
%only keep the positive spectrum
halfTransform = module(ceil(sampleSize/2):end);
%Since power was divided with the negative spectrum, we double the values
halfTransform(1:end) = 2*halfTransform(1:end);
%frequency axis (btw respects shannon sampling theorem) (0->f/2)
a = freq*(0:(sampleSize/2))/sampleSize;
figure(1);
plot(a, halfTransform);
title('Fourier Transform of f(t)');
xlabel('f (Hz)');
ylabel('fhat(w)');

%%%%%%%%%%%%%%%% IFFT %%%%%%%%%%%%%%%%%
f2 = ifft(ifftshift(fhat), 'symmetric');
figure(2);
fplot(f, [0 5]);
hold on;
plot(t(1:size(f2, 2)), f2, 'r'); 
title('Inverse Fourier Transform of fhat(w)');
xlabel('t (s)');
ylabel('f(t)');

%%%%%%%%%%%%%% IFFT 2 %%%%%%%%%%%%%%%%%%%
fhatlow = filterFFT(halfTransform, 0, lowDirac+region, freq)*sampleSize/4;
figure(3);
plot(fhatlow);
title('Filtered Fourier Transform of f(t)');
xlabel('f (Hz)');
ylabel('fhat''(w)');

f3 = ifft(fhatlow, 'symmetric');
figure(4);
fplot(f, [0 5]);
hold on;
plot(t(1:size(f3, 2)), f3, 'r'); 

%%%%%%%%%%%%%% IFFT 3 %%%%%%%%%%%%%%%%%%%
fhathigh = filterFFT(halfTransform, highDirac-region, highDirac+region, freq)*sampleSize/4;
figure(5);
plot(fhathigh);
title('Filtered Fourier Transform of f(t)');
xlabel('f (Hz)');
ylabel('fhat''''(w)');

f4 = ifft(fhathigh, 'symmetric');
figure(6);
fplot(f, [0 5]);
hold on;
plot(t(1:size(f4, 2)), f4, 'r'); 

%%%%%% DATA %%%%%
fileID = fopen('mydata.txt','r');
h = fscanf(fileID, '%f %f', [2 Inf]);
fclose(fileID);

figure(7);
plot(h(1,:), h(2,:));
%%%%% FFT 2 %%%%%%

fhat = fftshift(fft(h(2,:)));
sampleSize = size(fhat,2);

module = abs(fhat/sampleSize);
halfTransform = module(ceil(sampleSize/2):end);
halfTransform(1:end) = 2*halfTransform(1:end);
a = freq*(0:(sampleSize/2))/sampleSize;

figure(8);
plot(a, halfTransform);
title('Fourier Transform of h(t)');
xlabel('f (Hz)');
ylabel('hhat(w)');

fhatfiltered = filterFFT(halfTransform, 0, 10, freq);
figure(9);
plot(a, fhatfiltered);
title('Filtered Fourier Transform of h(t)');
xlabel('f (Hz)');
ylabel('hhat(w)');
