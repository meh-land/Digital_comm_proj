m = 20;
SNR = 10;
s1 = ones(1, m);
s2 = zeros(1, m);
waveform = [s1 s2 s1 s2]; % [1 0 1 0]
Rx_sequence = awgn(waveform,SNR,'measured');
C_out = zeros(1, length(waveform));

for g=1:m:length(waveform)
    r1_sum
    C_out(g:g+m-1) = waveform(g:g+m-1) .* s1;
end