function [psdx, freq] = CalculatePSD(x, dt)
    fs = 1 / dt;  
    N = length(x);
    xdft = fft(x);
    xdft = xdft(1:N/2+1); % only +ve side
    psdx = (1/(fs*N)) * abs(xdft).^2;
    psdx(2:end-1) = 2*psdx(2:end-1);
    freq = 0:fs/length(x):fs/2;
end