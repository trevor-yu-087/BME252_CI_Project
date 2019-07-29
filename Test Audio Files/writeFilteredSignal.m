function writeFilteredSignal(fileName, filterBank, centreFrequencies,newNameIndex)

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
hLPF = fdesign.lowpass(400, 450, 1, 80, 16000);
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
newFile = strcat('TestSignals/',name, '_', int2str(newNameIndex), '_filtered.wav');
newFile = convertStringsToChars(newFile);
audiowrite(newFile, output, 16000);
end
