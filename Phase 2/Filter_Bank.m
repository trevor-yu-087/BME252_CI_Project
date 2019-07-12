close all;
Fpass = 450;
Filter1 = fdesign.bandpass(Fpass1 - 50, Fpass1, Fpass1 * (19^scale), Fpass1 * (19^scale) + 50, Astop1, Apass, Astop2, Fs);
dF1 = design(Filter, 'ellip', 'MatchExactly', 'both');
filterBank = [dF1, dF1, dF1, dF1, dF1, dF1, dF1, dF1, dF1];
for i = 1:9
    Filter = fdesign.bandpass(Fpass - 50, Fpass, Fpass * (19^0.1), Fpass * (19^0.1) + 50, Astop1, Apass, Astop2, Fs);
    designedFilter = design(Filter, 'ellip', 'MatchExactly', 'both');
    filterBank(i)= designedFilter;
    Fpass = Fpass*(19^0.1);
end

[y1,fs] = audioread("Taylor Swift - Our Song_trimmed_35-52.wav");
y = y1;
samples = 1:size(y);
plot(samples, y)
filteredSignal = zeros(size(y,1),8);
for i = 1:9
    filteredSignal(:,i) = filter(filterBank(i),y);
end
figure(1);
plot(samples, filteredSignal(:,1));
figure(2);
plot(samples, filteredSignal(:,9));
filteredSignal = abs(filteredSignal);
figure(3);
plot(samples, filteredSignal(:,1));

hLPF = fdesign.lowpass(400, 450, 1, 80, 16000);
HdLPF = design(hLPF, 'ellip', 'MatchExactly', 'both');
envelopedSignal = filter(HdLPF, filteredSignal);
figure(4);
plot(samples, envelopedSignal(:,1));
figure(5);
plot(samples, envelopedSignal(:,9));


 
 
