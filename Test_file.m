[y,fs] = audioread("audiofiles/DEH_WTAW.ogg");
mono = y(1:end,1) + y(1:end,2);
mono = mono(1:661500);
sound(mono,fs)
%%