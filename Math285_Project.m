% Parameters
r = 1;  % Radius of the rolling circle
theta = linspace(0, 2*pi, 1000);  % Angle parameter
x = r * (theta - sin(theta));  % x-coordinate of cycloid
y = -r * (1 - cos(theta));  % y-coordinate of cycloid

% Plotting
figure;
plot(x, y, 'b', 'LineWidth', 2);
axis equal;
title('Cycloid Curve (Tautochrone Problem)');
xlabel('x');
ylabel('y');
grid on;