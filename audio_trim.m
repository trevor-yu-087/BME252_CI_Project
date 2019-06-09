## Copyright (C) 2019 Trevor Yu
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} audio_trim (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Trevor Yu <Trevor Yu@DESKTOP-M0MPCL7>
## Created: 2019-06-08
## filename is audiofile in the /audiofiles directory
## time1 is start time in seconds
## time2 is end time in seconds

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
    audiowrite(strcat(substr(filename,1,-4),"_trimmed_",num2str(time1),"-",num2str(time2),".wav"), rs, fs, 'Quality', 100);
  disp("File successfully trimmed!")
  endif
endif
endfunction
