[signal,fs] = audioread('Mi Gente Inst.mp3');
signal = signal(:,1);
t = (0:1/fs:(length(signal)-1)/fs);
plot(t,signal);
sound(signal, fs);
xlabel('Time (seconds)')
ylabel('Amplitude')
xlim([0 t(end)])


%%
% making filter
N = 5;  %Nth order
cutoff_Hz = 200; %Lowpass frequency in Hz
cutoff_Hz_2 = 20; %Highpass frequench in Hz
[b,a]=butter(N,cutoff_Hz/(fs/2),'low');  %this makes butterworth lowpass filter
[d,c]=butter(N,cutoff_Hz_2/(fs/2), 'high'); %this makes butterworth highpass filter
amp_factor = 1.5;

signal_filt = filter(b,a,signal); %Signal goes through lowpass filter
signal_filt_2 = filter(d, c, signal_filt); %Signal goes through low and high pass filter

figure;
plot(t,signal,t,signal_filt,t,signal_filt_2*amp_factor);
xlabel('Time (sec)');
ylabel('Amplitude');
ylim([-1 1]);
legend('Raw','Filtered', 'Filtered2');
title([num2str(N) 'rd-Order Filter with Cutoff at ' num2str(cutoff_Hz) ' Hz and '  num2str(cutoff_Hz_2) ' Hz']);
sound(signal_filt_2*amp_factor, fs);

%% 
m = length(signal_filt_2); 
n = pow2(nextpow2(m));%new signal length that is next power of 2 greater than original signal length (for faster computation)
y = fft(signal_filt_2,n); %Fast fourier transform. Pads the signal with zeros to increase the new signal length n.  
f = (0:n-1)*(fs/n); % frequency vector
power = abs(y).^2/n;   % power spectrum  
%power = abs(y);
%% 
% The for loop below sets the maximum of x-axis so that the power spectrum
% of the signal truncates the further half of the fft.
for i=1:n
    if f(1,i) >= fs/2
        f = f(1:i);
        maxfreq = i;
        break
    end
end    
vocalrange = f(1:maxfreq); 
vocalpower = power(1:maxfreq);
figure
plot(vocalrange, vocalpower) %Plots the power spectrum over different frequency rate.
xlabel('Frequency')
ylabel('Power')
map = [transpose(vocalrange) vocalpower];

%% 
%Periodogram and spectrogram of signal
periodogram(signal_filt_2, [], [], fs);
figure
spectrogram(signal_filt_2, 1024, [], [], fs, 'yaxis');colormap;
    


 



    