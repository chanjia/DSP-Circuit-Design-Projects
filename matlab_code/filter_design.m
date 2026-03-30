close all; clear all;
%%%%%%%%
% Low-pass FIR filter
%%%%%%%%

fs = 8000; % sampling frequency
fp = 1500; % passband edge frequency
fn = 500; % transition width of the filter
As = 40; % stopband attenuation

h_lpf = designfilt('lowpassfir', 'PassbandFrequency', fp, 'StopbandFrequency', fp+fn, 'PassbandRipple', 1, 'StopbandAttenuation', As, 'SampleRate', fs);

% stem(h_lpf.Coefficients);
% xlabel('n');
% ylabel('h(n)');

% fvtool(h_lpf);

s=importdata('input_24bits.txt');


y = filter(h_lpf, s);

L = length(s);
f = (0:L-1)*fs/L - fs/2;

[h,w] = freqz(h_lpf);
psds = 1/fs*abs(fftshift(fft(s)));
psdy = 1/fs*abs(fftshift(fft(y)));

figure,
plot(w/2/pi*fs,abs(h),'k');hold on;
plot(f,psds, 'b'); hold on;
plot(f,psdy, 'r');
axis([0 4000 0 1.3]);
xlabel('f(Hz)');
legend('lowpass filter','input','output');
