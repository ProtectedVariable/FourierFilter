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

a = freq*(0:(sampleSize/2))/sampleSize;
figure(1);
plot(a, getPlotableFFT(fhat));
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
fhatlow = filterFFT(fhat, 0, lowDirac+region, freq);
figure(3);
plot(getPlotableFFT(fhatlow));
title('Filtered Fourier Transform of f(t)');
xlabel('f (Hz)');
ylabel('fhat''(w)');

f3 = ifft(ifftshift(fhatlow), 'symmetric');
figure(4);
fplot(f, [0 5]);
hold on;
plot(t(1:size(f3, 2)), f3, 'r'); 

%%%%%%%%%%%%%% IFFT 3 %%%%%%%%%%%%%%%%%%%
fhathigh = filterFFT(fhat, highDirac-region, highDirac+region, freq);
figure(5);
plot(getPlotableFFT(fhathigh));
title('Filtered Fourier Transform of f(t)');
xlabel('f (Hz)');
ylabel('fhat''''(w)');

f4 = ifft(ifftshift(fhathigh), 'symmetric');
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

hhat = fftshift(fft(h(2,:)));
sampleSize = size(hhat,2);
freq = size(h, 2)./h(1, end);

a = freq*(0:(sampleSize/2))/sampleSize;

figure(8);
plot(a, getPlotableFFT(hhat));
title('Fourier Transform of h(t)');
xlabel('f (Hz)');
ylabel('hhat(w)');

hhatfiltered = filterFFT(hhat, 0, 12, freq);
figure(9);
plot(a, getPlotableFFT(hhatfiltered));
title('Filtered Fourier Transform of h(t)');
xlabel('f (Hz)');
ylabel('hhat(w)');

%%%%% IFFT hhat(w) %%%%

hr = ifft(ifftshift(hhatfiltered), 'symmetric');
figure(10);
plot(1:size(hr, 2), hr, 'r'); 
title('Filtered Inverse Fourier Transform of hhat(w)');
xlabel('t (s)');
ylabel('h''(t)');
