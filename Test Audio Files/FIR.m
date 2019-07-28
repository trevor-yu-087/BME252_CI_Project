function Filters = FIR(A, order)

N      = order;     % Order
Fstop1 = A(1, 1);   % First Stopband Frequency
Fpass1 = A(2, 1);   % First Passband Frequency
Fpass2 = A(3, 1);  % Second Passband Frequency
Fstop2 = A(4, 1);  % Second Stopband Frequency
Wstop1 = 1;      % First Stopband Weight
Wpass  = 1;    % Passband Weight
Wstop2 = 1;      % Second Stopband Weight
dens   = 20;     % Density Factor
Fs     = 16000;

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, [0 Fstop1 Fpass1 Fpass2 Fstop2 Fs/2]/(Fs/2), [0 0 1 1 0 ...
           0], [Wstop1 Wpass Wstop2], {dens});
Filters = [dfilt.dffir(b)];
for i = 2:size(A, 1)
   b  = firpm(N, [0 A(i,1) A(i,2) A(i,3) A(i,4) Fs/2]/(Fs/2), [0 0 1 1 0 ...
           0], [Wstop1 Wpass Wstop2], {dens});
   Filters = cat(2, Filters, [dfilt.dffir(b)]);
end

% [EOF]
