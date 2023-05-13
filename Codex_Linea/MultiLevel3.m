function MultiLevel3(r, bitrate)
    T = length(r) / bitrate; % bits / (bits/sec) = time in sec
    plot_precision = 100; % samples/bit
    N = plot_precision*length(r); % samples/bit * bits = samples
    dt = T/N; % time/sample (time for each sample)
    t = 0:dt:T;
    x = zeros(1,length(t)); % output signal
    
    % Storing the first element
    if r(1) == 1
        x((1):(plot_precision)) = 1;
    else % == 0
        x((1):(plot_precision)) = 0;
    end
    temp = r(1); % to store previous signal level
    code_dir = 1; % 1 for up, 0 for down
    
    for i = 1:length(r)-1
        if r(i+1) == 1 % (checking this nibba)
            % if the current value is 1 and next is also 1
            if (temp == 1) && (code_dir == 1) % if at 1, make it go down
                code_dir = 0;
            elseif (temp == -1) && (code_dir == 0) % if at -1, make it go up
                code_dir = 1;
            end
            if code_dir == 0 % down
                temp = temp - 1;
                if (temp < -1)
                    temp = -1;
                end
            else % up
                temp = temp + 1;
                if (temp > 1)
                    temp = 1;
                end
            end
            x((i*plot_precision+1):((i+1)*plot_precision)) = temp;
        else
            x((i*plot_precision+1):((i+1)*plot_precision)) = temp;
        end
    end
    
    figure
    subplot(2,1,1);  
    plot(t,x)
    title('MLT-3')
    axis([0 (length(r)/bitrate) -1.5 1.5]);
    xlabel("Time (s)");
    ylabel("Voltage (V)");
    
    [psdx, freq] = CalculatePSD(x, dt);
    psdx_db = pow2db(psdx);
    
    max_index = find(psdx_db == max(psdx_db));
    bandwidth_index = find(psdx_db(max_index+1:end) < (psdx(max_index) - 3));
    bandwidth_MLT3 = freq(bandwidth_index(1) + max_index)
    
    subplot(2,1,2);
    plot(freq,psdx_db);
    title('MLT-3 PSD');
    xlabel("Frequency (Hz)");
    ylabel("Power/Frequency (dB/Hz)");
end
