function Polar_RZ(r, bitrate)
    T = length(r) / bitrate; % bits / (bits/sec) = time in sec
    plot_precision = 100; % samples/bit
    N = plot_precision*length(r); % samples/bit * bits = samples
    dt = T/N; % time/sample (time for each sample)
    t = 0:dt:T;
    x = zeros(1,length(t)); % output signal
    
    for i = 0:length(r)-1
        if r(i+1) == 1
            x((i*plot_precision+1):((i+0.5)*plot_precision)) = 1;
            x(((i+0.5)*plot_precision+1):((i+1)*plot_precision)) = 0;
        else
            x((i*plot_precision+1):((i+0.5)*plot_precision)) = -1;
            x(((i+0.5)*plot_precision+1):((i+1)*plot_precision)) = 0;
        end
    end
        
    figure
    subplot(2,1,1); 
    plot(t,x)
    title('Polar RZ')
    axis([0 (length(r)/bitrate) -1.5 1.5]);
    xlabel("Time (s)");
    ylabel("Voltage (V)");
    
    [psdx, freq] = CalculatePSD(x, dt);
    psdx_db = pow2db(psdx);
    
    max_index = find(psdx_db == max(psdx_db));
    bandwidth_index = find(psdx_db(max_index+1:end) < (psdx_db(max_index) - 3));
    bandwidth_polarrz = freq(bandwidth_index(1) + max_index)
    
    subplot(2,1,2);
    plot(freq,psdx_db);
    title('Polar RZ PSD');
    xlabel("Frequency (Hz)");
    ylabel("Power/Frequency (dB/Hz)");
end
