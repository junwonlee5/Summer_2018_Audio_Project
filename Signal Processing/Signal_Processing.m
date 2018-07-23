%%Signal Processing
%% 
%Square wave Fourier Transform

fs = 200;
t = 0:1/fs:1;
f = 10;
x = square(2*pi*t*f);
L = length(x);
% nfft = 1024;
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
t = 0:1/1e3:10;
x = chirp(t,0,1,250);
plot(t, x);

y = fft(x, nfft);
y = y(1:nfft/2);
freq = (0:nfft/2-1)*fs/nfft;
power = abs(y);
plot(freq, power);
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
%signal synthesis
fs = 200;
nfft = 1000;
t = 0:1/fs:10;
omega_1 = 2*pi;
amp1 = 2;
omega_2 = 5*pi;
amp2 = 1;
signal1 = amp1*sin(omega_1*t);
signal2 = amp2*sin(omega_2*t);
signal = signal1 + signal2;
h = hamming(length(signal));
signal = signal .* transpose(h);
plot(t, signal)
y = fft(signal, nfft);
y = y(1:nfft/2);
freq = (0:nfft/2-1)*fs/nfft;
power = abs(y);
stem(freq, power);
%% 
% Inverse Fourier Transform
a = ifft(fft(signal,nfft));
plot(t(1:nfft), signal(1:nfft), 'b*', t(1:nfft), a, 'r-')
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
plot(t, real(y), t, imag(y), t, abs(y))
%% 
% Square Signal
fs = 200;
t = 0:1/fs:10;
f = 1;
x = square(2*pi*t*f);
plot(t/pi,x,'.-',t/pi,sin(2*pi*t*f))
xlabel('t / \pi')
grid on
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
load handel; % the signal is in y and sampling freq in Fs
sound(y,Fs); pause(10); % Play the original sound
alpha = 0.9; D = 4196; % Echo parameters
b = [1,zeros(1,D),alpha]; % Filter parameters
x = filter(b,1,y); % Generate sound plus its echo
sound(x,Fs); pause(10); % Play sound with echo
w = filter(1,b,x);
sound(w, Fs)
