clear, clc

k = 1;
T = 0.5;
T1 = 0.5;
W0 = tf(k, [T*T1, T+T1,1,0])
sisotool(W0)
% C = 0.5

kp=1;
Ta=1;
Td=10;
Wp=tf([kp*Ta+Td, kp],[Ta, 1])
sisotool(W0,Wp);
