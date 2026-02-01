clc;
clear;
close all;

N  = input('Enter number of control volumes N: ');
q0 = input('Enter q0 (W/m^3): ');
q1 = input('Enter q1 (W/m^3-K): ');

L = 0.02;      % Plate Thickness (m)
k = 0.5;       % Thermal conductivity (W/m-K)
phi_A = 100;  % Left boundary Temperature (°C)
phi_B = 200;  % Right Boundary Temperature (°C)
a = 1;         % Area (m)

% To draw continuous curve
x_exact = linspace(0,L,400);
phi_exact_ = ((phi_B - phi_A)/L + (q0/(2*k))*(L - x_exact)).*x_exact + phi_A;

dx = L/N;       
x  = linspace(dx/2, L-dx/2, N)'; 
A = zeros(N,N);
b = zeros(N,1);

%% Interior CV
for i = 2:N-1
    Aw = k*a/dx;
    Ae = k*a/dx;
    Ap = Aw + Ae - q1*a*dx;

    A(i,i-1) = -Aw;
    A(i,i)   =  Ap;
    A(i,i+1) = -Ae;

    b(i) = q0*a*dx;
end

%% Left boundary CV
Ae = k*a/dx;
Ap = 3*k*a/dx - q1*a*dx;

A(1,1) = Ap;
A(1,2) = -Ae;

b(1) = 2*k*a*phi_A/dx + q0*a*dx;

%% Right boundary CV
Aw = k*a/dx;
Ap = 3*k*a/dx - q1*a*dx;

A(N,N)   = Ap;
A(N,N-1) = -Aw;

b(N) = 2*k*a*phi_B/dx + q0*a*dx;


%% Solve Linear System
phi_num = mldivide(A,b);

%% Exact solution
phi_exact = ((phi_B - phi_A)/L + (q0/(2*k))*(L - x)).*x + phi_A;

 %% RMS Error
RMS = sqrt(mean((phi_num - phi_exact).^2));
fprintf('\nRMS Error = %.3e\n', RMS);


%% Plot
x_cm = x*100;
x_exact_cm = x_exact*100;
figure;
plot(x_cm, phi_num, 'rs-', 'LineWidth', 2);
hold on;
plot(x_exact_cm, phi_exact_, 'k-', 'LineWidth', 2);
legend('FVM Solution', 'Exact Solution');
hold off;
xlabel('x (cm)');
ylabel('Temperature (°C)');
ylim([50 300]);
title('Comparison of the numerical results with the analytical solution');
grid on;
