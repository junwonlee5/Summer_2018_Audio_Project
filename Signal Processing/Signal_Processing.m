%%Signal Processing

%Square wave Fourier Transform

fs = 150;
t = 0:1/fs:2;
f = 10;
x = square(2*pi*t*f);
L = length(x);
nfft = 1024;
plot(t/pi,x,'.-',t/pi,sin(2*pi*t*f))
xlabel('t / \pi')
grid on
y = fft(x, nfft);
y = y(1:nfft/2);
power = abs(y/L);   % power spectrum  
power(2:end-1) = 2*power(2:end-1);
freq = (0:nfft/2-1)*fs/nfft;
figure(2);
plot(freq, power);
title('FFT of square wave');
xlabel('Frequency (Hz)');
ylabel('Power');

%% 
% Triangle wave Fourier Transform
fs = 200;
t = 0:1/fs:1;
f = 5;
x = sawtooth(2*pi*t*f, 0.5);
L = length(x);
nfft = 1024;
plot(t/pi,x,'.-')
xlabel('t / \pi')
grid on
y = fft(x, nfft);
y = y(1:nfft/2);
power = abs(y/L);   % power spectrum  
power(2:end-1) = 2*power(2:end-1);
freq = (0:nfft/2-1)*fs/nfft;
figure(2);
plot(freq, power);
title('FFT of Triangle wave');
xlabel('Frequency (Hz)');
ylabel('Power');
%% 
%Non-Periodic Chirp & Spectrogram
nfft = 1024;
fs = 500;
t = 0:1/1e3:1;
x = chirp(t,0,1,250);
L = length(x);
plot(t, x);

y = fft(x, nfft);
y = y(1:nfft/2);
power = abs(y/L);   % power spectrum  
power(2:end-1) = 2*power(2:end-1);
freq = (0:nfft/2-1)*fs/nfft;
plot(freq, power);
figure
spectrogram(x,256,250,256,1e3,'yaxis')

%% 
% Gaussian Noise 
fs = 200;
t = 0:1/fs:1;
f = 5;
x = sawtooth(2*pi*t*f, 0.5);
y = awgn(x,10,'measured');
plot(t,x, t, y)
legend('Original Signal','Signal with AWGN')

%% 
% Complex signal
fs = 200;
f1 = 3;
f2 = 8;
amp1 = 1;
amp2 = 0.6;
t = 0:1/fs:10;
y1 = amp1* exp(1j*f1*t);
y2 = amp2 * exp(1j*f2*t);
y = y1 + y2;
plot(t, real(y),'r-', t, imag(y), 'b-',t, abs(y),'g-')

%% 
% Smoothing Square Signal with simple low pass filter
fs = 200;
t = 0:1/fs:10;
f = 1;
x = square(2*pi*t*f);
L = length(x);
nfft = 1024;
plot(t/pi,x,'.-',t/pi,sin(2*pi*t*f))
xlabel('t / \pi')
grid on

window = ones(1,5);
window = window ./ length(window);
finwindow = [window, zeros(1, length(x) - length(window))];
%prod = finwindow .* x;
rolled = finwindow;
smoothed = zeros(1, length(x));
S = length(smoothed);
for i = 1:length(x)
     smoothed(1, i) = smoothed(1, i) + sum(x .* rolled);
     rolled = circshift(rolled, 1);
end
plot(t, x, 'b-', t, smoothed, 'r-')

%%% Comparing ratio
y = fft(smoothed, nfft);
y = y(1:nfft/2);
power = abs(y/L);   % power spectrum  
power(2:end-1) = 2*power(2:end-1);
freq = (0:nfft/2-1)*fs/nfft;
k = fft(x, nfft);
k = k(1:nfft/2);
power2 = abs(k/L);
power2(2:end-1) = 2*power2(2:end-1);
plot(freq, power, 'b-', freq, power2, 'r-')
plot(freq, power2./power)
ratio = power2 ./ power;
plot(freq, ratio);
ratio = power ./ power2;
plot(freq, ratio, 'b-', freq, power2, 'r-', freq, power, 'g-');
%% 
%Convolution
fs = 200;
t = 0:1/fs:10;
f = 1;
x = square(2*pi*t*f);
L = length(x);
nfft = 1024;
plot(t/pi,x,'.-',t/pi,sin(2*pi*t*f))
xlabel('t / \pi')
grid on

window = ones(1,11);
window = window ./ length(window);
finwindow = [window, zeros(1, length(x) - length(window))];
convolved = conv(x, window, 'valid');
C = length(convolved);
%plot(t, x, 'b-', t, convolved, 'r-');

y = fft(convolved, nfft);
y = y(1:nfft/2);
power = abs(y/C);
power(2:end-1) = 2*power(2:end-1);
freq = (0:nfft/2-1)*fs/nfft;
k = fft(x, nfft);
k = k(1:nfft/2);
power2 = abs(k/L);
power2(2:end-1) = 2*power2(2:end-1);
plot(freq, power, 'b-', freq, power2, 'r-')
plot(freq, power2./power)
ratio = power2 ./ power;
plot(freq, ratio);
ratio = power ./ power2;
plot(freq, power2, 'r-', freq, power, 'g-');
figure
plot(freq, ratio, 'b-');

z = fft(finwindow, nfft);
z = z(1:nfft/2);
power3 = abs(z);
plot(freq, power3, freq, ratio);
%% 
% Gaussian window

fs = 200;
t = 0:1/fs:20;
f = 1;
x = square(2*pi*t*f);
L = length(x);
nfft = 1024;
plot(t/pi,x,'.-',t/pi,sin(2*pi*t*f))
xlabel('t / \pi')
grid on

G = 20;
window = gausswin(G);
window = window ./ sum(window);
convolved = conv(x, window, 'valid');
C = length(convolved);

%plot(t, x, 'b-', t, convolved, 'r-');

y = fft(convolved, nfft);
y = y(1:nfft/2);
power = abs(y/length(convolved));
freq = (0:nfft/2-1)*fs/nfft;
k = fft(x, nfft);
k = k(1:nfft/2);
power2 = abs(k/L);
plot(freq, power, 'b-', freq, power2, 'r-')
plot(freq, power2./power)
ratio = power2 ./ power;
plot(freq, ratio);
ratio = power ./ power2;
plot(freq, power2, 'r-', freq, power, 'g-');
figure
plot(freq, ratio, 'b-');

z = fft(window, nfft);
z = z(1:nfft/2);
power3 = abs(z);
plot(freq, power3, freq, ratio);

%% 
load handel;
figure
subplot(2,1,1)
plot(y)
title('handel in time domain')
subplot(2,1,2)
spectrogram(y, 256,128, 256, Fs, 'yaxis')
title('Spectrogram of handel') 

