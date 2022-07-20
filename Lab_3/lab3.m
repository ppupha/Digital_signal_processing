function lab3()

    % Input parameters
    T = 2.0;
    sigma = randi(2, 1, 1);

    % Borders of calculation
    mult = 5;
    step = 0.05;
    t = -mult:step:mult;

    % Pulse generation
    x1 = [rectpls(t, T) zeros(1, length(t))];
    x2 = [gauspls(t, sigma) zeros(1, length(t))];
    
    x3 = [rectpls(t, T / 2) zeros(1, length(t))];
    x4 = [gauspls(t, sigma / 2) zeros(1, length(t))];
    

    % Convolution.
    y1 = ifft(fft(x1) .* fft(x2)) * step;
    y2 = ifft(fft(x1) .* fft(x3)) * step;
    y3 = ifft(fft(x2) .* fft(x4)) * step;
    
    sizeT = length(t);
    % Normalize convolution
    start = fix((length(y1) - length(t)) / 2);
    y1 = y1(start + 1:start + length(t));
    y2 = y2(start + 1:start + length(t));
    y3 = y3(start + 1:start + length(t));

    figure(1)
    xlabel('mult')
    ylabel('u(x) / A')
    plot(t, x1(1:sizeT), 'g', t, x2(1:sizeT), 'b', t, y1(1:sizeT), 'r');
    title('Rectangular and Gaussian convolution');
    legend('Pulse 1', 'Pulse 2', 'Convolution');

    figure(2)
    plot(t, x1(1:sizeT), 'g', t, x3(1:sizeT), 'b', t, y2(1:sizeT), 'r');
    title('Twice Rectangular convolution');
    legend('Pulse 1', 'Pulse 2', 'Convolution');

    figure(3)
    plot(t, x2(1:sizeT), 'g', t, x4(1:sizeT), 'b', t, y3(1:sizeT), 'r');
    title('Twice Gaussian convolution');
    legend('Pulse 1', 'Pulse 2', 'Convolution');
    
    %t2 = [-mult * 2:step:mult * 2 mult * 2 + step];
    %fprintf("X1 = %d, X2 = %d, Y1 = %d, T = %d", length(x1), length(x2), length(y1), length(t2));

    %figure(4)
    %plot(t2, x2, 'k', t2, x4, 'b', t2, y3, 'r');
    %title('Twice Gaussian convolution');
    %legend('Pulse 1', 'Pulse 2', 'Convolution');

end

% Rectangular pulse generation
function y = rectpls(x, T)
    y = zeros(size(x));
    y(abs(x) - T < 0) = 1;
    y(abs(x) == T) = 1/2;
end

% Gaussian pulse generation
function y = gauspls(x, s)
    y = exp(-(x / s).^2);
end
