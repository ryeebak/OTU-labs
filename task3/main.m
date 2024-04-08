clear, clc

% коэффициенты
T1 = 0.7;
k1 = 1.6;
T = 0.1;
k = 1;

% Передаточные функции
% Разомкнутая система
sys_1 = tf(k*k1, [T*T1, T+T1, 1, 0]);
% Замкнутая система
sys_2 = tf(k*k1, [T*T1, T+T1, 1, k*k1]);

A1 = calculateAmplitudeMargin(sys_1);
P1 = calculatePhaseMargin(sys_1);
doPlot(sys_1, 'Разомкнутая система', A1, P1)

A2 = calculateAmplitudeMargin(sys_2);
P2 = calculatePhaseMargin(sys_2);
doPlot(sys_2, 'Замкнутая система', A2, P2)

% Нахождение устойчивости по амплитуде
function AmplitudeMargin = calculateAmplitudeMargin(sys)
    [G, F] = nyquist(sys);
    result_h = +inf;
    for k = 1:length(G)
        if abs(F(k)) <= 0.01
            if abs(-1 - G(k)) < result_h
                result_h = G(k);
            end
        end
    end
    AmplitudeMargin = abs(-1 - result_h);
end

% Нахождение устойчивости по фазе
function PhaseMargin = calculatePhaseMargin(sys)
    [G, F] = nyquist(sys);
    result_fi_rad = 0;
    result_fi_deg = 0;
    unit_circle_intersections = [];
    for i = 1:length(F)
        % Расстояние от точки до начала координат
        distance = F(i)*F(i) + G(i)*G(i);
        % Если расстояние в эпсилон-окрестности единицы, точка подходит
        epsilon = 0.1;
        if abs(distance - 1) < epsilon
            unit_circle_intersections = [G(i), F(i)];
       
            x_intersect = unit_circle_intersections(1);
            y_intersect = unit_circle_intersections(2);

            % Находим угол
            angle_rad = atan2(y_intersect, x_intersect);
       
            % сохраняем результат
            if abs(angle_rad) > abs(result_fi_rad)
                result_fi_rad = angle_rad;
                if  angle_rad < 0
                    result_fi_deg = 180 - abs(rad2deg(angle_rad));
                else
                    result_fi_deg = abs(rad2deg(angle_rad));
                end
            end
        end
    end
    PhaseMargin = result_fi_deg;
end

% графики!
function doPlot(sys, name, A, P)
    figure;
    subplot(1, 3, 1);
    nyquist(sys);
    % 20*log10(A)
    titleString = sprintf('%s\n Запас устойчивости по амплитуде (годограф) = %.2f, запас устойчивости по фазе (градусы) = %.2f\n', name, A, P);
    title(titleString)
    hold on
    theta = linspace(0, 2*pi, 100);
    x_circle = cos(theta);
    y_circle = sin(theta);
    plot(x_circle, y_circle, 'k--'); % Чертим окружность
    hold off
    subplot(1,3,[2 3]);
    margin(sys)
end
