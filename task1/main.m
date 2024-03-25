a0 = 5;
a1 = 4;
a2 = 2;
a3 = 1;
b0 = 5;
y0 = [0, 0, 0];
y1 = [1, 0.5, -1];
t_interval = [0 25];

[t1, X1] = ode45(@(t, X) func(t,a0,a1,a2,a3,b0,1,X), t_interval, y0);
[t2, X2] = ode45(@(t, X) func(t,a0,a1,a2,a3,b0,1,X), t_interval, y1);
[t3, X3] = ode45(@(t, X) func(t,a0,a1,a2,a3,b0,sin(t),X), t_interval, y0);
[t4, X4] = ode45(@(t, X) func(t,a0,a1,a2,a3,b0,sin(t),X), t_interval, y1);

figure(1)
plot(t1, X1(:, 1), "Color",'b','LineStyle','-','LineWidth',1)
title('Входной сигнал 1, нулевые Н.У.')
hold on
plot(t1, X1(:, 2), "Color",'g','LineStyle','--','LineWidth',1)
legend('x1(t)', 'x2(t)', Location='best')

figure(2)
plot(t2, X2(:, 1), "Color",'b','LineStyle','-','LineWidth',1)
title('Входной сигнал 1, заданные ненулевые Н.У.')
hold on
plot(t2, X2(:, 2), "Color",'g','LineStyle','--','LineWidth',1)
legend('x1(t)', 'x2(t)', Location='best')

figure(3)
plot(t3, X3(:, 1), "Color",'b','LineStyle','-','LineWidth',1)
title('Входной сигнал 2, нулевые Н.У.')
hold on
plot(t3, X3(:, 2), "Color",'g','LineStyle','--','LineWidth',1)
legend('x1(t)', 'x2(t)', Location='best')

figure(4)
plot(t4, X4(:, 1), "Color",'b','LineStyle','-','LineWidth',1)
title('Входной сигнал 2, заданные ненулевые Н.У.')
hold on
plot(t4, X4(:, 2), "Color",'g','LineStyle','--','LineWidth',1)
legend('x1(t)', 'x2(t)', Location='best')

function dXdt = func(t,a0, a1, a2, a3, b0, func, X)
    dx1 = X(2);
    dx2 = X(3);
    dx3 = 1/a3*(b0*func - a2*X(3) - a1*X(2) - a0*X(1));
    dXdt = [dx1;dx2;dx3];
end
