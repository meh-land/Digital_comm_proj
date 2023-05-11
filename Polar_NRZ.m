function Polar_NRZ(r)
    % Assuming a bitrate of one
    T = length(r) / 1;
    plot_precision = 200;
    N = plot_precision*length(r);
    dt = T/N;
    t = 0:dt:length(r);
    x = zeros(1,length(t)); % output signal
    
    for i = 0:length(r)-1
        if r(i+1) == 1
            x((i*plot_precision+1):((i+1)*plot_precision)) = 1;
        else
            x((i*plot_precision+1):((i+1)*plot_precision)) = -1;
        end
    end
    
    [Pxx,F] = periodogram(x);
    
    figure
    subplot(2,1,1); 
    plot(t,x)
    title('Polar NRZ')
    axis([0 length(r) -1.5 1.5]);
    
    subplot(2,1,2);
    plot(F,10*log10(Pxx))
    title('Polar NRZ PSD')
    axis([0 3.5 -80 30]);
end