A = LogScale(15, 300, 6000, 0.9, 0.1);
Filters = IIR_Filter_Bank(A(:, 1:4), 6, 'cheby2', 21);
writeFilteredSignal('Complexity/COW SOUNDS FOR KIDS COWS GO MOO_trimmed_1-10.wav', Filters, A(:, 5));