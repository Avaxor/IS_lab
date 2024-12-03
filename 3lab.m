x = 0.1:1/22:1;
y = ((1 + 0.6 * sin(2 * pi * x / 0.7)) + 0.3 * sin(2 * pi * x)) / 2;

figure(1);
plot(x, y);
legend('Target')
grid on

% 5 neuronu tinklas
w0 = rand(1, 1);
w1 = rand(1, 1);
w2 = rand(1, 1);
F1 = 0;
F2 = 0;

c1 = 0.1909;
c2 = 0.9181;
r1 = 0.3727 - 0.1909;
r2 = 0.9181 - 0.7363;
eta = 0.01;
Y = zeros(length(x), 1);

for j = 1 : 100000
    % Perceptrono atsakas
    for i = 1 : length(x)
        F1 = radial_f(x(i), c1, r1);
        F2 = radial_f(x(i), c2, r2);
        v = F1 * w1 + F2 * w2 + w0;

        % Tiesine aktyvacijos funkcija
        y0 = v;
        Y(i) = y0;
        
        % Skaiciuojama klaida
        e = y(i) - y0;

        % Atnaujinti svori
        w0 = w0 + eta * e;
        w1 = w1 + eta * e * F1;
        w2 = w2 + eta * e * F2;
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
    F1 = radial_f(x_test(i), c1, r1);
    F2 = radial_f(x_test(i), c2, r2);
    v = F1 * w1 + F2 * w2 + w0;
    Y_test(i) = v;
end

hold on
plot(x_test, Y_test);
hold off
legend('Target', 'Predicted')
%%
function v = radial_f(x, c, r)
    v = exp(-(x-c)^2/(2*r^2));
end