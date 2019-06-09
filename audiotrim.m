function audiotrim(filename, time1, time2)
  [y,fs] = audioread(strcat("/audiofiles/",filename));
  disp(size(y))
  disp(strcat("Trimming ", filename, " from ", time1, "s to ", time2, "s."))
endfunction