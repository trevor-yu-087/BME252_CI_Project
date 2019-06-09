[y,fs] = audioread("audiofiles/Complexity/Sheep sound.ogg");
mono = y(1:end, 1) + y(1:end, 2);
sound(mono, fs);