close all;
Fpass = 400;

%Equiripple filter constants
Dstop1 = 0.001;           % First Stopband Attenuation
Dpass  = 0.057501127785;  % Passband Ripple
Dstop2 = 0.001;           % Second Stopband Attenuation
dens = 20;                % Density Factor
Fs = 16000;               % Sampling Frequency             

% Make filter bank array of filter objects
[N, Fo, Ao, W] = firpmord([100 200 300 400]/(Fs/2), [0 1 ...
                          0], [Dstop1 Dpass Dstop2]);
b = firpm(N, Fo, Ao, W, {dens});
dF1 = dfilt.dffir(b);
filterBank = [dF1, dF1, dF1, dF1, dF1, dF1, dF1, dF1, dF1];
%% I don't know if the dF1 type will store the new kind of filter, may need to make a 
%% junk FIR filter to replace here. 



% Generate 9 filters spaced logarithmically apart
for i = 1:9
    % Calculate order using FIRPMORD
    [N, Fo, Ao, W] = firpmord([Fpass - 50, Fpass, Fpass * (19^0.1), Fpass * (19^0.1) + 50]/(Fs/2), [0 1 ...
    0], [Dstop1 Dpass Dstop2]);
    
    % Calculate coeffs using FIRPM function
    b = firpm(N, Fo, Ao, W, (dens));
    designedFilter = dfilt.dffir(b);
    filterBank(i) = designedFilter;
    
    %%% Prev code for reference
    %%% Filter = fdesign.bandpass(Fpass - 50, Fpass, Fpass * (19^0.1), Fpass * (19^0.1) + 50, Astop1, Apass, Astop2, Fs);
    %%% designedFilter = design(Filter, 'ellip', 'MatchExactly', 'both');
    %%% filterBank(i)= designedFilter;
    
    Fpass = Fpass*(19^0.1);
end

% Read the audio sample and filter 
[y1,fs] = audioread("Taylor Swift - Our Song_trimmed_35-52.wav");
y = y1;
samples = 1:size(y);
plot(samples, y)
filteredSignal = zeros(size(y,1),8);
for i = 1:9
    filteredSignal(:,i) = filter(filterBank(i),y);
end
% Plot lowest frequency and highest frequency bands
figure(1);
plot(samples, filteredSignal(:,1));
figure(2);
plot(samples, filteredSignal(:,9));

% Recitfy signal 
filteredSignal = abs(filteredSignal);
figure(3);
%%% plot(samples, filteredSignal(:,1));

% Generate 400 Hz LPF
hLPF = fdesign.lowpass(400, 450, 1, 80, 16000);
HdLPF = design(hLPF, 'butter', 'MatchExactly', 'stopband');

% Generate final envelop by filtering rectified signal
envelopedSignal = filter(HdLPF, filteredSignal);

% Plot lowest and highest frequency bands of the envelope
figure(4);
plot(samples, envelopedSignal(:,1));
figure(5);
plot(samples, envelopedSignal(:,9));


 
 
