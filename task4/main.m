clear, clc

T1 = 0.7;
K1 = 1.6;
K = 1;
t1 = tiledlayout(5, 4);
title(t1, "LR 04");
nexttile([2, 2])
w=0:0.1:5;
color_index = 0;
legends_ = [];
T_list = [];
K_list = [];
i = 0;
hold on

for T = 0.1:0.35:5
    Njw= T1* T *((w.*j).^3)+ T +T1*((w.*j).^2)+(w.*j)+K1*K;
    Re = real(Njw);
    Im = imag(Njw);
    my_plot = plot(Re, Im);
    my_plot.LineWidth = 2;
    my_color = [1 - color_index*0.07, 0, 0 + color_index*0.07];
    my_plot.Color = my_color;
    legends_ = [legends_, ("T = " + num2str( T ))];
    xlabel('Re(W)')   
    ylabel('Im(W)')
    title("Годограф Михайлова")
    color_index = color_index + 1;
end
for T = 0.1:0.01:5
    for k = 0.001:0.01:5
        Njw= T1*T*((w.*j).^3)+T+T1*((w.*j).^2)+(w.*j)+K1*k;
        Re_ = real(Njw);
        Im_ = imag(Njw);
        zer = find(abs(Re_) == min(abs(Re_)));
        if abs(Re_(zer)) < 0.02 && abs(Im_(zer)) <= 0.02
            T_list = [T_list, T];
            K_list = [K_list, k];
            break
        end
    end
end
plot(zeros(1, 9), -5:1:3, '-k');
plot(-20:1:5, zeros(1, 26), 'k');
xline(0, 'k-');
yline(0, 'k-');
legends_ = [legends_, "Y_A_X_I_S", "X_A_X_I_S"];
legend(legends_)
hold off
grid on
axis([-15 10 -20 3])
nexttile([2, 2])
pplot = plot(K_list, T_list);
pplot.LineWidth = 2;
xlabel("T")
ylabel("K(T)")
grid on
axis([-0.1 5 0 1.1])
title("Отношение K(T)")
hold on
pplot1 = plot(0.761, 0.56, '*k');
pplot1.LineWidth = 1;
pplot2 = plot(0.3, 0.3, '*r');
pplot2.LineWidth = 1;
pplot3 = plot(1.5, 0.7, '*b');
pplot3.LineWidth = 1;

text(0.791, 0.59, "A_2: (0.761, 0.56)", "Color", "black", 'FontSize', 14)
text(0.33, 0.33, "A_1: (0.5, 0.4)", 'Color', 'red', 'FontSize', 14)
text(1.53, 0.73, "A_3: (0.85, 0.7)", 'Color', 'blue', 'FontSize', 14)
hold off
k_check = [0.3, 0.56, 0.7];
t_check = [0.3, 0.761, 1.5];
colors = ["-r", "-k", "-b"];

% step
nexttile([1, 2]);
hold on
for iterator = 1:1:3
    K = k_check(iterator);
    T = t_check(iterator);
    KS = tf(K1*K, [T1*T, (T+T1), 1, K1*K]);
    [y1, tOut] = step(KS, 4);
    plot(tOut, y1, colors(iterator));
end
legend('A_1', 'A_2', 'A_3')
grid on
title('Реакция на единичное воздействие "step"')
xlabel('t, c');
ylabel('x(t)');
hold off

%Реакция на impulse
nexttile([1, 2]);
hold on
for iterator = 1:1:3
    K = k_check(iterator);
    T = t_check(iterator);
    KS = tf(K1*K, [T1*T, (T+T1), 1, K1*K]);
    [y1, tOut] = impulse(KS, 4);
    plot(tOut, y1, colors(iterator));
end
legend('A_1', 'A_2', 'A_3')
grid on
title('Реакция на единичное воздействие "impulse"')
xlabel('t, c');
ylabel('x(t)');
hold off

% ЛАЧХ
nexttile([1, 2])
hold on
for iterator = 1:1:3
    K = k_check(iterator);
    T = t_check(iterator);
    KS = tf(K1*K, [T1*T, (T+T1), 1, K1*K]);
    [mag, ph, wout] = bode(KS, colors(iterator));
    mag = squeeze (mag);
    semilogx(wout, mag2db(abs(mag)));
end
plot([0 4], [0 0], '-k')
legend('A_1', 'A_2', 'A_3', 'axis')
grid on
title ('ЛАЧХ');
ylabel ('Амплитуда, ДБ');
xlabel ('Частота, Гц');
axis([0 4 -40 15])
hold off

% ЛФЧХ
nexttile(17, [1, 2])
hold on
for iterator = 1:1:3
    K = k_check(iterator);
    T = t_check(iterator);
    KS = tf(K1*K, [T1*T, (T+T1), 1, K1*K]);
    [mag, phase, wout] = bode(KS, colors(iterator));
    phase = squeeze (phase);
    semilogx(wout, phase);
end
plot([0 4], [-180 -180], '-k')
legend('A_1', 'A_2', 'A_3', 'axis')
grid on
title ('ЛФЧХ')
ylabel ('Фаза, градусы');
xlabel ('Частота, Гц');
axis([0 4 -250 5])
hold off

% Годограф Найквиста
nexttile(15, [2, 2])
k = 1000;
w = linspace(-k, k, 500*k);
hold on
for iterator = 1:1:3
    K = k_check(iterator);
    T = t_check(iterator);
    KS = tf(K1*K, [T1*T, (T+T1), 1, K1*K]);
    [re, im, wout] = nyquist(KS, w, colors(iterator));
    re = squeeze(re);
    im = squeeze(im);
    plot(re, im)
end
plot(-1, 0, '+r')
legend('A_1', 'A_2', 'A_3', "Critical Point")
grid on
title('Годограф Найквиста')
xlabel('Действительная ось');
ylabel('Мнимая ось');
hold off
