A = LogScale(8, 400, 7000, 1.2, 0.05);
Filter = IIR_Filter_Bank(A,6,"ellip",20);
writeFilteredSignal("Rhythm/Country - Our Song.wav", Filter, A(:, 5));

function writeFilteredSignal(fileName, filterBank, centreFrequencies)

% Read the audio sample and filter 
[y1,fs] = audioread(fileName);
y = y1;
samples = 1:size(y);
bankSize = size(filterBank,2);
filteredSignal = zeros(size(y,1),bankSize);
for i = 1:bankSize
    filteredSignal(:,i) = filter(filterBank(i),y);
end

filteredSignal = abs(filteredSignal);

% Generate 400 Hz LPF
hLPF = fdesign.lowpass(2, 3, 1, 80, 16000);
HdLPF = design(hLPF, 'butter', 'MatchExactly', 'stopband');

% Generate final envelop by filtering rectified signal
envelopedSignal = filter(HdLPF, filteredSignal);
%%
t = (1:size(envelopedSignal(:,1)))/16000;
cosWaves = cos(2 * pi * t' .* centreFrequencies');
amplitudeModulatedSignals = cosWaves .* envelopedSignal;
%%
output = sum(amplitudeModulatedSignals');
output = output/max(output);
%plot(t, output)
%plotFFT(output, 16000)
%soundsc(output, 16000)
name = convertStringsToChars(fileName);
name = name(1:end-4);
newFile = strcat('OutputSignals/',name, '_filtered.wav');
newFile = convertStringsToChars(newFile);
audiowrite(newFile, output, 16000);
end

function filterBank = IIR_Filter_Bank(freqs,order,type,stopgain)
% type can be 'butter', 'ellip', 'cheby1', or 'cheby2'
close all;
%%
dim = size(freqs);      % Dimensions of freqs matrix
%%
Fs1 = freqs(:,1);    % Lower Stop Frequency
Fp1 = freqs(:,2);    % Lower Pass Frequency
Fp2 = freqs(:,3);    % Upper Pass Frequency
Fs2 = freqs(:,4);    % Upper Stop Frequency
%%
n = dim(1);             % Number of filters
if(mod(order,2) == 1)
    error('Filter order must be even for Bandpass Filter.')
end
FType = validatestring(type, ["butter", "ellip", "cheby1", "cheby2"]);

%% Make filter bank array of filter objects
h  = fdesign.bandpass('N,F3dB1,F3dB2', 2, 100, 200, 16000);
Hd = design(h, 'butter');
filterBank = repmat(Hd,1,n);

%% Generate filters based on passband frequencies
for i = 1:n
    % All frequency values are in Hz.
    N   = order;        % Order
    Fpass1 = Fp1(i);    % First Cutoff Frequency
    Fpass2 = Fp2(i);    % Second Cutoff Frequency
    Fstop1 = Fs1(i);    % First Stop Frequency
    Fstop2 = Fs2(i);    % Second Stop Frequency
    Apass = 1;          % Passband ripple (dB)
    Astop = stopgain;   % Stopband attenuation (dB)
    Fs = 16000;         % Sampling Frequency, constant
    
    switch type
        case 'butter'
            h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fpass1, Fpass2, Fs);
        case 'cheby1'
            h  = fdesign.bandpass('N,Fp1,Fp2,Ap', N, Fpass1, Fpass2, Apass, Fs);
        case 'cheby2'
            h  = fdesign.bandpass('N,Fst1,Fst2,Ast', N, Fstop1, Fstop2, Astop, Fs);
        case 'ellip'
            h  = fdesign.bandpass('N,Fp1,Fp2,Ast1,Ap,Ast2', N, Fpass1, Fpass2, ...
                      Astop, Apass, Astop, Fs);
        otherwise
            warning("Invalid filter type entered.")
    end
    filterBank(i) = design(h, type);
 
end
end

function Frequencies = LogScale(N, Start, End, Coverage, Wing)
    A = zeros(N, 5);
    ScalingFactor = End/Start;
    for i = 0:(N-1)
       left = Start * ScalingFactor^(i/N);
       right = Start * ScalingFactor^((i+1)/N);
       start = (Coverage * (left - right) + ((Coverage * (left-right))^2 + 4 * right * left)^0.5)/2;
       stop = right * left / start;
       A(i + 1, 2) = start;
       A(i + 1, 3) = stop;
       A(i + 1, 1) = start * (start/stop)^Wing;
       A(i + 1, 4) = stop * (stop/start)^Wing;
    end
    A(:, 5) = (A(:, 2) .* A(:, 3)).^0.5;
Frequencies = A;
end