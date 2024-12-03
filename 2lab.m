x = 0.1:1/22:1;
y = ((1 + 0.6 * sin(2 * pi * x / 0.7)) + 0.3 * sin(2 * pi * x)) / 2;

figure(1);
plot(x, y);
legend('Target')
grid on

% 5 neuronu tinklas
w1 = rand(5, 1);
w2 = rand(5, 1);
b1 = rand(5, 1);
b2 = rand(1, 1);
eta = 0.05;
Y = zeros(length(x), 1);

for j = 1 : 10000
    % Perceptrono atsakas
    for i = 1 : length(x)
        % Pasleptasis sluoksnis
        v1 = w1 * x(i) + b1;

        %Pasleptojo sluoksnio aktyvacijos funkcija
        y1 = tanh(v1);
        
        % Antras (Tsejimo sluoksnis)
        v2 = y1' * w2 + b2;

        % Tsejimo sluoksnio aktyvacijos funkcija
        y2 = v2;
        Y(i) = y2;
        
        % Skaiciuojama klaida
        e = y(i) - y2;
        
        % Svoriu atnaujinimas
        delta2 = e;

        %Paskleptojo sluoksnio klaidos gradientas
        delta1 = (1 - tanh(v1).^2) .* (w2 * delta2);
        
        % Atnaujinti svori
        w2 = w2 + eta * delta2 * y1;
        b2 = b2 + eta * delta2;
        % Pasleptasis sluoksnis
        w1 = w1 + eta * delta1 * x(i);
        b1 = b1 + eta * delta1;
    end
end

hold on
plot(x, Y);
hold off
legend('Target', 'Predicted')
%%
x_test = 0.1:1/220:1;
Y_test = zeros(length(x_test), 1);

figure(2)
plot(x, y);
legend('Target')
grid on

for i = 1 : length(x_test)
    % testavimas
    v1_test = w1 * x_test(i) + b1;

    y1_test = tanh(v1_test);
    
    v2_test = y1_test' * w2 + b2;

    y2_test = v2_test;
    Y_test(i) = y2_test;
end

hold on
plot(x_test, Y_test);
hold off
legend('Target', 'Predicted')