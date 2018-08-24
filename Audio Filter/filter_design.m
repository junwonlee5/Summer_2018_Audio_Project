%{
The following code filters the signal
%}

function [signal_filt_2, fs, t] = filter_design(file, N_ord, lpcutoff_Hz, hpcutoff_Hz, amp_factor)
[signal,fs] = audioread(file);
signal = signal(:,1);
t = (0:1/fs:(length(signal)-1)/fs);
plot(t,signal);
%sound(signal, fs);
xlabel('Time (seconds)')
ylabel('Amplitude')
title('Music file')
xlim([0 t(end)])


%%
% making butterworth filter with Nth order
if lpcutoff_Hz > 0
    [b,a]=butter(N_ord,lpcutoff_Hz/(fs/2),'low');  %this makes butterworth lowpass filter
    [d,c]=butter(N_ord,hpcutoff_Hz/(fs/2), 'high'); %this makes butterworth highpass filter

    signal_filt = filter(b,a,signal); %Signal goes through lowpass filter
    signal_filt_2 = filter(d, c, signal_filt); %Signal goes through low and high pass filter


    % Plots the filtered signal
    figure;
    plot(t,signal_filt_2*amp_factor, 'g-');
    xlabel('Time (sec)');
    ylabel('Amplitude');
    ylim([-1 1]);
    legend('LP & HP Filtered2');
    title([num2str(N_ord) 'rd-Order Filter with Cutoff at ' num2str(lpcutoff_Hz) ' Hz and '  num2str(hpcutoff_Hz) ' Hz']);

    %sound(signal_filt_2*amp_factor, fs);
else
    signal_filt_2 = signal * amp_factor;
    %sound(signal_filt_2*amp_factor, fs)
end



%% 
m = length(signal_filt_2); 
n = pow2(nextpow2(m));%new signal length that is next power of 2 greater than original signal length (for faster computation)
y = fft(signal_filt_2,n); %Fast fourier transform. Pads the signal with zeros to increase the new signal length n.  
f = (0:n-1)*(fs/n); % frequency vector
power = abs(y/n);   % power spectrum  
power = power(1:n/2+1);
power(2:end-1) = 2*power(2:end-1);

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
title('FFT of Filtered Music File')


%% 
%Periodogram and spectrogram of signal
segment = 0.05*fs;
figure
periodogram(signal_filt_2, [], [], fs);
figure
spectrogram(signal_filt_2, round(length(t)./segment), [], [], fs, 'yaxis');%colorbar;
%colormap(hot);
title('Spectrogram of Filtered Music File')
end
    


 



    