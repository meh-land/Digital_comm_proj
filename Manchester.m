function Manchester(r, bitrate)
    T = length(r) / bitrate; % bits / (bits/sec) = time in sec
    plot_precision = 100; % samples/bit
    N = plot_precision*length(r); % samples/bit * bits = samples
    dt = T/N; % time/sample (time for each sample)
    t = 0:dt:T;
    x = zeros(1,length(t)); % output signal
    
    for i = 0:length(r)-1
        if r(i+1) == 1
            x(i*plot_precision+1:(i+0.5)*plot_precision) = 1;
            x((i+0.5)*plot_precision+1:(i+1)*plot_precision) = -1;
        else
            x(i*plot_precision+1:(i+0.5)*plot_precision) = -1;
            x((i+0.5)*plot_precision+1:(i+1)*plot_precision) = 1;
        end
    end
    
    figure
    subplot(2,1,1); 
    plot(t,x)
    title('Manchester')
    axis([0 (length(r)/bitrate) -1.5 1.5]);
    xlabel("Time (s)");
    ylabel("Voltage (V)");
    
    [psdx, freq] = CalculatePSD(x, dt);
    
    subplot(2,1,2);
    plot(freq,pow2db(psdx));
    title('Manchester PSD');
    xlabel("Frequency (Hz)");
    ylabel("Power/Frequency (dB/Hz)");
end