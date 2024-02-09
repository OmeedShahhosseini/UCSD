clear all;
close all;
clc;


% p1
% Define beam properties and loading
L = 0.85; % Length of the beam
P = 243.95; % Applied load at some point along the beam
x = linspace(0, L, 86); % Create a vector of z-axis positions

P1 = 243.95; 
P2 = 265.625+53.125;
% Calculate bending moments along the beam
M_Z = P*x-86.1*x;
M_Z(32:86)=(P*0.3-86.1*0.3)-86.1*(x(32:86)-0.3);

% Calculate bending moments along the beam M_Y
M_Y = (-P1+P2-176.4)*x; 
M_Y(32:56) = (-P1+P2-176.4)*0.3+P2*(x(32:56)-0.3)-176.4*(x(32:56)-0.3);
M_Y(57:86) = (-P1+P2-176.4)*0.3+P2*(0.55-0.3)-176.4*(0.55-0.3)-17.6*(x(57:86)-0.55);

V_sum = sqrt(M_Y.^2+M_Z.^2);

% Plot the bending moment diagram
figure;
subplot(2,1,1)
plot(x, M_Z, 'b-', 'LineWidth', 2);
xlabel('z-axis position (m)');
ylabel('Bending Moment (N-m)');
title('Z-Axis Bending Moment Diagram');
grid on;

subplot(2,1,2)
plot(x, M_Y, 'b-', 'LineWidth', 2);
xlabel('z-axis position (m)');
ylabel('Bending Moment (N-m)');
title('Y-Axis Bending Moment Diagram');
grid on;

hold off
figure()
plot(x, V_sum, 'b-', 'LineWidth', 2);
xlabel('z-axis position (m)');
ylabel('Vector Sum of Bending Moment (N-m)');
title('Vector Sum of Bending Moment');
grid on;

%% p2
% Define beam properties and loading
L = 39; % Length of the beam
P_1 = 102.6; % Applied load at some point along the beam
P_2 = 861.5;
P_3 = 704.77;
x = linspace(0, L, 40); % Create a vector of z-axis positions

P1 = 281.9; 
P2 = 183.1;
P3 = 256.5;
% Calculate bending moments along the beam
M_Z = (-P_1-P_2+P_3)*x; 
M_Z(17:30) = (-P_1-P_2+P_3)*16-P_2*(x(17:30)-16)+P_3*(x(17:30)-16);
M_Z(31:40) = (-P_1-P_2+P_3)*16-P_2*(30-16)+P_3*(30-16)+P_3*(x(31:40)-30);

% Calculate bending moments along the beam M_Y
M_Y = (-P1-P2+P3)*x; 
M_Y(17:30) = (-P1-P2+P3)*16-P2*(x(17:30)-16)+P3*(x(17:30)-16);
M_Y(31:40) = (-P1-P2+P3)*16-P2*(30-16)+P3*(30-16)+P3*(x(31:40)-30);
V_sum = sqrt(M_Y.^2+M_Z.^2);

% Plot the bending moment diagram
figure;
subplot(2,1,1)
plot(x, M_Z, 'b-', 'LineWidth', 2);
xlabel('z-axis position (m)');
ylabel('Bending Moment (N-m)');
title('Z-Axis Bending Moment Diagram');
grid on;

subplot(2,1,2)
plot(x, M_Y, 'b-', 'LineWidth', 2);
xlabel('z-axis position (m)');
ylabel('Bending Moment (N-m)');
title('Y-Axis Bending Moment Diagram');
grid on;

hold off
figure()
plot(x, V_sum, 'b-', 'LineWidth', 2);
xlabel('z-axis position (m)');
ylabel('Vector Sum of Bending Moment (N-m)');
title('Vector Sum of Bending Moment');
grid on;
materialProps.S_e = 10.33;
materialProps.S_ut = 64;
bearingLocs = [1 30];
gearLocs = [16 39];
gearForces = [300 300];
torque = 469.85;
shaftLength = 39;
% shaftSafetyFactorDistribution(materialProps, bearingLocs, gearLocs, gearForces, torque, shaftLength)

function shaftSafetyFactorDistribution(materialProps, bearingLocs, gearLocs, gearForces, torque, shaftLength)
    % Inputs:
    % materialProps - Structure with material properties: S_ut (ultimate strength) and S_e (endurance limit)
    % bearingLocs - Vector with the locations of the bearings from the left end of the shaft
    % gearLocs - Vector with the locations of the gears from the left end of the shaft
    % gearForces - Vector with the forces acting on the gears
    % torque - Applied torque between the gears
    % shaftLength - Total length of the shaft
    
    % Define the shaft discretization
    x = linspace(0, shaftLength, 1000); % Discretize the shaft length
    M = zeros(size(x)); % Bending moment
    T = zeros(size(x)); % Torque distribution
    sigma_m = zeros(size(x)); % Mean stress
    sigma_a = zeros(size(x)); % Alternating stress
    n = zeros(size(x)); % Safety factor
    
    % Assume reaction forces are calculated and applied at bearing locations
    % This is a simplification; in practice, you might need to solve
    % statically indeterminate systems for reactions.
    R = sum(gearForces)/2; % Assuming equal reaction forces for simplicity
    
    % Calculate bending moment distribution
    for i = 1:length(gearLocs)
        for j = 1:length(x)
            if x(j) > bearingLocs(1) && x(j) < gearLocs(i)
                M(j) = M(j) + R * (x(j) - bearingLocs(1)) - sum(gearForces(1:i)) * (x(j) - gearLocs(i));
            elseif x(j) >= gearLocs(i) && x(j) < bearingLocs(2)
                M(j) = M(j) - gearForces(i) * (x(j) - gearLocs(i));
            end
        end
    end
    
    % Torque distribution (assuming it's applied only between the gears)
    for i = 1:length(x)
        if x(i) > gearLocs(1) && x(i) < gearLocs(2)
            T(i) = torque;
        end
    end
    
    % Calculate the von Mises stress and safety factor along the shaft
    d = 2.5; % Assuming a small element size for integration
    J = pi * d^4 / 32; % Polar moment of inertia
    I = pi * d^4 / 64; % Moment of inertia
    for i = 1:length(x)
        sigma_b = M(i) * d/2 / I; % Bending stress
        tau_t = T(i) * d/2 / J; % Torsional shear stress
        sigma_eq = sqrt(sigma_b^2 + 3 * tau_t^2); % von Mises equivalent stress
        
        % Assuming mean and alternating stress are equal to sigma_eq for demonstration
        sigma_m(i) = sigma_eq;
        sigma_a(i) = sigma_eq;
        
        % Goodman criterion for safety factor
        n(i) = 1 / ((sigma_a(i) / materialProps.S_e) + (sigma_m(i) / materialProps.S_ut));
    end
    
    % Plotting
    figure;
    plot(x, n, 'LineWidth', 2);
    title('Safety Factor Distribution Along the Shaft');
    xlabel('Position along the shaft (mm)');
    ylabel('Safety Factor');
    grid on;
end
