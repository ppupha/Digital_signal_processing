% Main function
function lab2()

    % Input parameters
    T = 2.0;
    sigma = 0.5;

    % Borders of calculation
    delta = 5;
    t = -delta:0.05:delta;
    %disp(t);
    
    %delta = 100;
    %t = 0:1:delta;

    % Calculation of pulse functions
    x1 = zeros(size(t));
    x1(abs(t) - T < 0) = 1;
    x1(abs(t) == T) = 0.5;
    
    x2 = exp(-(t / sigma).^2);
    
    
    % without "twin" effect
    x1_1 = zeros(size(t));
    x2_1 = zeros(size(t));
    for i = 1:length(t)
        x1_1(i) = ((-1) ^ i) * x1(i);
        x2_1(i) = ((-1) ^ i) * x2(i);
    end;

    % FFT of functions (with "twin" effect)
    y_rec = fft(x1);
    y_gauss = fft(x2);

    % FFT of functions (without "twin" effect)
    y_rec_without_twin = fft(x1_1);%fftshift(y_rec);
    y_gauss_without_twin = fft(x2_1);%fftshift(y_gauss);

    % DFT of functions (with "twin" effect)
    z_rec = dft(x1);
    z_gauss = dft(x2);

    % DFT of functions (without "twin" effect)
    z_rec_without_twin = dft(x1_1);%fftshift(z_rec);
    z_gauss_without_twin = dft(x2_1);%fftshift(z_gauss);

    %
    % PLOTTING
    %

    xs = 0:length(t) - 1;

    figure (1);
    subplot(2, 1, 1);
    plot(xs, abs(y_rec) / length(xs), xs, abs(y_rec_without_twin) / length(xs));
    title('Rect: FFT');
    legend('With "twin" effect', 'Without "twin" effect');
    subplot(2, 1, 2);
    plot(xs, abs(z_rec) / length(xs), xs, abs(z_rec_without_twin) / length(xs));
    title('Rect: DFT');
    legend('With "twin" effect', 'Without "twin" effect');

    figure (2);
    subplot(2, 1, 1);
    plot(xs, abs(y_gauss) / length(xs), xs, abs(y_gauss_without_twin) / length(xs));
    title('Gauss: FFT');
    legend('With "twin" effect', 'Without "twin" effect');

    subplot(2, 1, 2);
    plot(xs, abs(z_gauss) / length(xs), xs, abs(z_gauss_without_twin) / length(xs));
    title('Gauss: DFT');
    legend('With "twin" effect', 'Without "twin" effect');

end

% Discrete Fourier Transform function
function y = dft(x)
    a = 0:length(x) - 1;
    b = -2 * pi * sqrt(-1) * a / length(x);

    for i = 1:length(a)
        a(i) = 0;

        for j = 1:length(x)
            a(i) = a(i) + x(j) * exp(b(i) * j);
        end

    end

    y = a;
end
