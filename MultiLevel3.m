function MultiLevel3(r)
    % Assuming a bitrate of one
    T = length(r) / 1;
    plot_precision = 200;
    N = plot_precision*length(r);
    dt = T/N;
    t = 0:dt:length(r);
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
    
    [Pxx,F] = periodogram(x);
    
    figure
    subplot(2,1,1);  
    plot(t,x)
    title('Multi-level 3')
    axis([0 length(r) -1.5 1.5]);
    
    subplot(2,1,2);
    plot(F,10*log10(Pxx))
    title('Multi-level 3 PSD')
    axis([0 3.5 -80 30]);
end
