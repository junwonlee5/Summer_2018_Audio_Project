%{
The following program processes audio file with single pitch and detects
the pitch along with the harmonics. 
.
%}
%% 
function [Scale, pitch] = Pitch_Detection(file)
load init_workspace 
%{
loads the initial workspace with columns C0 and VarName2, 
where C0 consists of musical notes and VarName2 consists of corresponding frequency. 
%}
[signal,fs] = audioread(file); 
%{
reads data from the audiofile and returns sampled data, signal, and a
sample rate of the data, Fs
%}
signal = signal(:,1);
%{
Because this signal has two separate parts (left & right ears), we will
sample only one side of the ear (left). To select right, type
signal(:,2).
%}
t = (0:1/fs:(length(signal)-1)/fs); %creates a time vector that divides the overall time by sample rate fs. 
% Uncomment the two following comments to apply hamming window (used to prevent leackage)
% w = hamming(length(signal));
% signal = signal .* w;
figure
subplot(2,1,1)
plot(t,signal); %plots the signal over time)
sound(signal, fs); %plays the sound
xlabel('Time (seconds)')
ylabel('Amplitude')
title('Unknown Sound Wave with Single Pitch')
xlim([0 t(end)])
%% 
m = length(signal); 
n = pow2(nextpow2(m));%new signal length that is next power of 2 greater than original signal length (for faster computation)
y = fft(signal,n); %Fast fourier transform. Pads the signal with zeros to increase the new signal length n.  
f = (0:n-1)*(fs/n); 
f = f(1:n/2+1); % frequency vector
power = abs(y/n);    
power = power(1:n/2+1);
power(2:end-1) = 2*power(2:end-1); % power spectrum 
subplot(2,1,2)
plot(f, power) %Plots the power spectrum over different frequency rate.
xlabel('Frequency')
ylabel('Power')
title('Discrete Fourier Transform of Unknown Sound Wave')
map = [transpose(f) power];

%% 
Pitches = [];
Scale = '';
% The for loop selects frequencies with greater than 1% of maximum amplitude of the signal and stores it
% inside a matrix Pitches.
for i= 1:length(f)
    if map(i, 2) > max(signal)*0.01
        Pitches = [Pitches, map(i,1)];
    end
end
% The for loop goes over the frequencies inside the Pitches matrix, and
% determines the closest note to within 1% error. Then, it adds the note
% to a string Scale.
for i = 1:length(Pitches)
    for j = 1:length(VarName2)
        if abs((Pitches(1,i) - VarName2(j,1))/VarName2(j,1)) <= .01
            Scale = Scale + string(C0(j,1) + ' ');
        end
    end
end

%% 
Scale = unique(split(Scale), 'stable');
if Scale(end) == ""
    Scale(end) = [];
end
% After the for loop, the scale string should only consist of the main note
% and the harmonics.
pitch = Scale(1,1); % pitch of the note.


%% 
figure
periodogram(signal, [], [], fs);
figure
spectrogram(signal, 8192, [], [], fs, 'yaxis');colormap;
title('Spectrogram of Sound Wave with Single Pitch')
end
