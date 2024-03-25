K = 5;
T = 2;
T1 = 3;
T2 = 1.3;
ksi = 0.2;
modelling_time = 4;

W1 = tf(K);
W2 = tf(K, [1 0]);
W3 = tf(K, [T1 1]);
W4 = tf([T1 1], 1);
W5 = tf(K, [T2 T1*ksi 1]);
W6 = tf(K*2, [T2 T1*ksi 1]);
W7 = tf(K, [T*T T*ksi 1]); %
W8 = tf(K, [4*T*T 2*T*ksi 1]); %
W9 = tf(K, [T2 T1*ksi 1]);
W10 = tf(K, [T2 0.5*T1*ksi 1]);
W11 = tf(K, [T2 0 1]);

figure(1)
print(W1, 'Усилительное звено W1')
figure(2)
print(W2, 'Идеальное интегрирующее звено W2')
figure(3)
print(W3, 'Апериодическое звено 1-го порядка W3' )
figure(4)
subplot(2,3,3)
nyquist(W4)
legend('Реальное диф. звено 1-го порядка', Location='best')
subplot(2,3,[4 5 6])
bode(W4)
legend('Реальное диф. звено 1-го порядка', Location='best')
xlim([10^(-1) 10^(4)]);

figure(5)
subplot(2,3,1)
step(W5, 'b', W6, 'g');
legend('Колебательное звено W5 (K)','Колебательное звено W6 (K*2)', Location='best')
xlim([0 4]);
subplot(2,3,2)
impulse(W5, 'b', W6, 'g')
legend('Колебательное звено W5 (K)','Колебательное звено W6 (K*2)', Location='best')
xlim([0 4]);
subplot(2,3,3)
nyquist(W5, 'b', W6, 'g')
legend('Колебательное звено W5 (K)','Колебательное звено W6 (K*2)', Location='best')
subplot(2,3,[4 5 6])
bode(W5, 'b', W6, 'g')
legend('Колебательное звено W5 (K)','Колебательное звено W6 (K*2)', Location='best')
xlim([10^(-1) 10^(4)]);

figure(6)
subplot(2,3,1)
step(W7, 'b', W8, 'g');
legend('Колебательное звено W7 (T)','Колебательное звено W8 (T*2)', Location='best')
xlim([0 4]);
subplot(2,3,2)
impulse(W7, 'b', W8, 'g')
legend('Колебательное звено W7 (T)','Колебательное звено W8 (T*2)', Location='best')
xlim([0 4]);
subplot(2,3,3)
nyquist(W7, 'b', W8, 'g')
legend('Колебательное звено W7 (T)','Колебательное звено W8 (T*2)', Location='best')
subplot(2,3,[4 5 6])
bode(W7, 'b', W8, 'g')
legend('Колебательное звено W7 (T)','Колебательное звено W8 (T*2)', Location='best')
xlim([10^(-1) 10^(4)]);

figure(7)
subplot(2,3,1)
step(W9, 'b', W10, 'g', W11, 'r');
legend('Колебательное звено W9 (ksi)','Колебательное звено W10 (ksi/2)','Консервативное звено W11 (ksi = 0)', Location='best')
xlim([0 4]);
subplot(2,3,2)
impulse(W9, 'b', W10, 'g', W11, 'r')
legend('Колебательное звено W9 (ksi)','Колебательное звено W10 (ksi/2)','Консервативное звено W11 (ksi = 0)', Location='best')
xlim([0 4]);
subplot(2,3,3)
nyquist(W9, 'b', W10, 'g', W11, 'r')
legend('Колебательное звено W9 (ksi)','Колебательное звено W10 (ksi/2)','Консервативное звено W11 (ksi = 0)', Location='best')
subplot(2,3,[4 5 6])
bode(W9, 'b', W10, 'g', W11, 'r')
legend('Колебательное звено W9 (ksi)','Колебательное звено W10 (ksi/2)','Консервативное звено W11 (ksi = 0)', Location='best')
xlim([10^(-1) 10^(4)]);

function print(W, leg)
    subplot(2,3,1)
    step(W);
    legend(leg, Location='best')
    xlim([0 4]);
    subplot(2,3,2)
    impulse(W)
    legend(leg, Location='best')
    xlim([0 4]);
    subplot(2,3,3)
    nyquist(W)
    legend(leg, Location='best')
    subplot(2,3,[4 5 6])
    bode(W)
    legend(leg, Location='best')
    xlim([10^(-1) 10^(4)]);
end