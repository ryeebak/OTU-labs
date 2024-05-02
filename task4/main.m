clear, clc

% коэффициенты
T1 = 0.7;
k1 = 1.6;
T = 0.1;
k = 0.1;
B = [k*k1];
A = [T*T1, T+T1, 1, k*k1];
W = tf(B, A);
w=0.001:0.001:2;
GM=freqs(A, 1, w);
U = real(GM);
V = imag(GM);
plot(U,V,'b-','LineWidth',2);
hold on
plot(0,0,'r+','LineWidth',2);
grid minor
%xlim([-10 10]);
hold off

T=[0.1, 0.2, 0.3, 0.5, 1, 1.5, 2, 2.5, 3, 4 ,5];
k1 = 1.6;
k_cr = 1/k1*[11.43,6.43,4.761,3.427,2.428,2.096,1.928,1.829,1.762,1.681,1.631];
figure();
plot(T, k_cr, 'b-', 'Linewidth', 2);
axis equal;
grid on;
title('Граница устойчивости системы');
xlabel('t');
ylabel('k_{крит}');

figure();
T=0.7;
k=0.1;
W1=tf([k*k1],[T*T1,T+T1,1,k*k1]);
ltiview({'step';'impulse';'bode';'nyquist';'pzmap'},W1);

figure();
T=1.7;
k=3;
W1=tf([k*k1],[T*T1,T+T1,1,k*k1]);
ltiview({'step';'impulse';'bode';'nyquist';'pzmap'},W1);

figure();
T=1.5;
k=2.096/k1;
W1=tf([k*k1],[T*T1,T+T1,1,k*k1]);
ltiview({'step';'impulse';'bode';'nyquist';'pzmap'},W1);
%sys = tf(k*k1, [T*T1, T+T1, 1, k*k1]);
%nyquist(sys);


