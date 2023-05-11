%% Digital Communications MATLAB Assignment
%% Prepared by:
    %% Ahmed Aly 19015292
    %% Ahmed Sherif 19015255
    %% Yahia Walid 19016891
    %% Youssef Mohamed 19016941
%%
clear
clc

%Part1: Matched Filter and Correlators
%(1)-Parameter Definition:
n_per_SNR = 1e5;
%SNR in dB
SNR = 0:2:30;
% Array to keep track of the BER at every SNR
BER = zeros(1, length(SNR));
% # of samples in the waveform
m = 20;
S1 = ones(1,m);
S2 = zeros(1,m);
% time of sampling at reciever
taw = 17;

%(2)-Binary Data Vector
%A binary message meant to be sent (10*10^6 because the pdf states that "the resultant vector 
% will be 10e6 samples")
number_of_bits = (10*10^6) / m;

% randi starts from 1 to some number so I generated a vector of 1s and 2s
% then subtract 1 to make it 1s and 0s
message = randi(2, 1, number_of_bits) - 1;

% The binary message will be sent as a waveform so here we set a
% placeholder for this waveform
waveform = zeros(1, length(message) * m); 
%%
%Signal Generation:
% Loop to iterate over all SNR values
for snr_i = 1:length(SNR)
    % w_i is the index of the waveform and m_i is the index of the message (1s
    % amd 0s)
    for w_i = 1:m:length(waveform)
        % I derived this equation to convert w_i to m_i...... trust me
        m_i = floor((1/m) * w_i + (1- (1/m)));
        if message (m_i) == 1
            waveform(w_i : w_i+m-1) = S1;
        else
            waveform(w_i : w_i+m-1) = S2;
        end
    end
    %
    %(4)-Noise
    % Adding awgn to the waveform
    Rx_sequence = awgn(waveform,SNR(snr_i),'measured');

    % This part graphs the signal after adding noise (useful for testing but
    % with large number of bits the graphs are useless)
    %n = 0:size(Rx_sequence,2)-1;
    % figure;
    % stem(n,waveform)
    % hold
    % stem(n,Rx_sequence)
    % legend('Original Signal','Signal with AWGN')
 
    %(5)-Convolution:
    %A - Normal Conv:
    h_mf = (S1 - S2);
    MF_out = zeros(1, length(message));
    for i = 1:size(message,2)
    n1 = (i-1)*m + 1 ;
    n2 = i*m;
    MF_out(n1:n2) =  cconv(h_mf, Rx_sequence(n1:n2), m);
    end
    % Normalize the output of the MF to make decisions accurately
    MF_out = MF_out / max(MF_out);
    
    % figure
    % stem(n,MF_out)
    % title("Output of MF");

    %(5) Decision:
    Vth = (S1(taw) + S2(taw))/2;
    MF_out_decided = zeros(1, length(message));
    for i = 1:size(message,2)
    n1 = (i-1)*m + 1 ;
    n2 = i*m;
    current_sample = MF_out(n1 + taw - 1);
    if (current_sample > Vth)
        MF_out_decided(i) = 1;
    end
    end

    % Get BER
    % get number of errors
    err_num = sum(xor(message, MF_out_decided));
    BER(snr_i) = err_num;
end

%% Graph BER vs SNR
figure
semilogy(SNR, BER);
title("BER vs SNR");
