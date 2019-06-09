function retval = audio_trim (filename, time1, time2)
[y,fs] = audioread(strcat("audiofiles/",filename));
disp(size(y))
disp(strcat("Trimming ", filename, " from ", num2str(time1), "s to ", num2str(time2), "s."))
%% Convert to Mono
if(size(y)(2) == 2)
  mono = y(1:end,1) + y(1:end,2);
else
  mono = y;
endif
%% Downsample to 16 kHz
if(fs < 16000)
  disp("Signal is below 16 kHz. Find a new Signal.")
elseif(fs >= 16000)
  [rs, h] = resample(mono, 16000, fs);  
  fs = 16000;
  %% Trim signal to new size
  if(time1 >= time2 )
    disp("Start and end times invalid, please re-enter times.")
  elseif(fs*time2 > size(rs))
    disp("End time beyond duration of sound, please re=enter time.")
  else 
    rs = rs(time1*fs+1:time2*fs);
    name = substr(filename, 1, -4);
    [tok, rem] = strtok(name, "/");
    name = rem(2:end);
    audiowrite(strcat(name,"_trimmed_",num2str(time1),"-",num2str(time2),".wav"), rs, fs, 'Quality', 100);
  disp("File successfully trimmed!")
  endif
endif
endfunction
