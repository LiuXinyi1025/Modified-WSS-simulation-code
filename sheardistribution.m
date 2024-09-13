%% Parameter Definitions

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

%% Grid Definition
num_points = 200;   % density of the grid
[x_grid, y_grid] = meshgrid(linspace(-R, R, num_points), linspace(-R, R, num_points));

%% Calculate and Display Shear Stress Distribution at the Start of the Cycle
tauwx_grid = zeros(size(x_grid));
tauwy_grid = zeros(size(x_grid));

% Iterate over each grid point to calculate shear stress
for i = 1:numel(x_grid)
    if x_grid(i)^2 + y_grid(i)^2 <= R^2  % Ensure the point is inside the cylinder
        % Calculate shear stress distribution
        [~, ~, ~, ~, tauwx, tauwy] = PTStokes(x_grid(i), y_grid(i), d, R, a, T, g, nu, rho);
        tauwx_grid(i) = tauwx(1);  % Take only the value at the start of the cycle
        tauwy_grid(i) = tauwy(1);
    else
        % Assign NaN for points outside the cylinder
        tauwx_grid(i) = NaN;
        tauwy_grid(i) = NaN;
    end
end

% Calculate the magnitude of the shear stress
tau_magnitude = sqrt(tauwx_grid.^2 + tauwy_grid.^2);

% Plotting
figure;
% Create the contour plot
contourf_handle = contourf(x_grid, y_grid, 10*tau_magnitude, 'LevelList', linspace(0, max(10*tau_magnitude(:)), 20));
% Add a colorbar on the left side outside of the plot
% cb = colorbar('Location', 'westoutside');
cb = colorbar;
% Set the colorbar title and adjust font size and color
cb.Label.String = 'Shear Stress Magnitude (dyne/cm^2)';
cb.Label.FontSize = 12;
cb.Label.Color = 'k';
cb.Label.Rotation = -90;
% Adjust the position of the colorbar label to move it rightward
% Obtain current label position
currentPosition = cb.Label.Position;
% Move the label rightward by increasing the X-value
newPosition = currentPosition + [1.5 0 0];  % Adjust the 1 to a suitable value based on your figure's scale
cb.Label.Position = newPosition;

% Set global font size and color for all text elements in the figure
set(gca, 'FontSize', 10, 'FontName', 'Arial', 'XColor', 'k', 'YColor', 'k', 'ZColor', 'k');
set(gcf, 'DefaultTextColor', 'k', 'DefaultAxesFontSize', 10);

% Set x and y axis labels with specific location settings
xlabel('Position in Cylinder (m)', 'FontSize', 12, 'Color', 'k');
ylabel('Position in Cylinder (m)', 'FontSize', 12, 'Color', 'k', 'Rotation', 90, 'VerticalAlignment', 'baseline', 'HorizontalAlignment', 'center');

% title('Shear Stress Magnitude at the Start of the Cycle', 'FontSize', 12, 'Color', 'k');

% Make axis equal to avoid distortion
axis equal;