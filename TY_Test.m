% filename = 'Pitch Accuracy/Let it Go (edited for tenors)_trimmed_58-86.wav'
% filename = 'Rhythm/Pachelbel - Canon In D Major. Best Version._trimmed_139-153.wav'
% filename = 'Rhythm/Alan Walker & Alex Skrindo -_trimmed_60-75.wav'
% filename = 'Rhythm/Survivor - Eye Of The Tiger (Official Music Video)_trimmed_85-104.wav'
% filename = 'Intensity/Ambulance Siren Effect - Great Siren_trimmed_10-25.wav'
filename = 'Rhythm/QueenAnother One Bites The Dust Lyrics_trimmed_60-75.wav'
% freqs = linearFilterBands(9,400,7500,0.25,0.05);
freqs = LogScale(9,400,7500,0.25,0.05);
% filters = FIR(freqs,6);
filters = IIR_Filter_Bank(freqs,10,'cheby2',20);
writeFilteredSignal(filename, filters, freqs(:,5))