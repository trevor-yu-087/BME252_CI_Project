function retval = BME252_Phase_1(filename)
%% 3.1 Read files into Octave and find sampling rate
%% sample_rate is sampling rate, y is signal
[y,sample_rate] = audioread(strcat("audiofiles/",filename));
disp(strcat("Sampling rate is ", num2str(sample_rate), " samples per second."))
%% 3.2 Determine if input is stereo, convert to mono
if(size(y)(2) == 2)
  mono = y(1:end,1) + y(1:end,2);
else
  mono = y;
endif
%% 3.3 Play the sound in Octave
#sound(mono, sample_rate)
%% 3.4 Write the sound to a new file
newfilename = substr(filename, 1, -4);
[tok, rem] = strtok(newfilename, "/");
newfilename = rem(2:end);
audiowrite(strcat(newfilename,"_mono.wav"), mono, sample_rate, 'Quality', 100);
%% 3.5 Plot the sound waveform as a function of sample number
samples = 1:size(mono);
figure (1);
plot(samples, mono)
%% 3.6 If the sampling rate is not 16 kH, downsample
if(sample_rate < 16000)
  disp("Signal is below 16 kHz. Find a new Signal.")
elseif(sample_rate >= 16000)
  rs = resample(mono, 16000, sample_rate);  
  sample_rate = 16000;
endif
%% 3.7 Generate a signal using the cosine function that has the same time duration and wave length
%% as the input signal. Play the sound generated by the signal and plot two cycles as a function
%% of time.
f = 1000;
t = (1:size(rs))/sample_rate;
cosfunction = cos(2*pi*f*t);
#sound(t,costfunction)
cosfunction = cosfunction(1: (sample_rate/f)*2);  
t = t(1:(sample_rate/1000)*2);
figure (2);
plot(t, cosfunction)  
endfunction