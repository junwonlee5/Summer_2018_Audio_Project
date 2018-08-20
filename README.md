# Summer_2018_Audio_Project
Over the summer I self-studied signal processing and created practical functions based on what I've learned using MATLAB. 

## 1. Pitch Detection
In the first folder "Pitch Detection", there are two functions: Pitch_Detection.m and livecheck.m. 

The Pitch_Detection.m function uses the idea of Fourier transform, which decomposes any periodic time function into frequencies that constructs the original function. The function reads the audio file with single pitch, performs Fourier transform, and detects the frequencies that contribute to the construction of the signal. Once it detects all the frequencies, the function matches the closest pitches to the corresponding frequencies. This series of pitches is called harmonic series, and the lowest pitch present in this series (pitch with fundamental frequency) is the correct pitch of the note. In addition, the spectrogram and periodogram are created to further analyze the audio file.  

The livecheck.m function utilizes the Pitch_Detection.m function, where it records the pitch live and immediately gives the pitch of the recorded voice. 

## 2. Audio Filter

In the second folder "Audio Filter", the function filter_design.m applies butterworth filter onto audio file and creates a new signal signal_filt_2. This is particularly used to simulate the second order of Sallen-Key filter. 
