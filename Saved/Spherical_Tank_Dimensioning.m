clear;
clc;
format long;

%% SPHERICAL TANK CALCULATIONS %%
% 2024-T4 Aluminum
%% Adjustable Variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
V = 0.066;      %Total Tank Volume (m^3)
P = 17.237000;  %Max Operating Tank Pressure (MPa)
rho_p = 1141.7; %Propellant Density (kg/m^3)
n = 1.25;        %Overload coefficient
u_p = .15;      %Ullage written as decimal 
g = 9.81;       %Gravitational Constant (m/s^2) 
Tu = 460;       %Ultimate Tensile Strength (MPa)
W = .65;        %Weld Safety Coefficient
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dp = 1000*2*(3*V/(4*pi)).^(1/3); %Diameter of Tank
T_safe = Tu/n;  %Tensile Strength Safety
Tw = T_safe*W;  %Weld Strength Safety
%% Wall Thickness Calculation
D = (Dp*P)/(4*Tw+P);      %Minium Tank Thickness
D_ASME = D*3/2;           %ASME factored wall thickness
%% Print Commands
format short
disp('ASME factored WALL THICKNESS (mm)');
disp(D_ASME);
disp('ASME factored WALL THICKNESS (Inches)');
disp(D_ASME/25.4);
disp('Spherical Tank Volume (m^3)');
disp(V);
disp('Spherical Tank Radius (m)');
disp(Dp/2000);
disp('Spherical Tank Outer Radius (m)');
disp(D_ASME/1000+Dp/2000);