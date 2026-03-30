close all; clear all;

fs = 8000; % sampling frequency
fp = 1500; % passband edge frequency
fn = 500; % transition width of the filter
As = 40; % stopband attenuation

h_lpf = designfilt('lowpassfir', 'PassbandFrequency', fp, 'StopbandFrequency', fp+fn, 'PassbandRipple', 1, 'StopbandAttenuation', As, 'SampleRate', fs);
b_lpf = h_lpf.Coefficients;

x1=importdata('input_24bits.txt');

y = filter(h_lpf, x1);
y_p = sum(y.^2);

%% fixed point 
x2=importdata('input_8bits.txt');
wl = [8:2:20]; % wordlength
fl = [7:2:19]; % % fractionlength
noise = zeros(size(wl)); % power of different between y and y_fixed
snr = zeros(size(wl));

for m = 1:length(wl)
    m
	b_fixed = sfi(b_lpf, wl(m), fl(m)); % Filter coefficients
	x_fixed = sfi(x2, 8, 7);     % Input data
	z_fixed = sfi(zeros(size(b_fixed)), 8, 7);        % Used to store the states
	y_fixed = sfi(zeros(size(x_fixed)), 8+wl(m), 7+fl(m));      % Initialize Output data
	for n = 1:length(x_fixed)
		acc = sfi(0, 8+wl(m), 7+fl(m)); % Reset accumulator
		z_fixed(1) = x_fixed(n);        % Load input sample
		for k = 1:length(b_fixed)
			acc = accumpos(acc,b_fixed(k).*z_fixed(k)); % Multiply and accumulate
		end
		z_fixed(2:end) = z_fixed(1:end-1); % Update states
		y_fixed(n) = acc;            % Assign output
	end
	
	noise(m) = sum((y-y_fixed).^2);
	snr(m) = 10*log(y_p/noise(m));
end

plot(wl, snr);
xlabel('wordlength(bits)');
ylabel('SNR');