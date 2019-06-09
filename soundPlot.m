[y,fs] = audioread("audiofiles/Complexity/Sheep sound.ogg");
mono = y(1:end, 1) + y(1:end, 2);
samples = 1:size(mono);
fs
t = (1:size(mono))/fs;
cosfunction = cos(1000*2*pi*t);
sound(cosfunction, fs)
cosfunction = cosfunction(1: (fs/1000)*2);
t = t(1:(fs/1000)*2);
plot(samples, mono)
scatter(t, cosfunction)
