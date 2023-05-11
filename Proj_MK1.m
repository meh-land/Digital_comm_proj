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
% # of samples in the waveform
m = 20;
S1 = ones(1,m);
S2 = zeros(1,m);
% time of sampling at reciever
taw = 17;
%%
%Signal Generation:
%This part is meant for experimentation only, as it uses known inputs;
%to extract predictable outputs.

%(2)-Binary Data Vector
known_message = [1, 0, 1, 1, 0, 1, 0, 0, 1, 0]; %A binary message meant to be sent

%(3)-Concatenting using S1, S2
conc_waveform = []; %Setting a placeholder for the resultant waveform

%The for loop checks every element in the known message, concatenating with
%S1 or S2 accordingly.
for i = 1:size(known_message,2)
    if known_message(i) == 1
        conc_waveform = [conc_waveform S1];
    else
        conc_waveform = [conc_waveform S2];
    end
end
%%
%(4)-Noise
Rx_sequence = awgn(conc_waveform,SNR(1),'measured');
n = 0:size(Rx_sequence,2)-1;
figure;
stem(n,conc_waveform)
hold
stem(n,Rx_sequence)
legend('Original Signal','Signal with AWGN')

%% 
%(5)-Convolution:
%A - Normal Conv:
h_mf = 0.1*(S1 - S2);
MF_out = [];
for i = 1:size(known_message,2)
   n1 = (i-1)*m + 1 ;
   n2 = i*m;
   MF_out(n1:n2) =  cconv(h_mf, Rx_sequence(n1:n2), m);
end
figure
stem(n,MF_out)
title("Output of MF");

%(5) Decision:
Vth = S1(taw) - S2(taw);
MF_out_decided = zeros(1, length(known_message));
for i = 1:size(known_message,2)
   n1 = (i-1)*m + 1 ;
   n2 = i*m;
   current_sample = MF_out(n1 + taw - 1);
   if (current_sample > Vth)
       MF_out_decided(i) = 1;
   end
end

%% Get BER
% get number of errors
err_num = sum(xor(known_message, MF_out_decided));