clear all
close all

% Define orbital shaker configuration and fluid properties-6cm petri dish
d = 0.00236;          % fluid height at rest [m]
R = 0.026;        % cylinder radius [m]
T = 0.315789;            % oscillation period   
% % Define orbital shaker configuration and fluid properties-6-well plate
% d = 0.0035;          % fluid height at rest [m]
% R = 0.0175;         % cylinder radius [m]
% T = 0.461538;           % oscillation period [s]

a = 0.005;          % orbital radius [m]
nu = 1e-6;          % kinematic viscosity [m^2/s]
rho = 1000;         % fluid density [kg/m^3]
g = 9.81;           % gravitational acceleration [m/s^2]

% Define radial positions
numPoints = 100;
radii = linspace(0, R, numPoints);

% Initialize arrays to store TAWSS and maxWSS
TAWSS = zeros(1, numPoints);
maxWSS = zeros(1, numPoints);

% Loop over radial positions
for i = 1:numPoints
    x = radii(i); % Assume along the x-axis for simplicity
    y = 0;        % y-coordinate is zero

    % Call the PTStokes function
    [t, h, Ux, Uy, tauwx, tauwy] = PTStokes(x, y, d, R, a, T, g, nu, rho);
    Umag = sqrt(Ux.^2 + Uy.^2);
    tauw = sqrt(tauwx.^2 + tauwy.^2);

    % Calculate TAWSS and maxWSS
    TAWSS(i) = mean(tauw);
    maxWSS(i) = max(tauw);
end

% Plot TAWSS and maxWSS as a function of radial distance
figure;
plot(radii, 10*TAWSS, 'b-', 'LineWidth', 1, 'DisplayName', 'TAWSS'); 
hold on;
plot(radii, 10*maxWSS, 'r--', 'LineWidth', 1, 'DisplayName', 'maxWSS'); 
% Set global font size and color for all text elements in the figure
set(gca, 'FontSize', 10, 'FontName', 'Arial', 'XColor', 'k', 'YColor', 'k', 'ZColor', 'k');
set(gcf, 'DefaultTextColor', 'k', 'DefaultAxesFontSize', 10);

xlabel('Radial Distance (m)','FontSize', 12, 'Color', 'k');
ylabel('Shear Stress Magnitude (dyne/cm^2)','FontSize', 12, 'Color', 'k');
% title('TAWSS and maxWSS over a Cycle as a Function of Radial Distance');

ylim([1 10]);

legend;
grid off;