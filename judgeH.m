clear all
close all

% Define orbital shaker configuration and fluid properties-6cm petri dish
d = 0.00236;          % fluid height at rest [m]
R = 0.026;        % cylinder radius [m]
T = 0.3157;            % oscillation period          
% % Define orbital shaker configuration and fluid properties-6-well plate
% d = 0.0035;          % fluid height at rest [m]
% R = 0.0175;         % cylinder radius [m]
% T = 0.462;           % oscillation period [s]

a = 0.005;          % orbital radius [m]
nu = 1e-6;          % kinematic viscosity [m^2/s]
rho = 1000;         % fluid density [kg/m^3]
g = 9.81;           % gravitational acceleration [m/s^2]

% Grid definition
numPoints = 100;     % Number of points in each direction
[xGrid, yGrid] = meshgrid(linspace(-R, R, numPoints), linspace(-R, R, numPoints));
xGrid = xGrid(:);
yGrid = yGrid(:);
allHGreaterThanZero = true;  % Flag to track if all h are > 0

% Loop over all points
for i = 1:length(xGrid)
    x = xGrid(i);
    y = yGrid(i);

    % Ensure the point is inside the circle
    if sqrt(x^2 + y^2) <= R
        % Call the PTStokes function
        [t, h, Ux, Uy, tauwx, tauwy] = PTStokes(x, y, d, R, a, T, g, nu, rho);
        
        % Check if h is greater than zero at any time point
        if any(h <= 0)
            allHGreaterThanZero = false;
            break;  % Exit loop early if any h is not greater than zero
        end
    end
end

% Output the results
if allHGreaterThanZero
    disp('All h values are greater than zero at all times during the cycle.')
else
    disp('Some h values are less than or equal to zero at some point during the cycle.')
end