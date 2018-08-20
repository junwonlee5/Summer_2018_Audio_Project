function [Scale, Pitch] = livecheck()
%{
The following function is essentially a tuner: it records the voice for three seconds and finds the
pitch of the voice. It uses the Pitch_Detection function. 
%}
Fs = 44100;
recObj = audiorecorder(Fs, 16, 2);
disp('Start singing in 3.')
pause(1)
disp('2')
pause(1)
disp('1')
pause(1)
disp('Start singing.')
recordblocking(recObj, 3);
disp('End of Recording.');
y = getaudiodata(recObj);
filename = 'recorded voice.wav';
audiowrite(filename,y,Fs);
[Scale, Pitch] = Pitch_Detection(filename);
disp('The pitch is ' + Pitch);
end
