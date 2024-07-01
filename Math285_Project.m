% Parameters
r = 1; % Radius of the generating circle
g = 9.81; % Acceleration due to gravity

% Time properties
T = 2 * pi * sqrt(r / g); % Time for one complete period
t = linspace(0, T, 1000); % Time vector

% Cycloid Parametric Equations
theta = (t / T) * 2 * pi; % Parametric variable
x = r * (theta - sin(theta)); % x coordinate
y = r * (1 - cos(theta)); % y coordinate

% Plot Cycloid
figure;
plot(x, y, 'b-', 'LineWidth', 2);
hold on;
axis equal;
grid on;
xlabel('x');
ylabel('y');
title('Cycloid - Tautochrone Curve');
set(gca, 'YDir', 'reverse');

% Animate the Ball on the Cycloid
ball_radius = 0.05;
for k = 1:length(t)
    % Clear previous ball
    if k > 1
        delete(ball);
    end
    
    % Plot Ball
    ball = rectangle('Position', [x(k) - ball_radius, y(k) - ball_radius, 2 * ball_radius, 2 * ball_radius], ...
                     'Curvature', [1, 1], 'FaceColor', 'r');
    
    % Pause for animation
    pause(0.01);
end