clear all
FileName = 'clarinet random.wav';
[signal,fs] = audioread(FileName);
p = signal(:,1);
wavbinary = dec2bin(typecast( single(p), 'uint8'), 8 ) - '0';
orig_size = size(p);
t = (0:1/fs:(length(signal)-1)/fs);
plot(t,p); %plots the signal over time)
sound(p, fs); %plays the sound
xlabel('Time (seconds)')
ylabel('Amplitude')
title('Sound Wave')
set(gca,'YLim',[-1 1])
% string = 'Mary had a little lamb';
% binary = str2num(dec2bin(string));
% [m,n] = size(binary);
% for i = 1:m
% a=[str2double(regexp(num2str(binary(i,1)),'\d','match'))];
% binary(i,1) = 0;
% binary(i,1:length(a)) = a ;
% end
A = ('The wave equation is a physical model for small amplitude modulations of a string under uniform tension in which the restoring force acts in the transverse direction and scales like the spatial curvature of the string.');
int = uint8(A); 
bin = dec2bin(int);
binary = str2num(bin);
[m,n] = size(binary);
%% 

for i = 1:m
a=[str2double(regexp(num2str(binary(i,1)),'\d','match'))];
%binary(i,1) = 0;
if length(a) == 7
binary(i,1:length(a)) = a ;
else
    a = [zeros(7-length(a)),a];
    binary(i,1:length(a)) = a;
end
end
%% 

[m,n] = size(binary);
binlist = zeros(1, m*n);
for i = 1:m
binlist(1,1+(i-1)*n:i*n) = binary(i,:);
binlist';
end
newwavlist = wavbinary;
newwavlist(1:length(binlist), 8) = binlist;
newwavdata = reshape( typecast(uint8(bin2dec( char(newwavlist + '0') )), 'single'), orig_size );
plot(t,newwavdata); %plots the signal over time)
sound(newwavdata, fs); %plays the sound
xlabel('Time (seconds)')
ylabel('Amplitude')
title('Encrypted Sound Wave')
set(gca,'YLim',[-1 1])

%% 

decodenewbinary = dec2bin(typecast( single(newwavdata), 'uint8'), 8 ) - '0';
decodemessage = decodenewbinary(1:length(A)*7, 8);
phase1 = reshape(decodemessage,7,[]);
phase2 = num2str(phase1.');
phase3 = bin2dec(phase2);
out= char(phase3);
out.'
% out=char(bin2dec(num2str(reshape(decodemessage,7,[])).'));
% out = out';
%audiowrite('Encrypted clarinet random.wav', newwavdata, fs)
%message = char(bin2dec(bin));