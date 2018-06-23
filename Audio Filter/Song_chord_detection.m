[signal,fs] = audioread('a4.wav');
signal = signal(:,1);
t = (0:1/fs:(length(signal)-1)/fs);
plot(t,signal);
sound(signal, fs);
xlabel('Time (seconds)')
ylabel('Amplitude')
xlim([0 t(end)])

%% 
p = 1;
len = length(t)/(t(end)/0.5);
tseg = t(1+len*(p-1):len*p);
signalseg = signal(1+len*(p-1):len*p);
sound(signalseg, fs);
mseg = length(signalseg);
nseg = pow2(nextpow2(mseg));
yseg = fft(signalseg, nseg);
fseg = (0:nseg-1)*(fs/nseg); % frequency vector
for i=1:mseg
    if fseg(1,i) >= 1100
        fseg = fseg(1:i);
        maxfreq = i;
        break
    end
end
power = abs(yseg).^2/nseg;   % power spectrum
vocalrange = fseg(1:maxfreq);
vocalpower = power(1:maxfreq);
figure
plot(vocalrange,vocalpower)
xlabel('Frequency')
ylabel('Power')
map = [transpose(vocalrange) vocalpower];
indexmax = find(max(vocalpower) == vocalpower);
fsegmax = fseg(indexmax);
powermax = power(indexmax);
Pitches = [];
Scale = '';
for i= 1:length(fseg)
    if map(i, 2) > 0.05
        Pitches = [Pitches, map(i,1)];
    end
end
for i = 1:length(Pitches)
    for j = 1:length(VarName2)
        if abs((Pitches(1,i) - VarName2(j,1))/VarName2(j,1)) <= .01
            Scale = Scale + string(C0(j,1) + ' ');
        end
    end
end
Scale = split(Scale);
Scale = unique(Scale);
if length(Scale) > 1
    Scale = Scale(2:end, 1);
end
pitch = Scale(1,1);

%% 
plot(psd(spectrum.periodogram,signal,'Fs',fs,'NFFT',length(signal)));
%spectrogram(signal);
    


 



    