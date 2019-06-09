[y,fs] = audioread("Test Audio Files/Complexity/Sheep sound_trimmed_0-10.wav");
mono = y(1:end, 1);
samples = 1:size(mono);
t = (1:size(mono))/fs;
cosfunction = cos(1000*2*pi*t);
#sound(cosfunction, fs)
cosfunction = cosfunction(1: (fs/1000)*2);
t = t(1:(fs/1000)*2);
figure (1);
plot(samples, mono)
figure (2);
plot(t, cosfunction)
