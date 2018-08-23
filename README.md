# Summer_2018_Audio_Project
Over the summer I self-studied signal processing and created practical functions based on what I've learned using MATLAB. 

## 1. Pitch Detection
In the first folder "Pitch Detection", there are two functions: Pitch_Detection.m and livecheck.m. 

The Pitch_Detection.m function uses the idea of Fourier transform, which decomposes any periodic time function into frequencies that constructs the original function. The function reads the audio file with single pitch, performs Fourier transform, and detects the frequencies that contribute to the construction of the signal. Once it detects all the frequencies, the function matches the closest pitches to the corresponding frequencies. This series of pitches is called harmonic series, and the lowest pitch present in this series (pitch with fundamental frequency) is the correct pitch of the note. In addition, the spectrogram and periodogram are created to further analyze the audio file.  

To run the Pitch_Detection function, type the following:

[Scale, Pitch] = Pitch_Detection('filename')

where filename is the name of the audio file. The Scale will list predominant harmonics in the pitch and Pitch will give the pitch of the audio file. 

The livecheck.m function utilizes the Pitch_Detection.m function, where it records the pitch live and immediately gives the pitch of the recorded voice. 

To run the livecheck function, type the following:

[Scale, Pitch] = livecheck()

The command window will give you a 3 second countdown, and after that it will record the voice for three seconds. Once it records, it wll save in recorded voice.wav file and display the harmonics and the Pitch, just like the Pitch_Detection function does. 

## 2. Audio Filter

In the second folder "Audio Filter", the function filter_design.m applies butterworth filter onto audio file and creates a new signal signal_filt_2. This is particularly useful to simulate the second order of Sallen-Key filter. The function requires the audio file, order of filter, the lowpass and highpass cutoff frequency, and the amplification factor. 

To run the function, type the following:

[signal_filt_2, fs, t] = filter_design(file, N_ord, lpcutoff_Hz, hpcutoff_Hz, amp_factor)

where file is the filenmae and N_ord is the order of filter. This will give the time vector, the sampling rate, and filtered signal signal_filt_2. To simply amplify the signal instead of filtering it, type 0 for lpcutoff_Hz (lowpass frequency cutoff in Hz). 

## 3. Signal Processing

The third folder "Signal Processing" has a script called Signal_Processing.m where each section of the script I learned the concepts and use them using MATLAB functions. Concepts include fourier transform, chirp, Gaussian noise, Hamming window, Gaussian window, cross-correlation, and convolution. 
