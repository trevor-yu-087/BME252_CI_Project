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

