[y,fs] = audioread("C:/Users/thoma/Desktop/2B/BME 252/BME252_CI_Project/audiofiles/Ambulance Siren Effect - Great Siren.ogg");
mono = y(1:end,1) + y(1:end,2);
mono = mono(1:end);
sound(mono,fs)
%%