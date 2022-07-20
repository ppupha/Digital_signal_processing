function lab1()
    % Discrete signal
    n = 100; % input('n: ');
    dt = 1; % input('dt: ');
    t_max = dt * (n - 1) / 2;
    t = -t_max:dt:t_max;

    % Signal data
    L = randi(3, 1, 1);
    sigma = randi(2, 1, 1);
    A = 1;

    % Discrete signal
    gauss_discrete = A * exp(-(t / sigma).^2);
    
    rect_discrete = zeros(size(t)) + 1;
    %rect_discrete(abs(t) - abs(L) < 0) = 1;

    % Real signal
    x = -t_max:0.005:t_max;
    gauss_ref = exp(-(x / sigma).^2);
    rect_ref = zeros(size(x));
    rect_ref(abs(x) - abs(L) < 0) = 1;

    % Signal restore
    gauss_restored = zeros(1, length(x)); % one-dimensional array, all 0
    rect_restored = zeros(1, length(x)); % one-dimensional array, all 0

    for i = 1:length(x)
        for k = 1:n
            gauss_restored(i) = gauss_restored(i) + gauss_discrete(k) * sin((x(i)-t(k))/dt * pi) / ((x(i)-t(k))/dt * pi);
            rect_restored(i) = rect_restored(i) + rect_discrete(k) * sin((x(i)-t(k))/dt * pi) / ((x(i)-t(k))/dt * pi);
        end

    end

    figure;
    subplot(2, 1, 1);
    title('1st signal: Rectangular function');
    xlabel('x')
    ylabel('u(x)')
    hold on; grid on;
    plot(x, rect_ref, 'b');
    plot(x, rect_restored, 'g');
    plot(t, rect_discrete, '.r');
    legend('Real', 'Restored', 'Discrete');

    subplot(2, 1, 2);
    title('2nd signal: Gaussian');
    xlabel('x')
    ylabel('u(x) / A')
    hold on; grid on;
    plot(x, gauss_ref, 'b');
    plot(x, gauss_restored, 'g');
    plot(t, gauss_discrete, 'r');
    plot(t, gauss_discrete, '.r');
    %stem(t, gauss_discrete, 'r');
    legend('Real', 'Restored', 'Discrete');
    %legend('Restored', 'Discrete');
