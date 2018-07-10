%%Signal Processing
[signal,fs] = audioread('aga4.wav');
signal = signal(:,1);
t = (0:1/fs:(length(signal)-1)/fs);
plot(t,signal);
sound(signal, fs);
xlabel('Time (seconds)')
ylabel('Amplitude')
xlim([0 t(end)])
%% 
%Train sound
clear all
load train
whos
sound(y, Fs)
%% 
% Noise 
SNR = 15;
z=awgn(signal,SNR,'measured');
plot(t, z, t, signal)
sound(z, fs)
%% 
% Convolution
conv_sig = conv(signal, y);
sound(conv_sig, fs)


%% 
% Envelope
[up,lo] = envelope(signal);
hold on
plot(t, signal,t,up,t,lo,'linewidth',1.5)
legend('signal','up','lo')
hold off
