function plotFFT(y, fs)
%close all;
Y = fft(y);
len = size(y);
L = len(1)
%%
doublespec = abs(Y/L);
singlespec = doublespec(1:L/2 +1);
singlespec(2:end-1) = 2*singlespec(2:end-1);
f = fs*(0:(L/2))/L;
figure(10);
plot(f,singlespec)
xlabel('frequency (Hz)');
ylabel('|FFT(Y)|');
end
