clear;
clc;
format long;

%% Static Variables
LOX_density = 1168.3; %kg/m^3
Methane_density = 438.4; %kg/m^3
Nitrogen_density = 405; %kg/m^3 at 273k & 6000psi
gamma = 1.40; %Specific heat ratio N2
R = 8314/28.0134; %Specific gas constant for N2
T_in= 273; % K - Assumed inital temperature
g = 9.812865328; %m/s2- gravitational constant
fs = 2; %Factor of Safety
phi_tank = 10000; %meters- tank mass factor for metallic tanks

%% Adjustable Variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LOX_Mdot = 2.03; %kg/s
Meth_Mdot = 0.84; %kg/s
Engine_Inlet_Pressure = 800; %psig
Head_Loss_tankToEngine = 400; %psig
Total_Fire_Duration = 30; %seconds
PropTank_Ullage = .1; %Percent/100
Line_Loss = .05; %Percent/100
P_in = 41.36854e6; % Pa - Assumed initial pressure 6000psig
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Calculated Values
Prop_Tank_Pressure = Engine_Inlet_Pressure + Head_Loss_tankToEngine; %psig


Mass_LOX = LOX_Mdot*Total_Fire_Duration; %kg
Mass_Meth = Meth_Mdot*Total_Fire_Duration; %kg
Vdot_LOX = (LOX_Mdot/LOX_density)*1000; %L/s
Vdot_Meth = (Meth_Mdot/Methane_density)*1000; %L/s

vTotal_LOX = Vdot_LOX * Total_Fire_Duration; %L
vTotal_Meth = Vdot_Meth * Total_Fire_Duration; %L

if vTotal_LOX < vTotal_Meth

    vTotal_Propellant_Tanks = vTotal_Meth*(1+(PropTank_Ullage+Line_Loss));

else

    vTotal_Propellant_Tanks = vTotal_LOX*(1+(PropTank_Ullage+Line_Loss));
    
end

%Oxidizer
mdoto = 2.25; %kg/s - max flow rate for LOX
rhoo = 1168; %kg/m3 - density of propellant @ 1200 psi
mo = mdoto * Total_Fire_Duration; %kg - mass of propellant for flight time
Vo_pu = mo/rhoo; %m3 - useable propellant volume
Vo_trap = 0.05 * Vo_pu; %m3 - unuseable propellant trapped in feed system
Vo_ull= (Vo_pu + Vo_trap) * 0.1; %m3 - uulleage volume
Vo_tank = Vo_pu + Vo_trap + Vo_ull; %m3 - total volume of tank

%Fuel
mdotf = 0.72; %kg/s - max flow rate for Methane
rhof = 438.4; %kg/m3 - density of propellant @ 1200 psi
mf = mdotf * Total_Fire_Duration; %kg - mass of propellant for flight time
Vf_pu = mf/rhof; %m3 - useable propellant volume
Vf_trap = 0.05 * Vo_pu; %m3 - unuseable propellant trapped in feed system
Vf_ull= (Vf_pu + Vf_trap) * 0.1; %m3 - uulleage volume
Vf_tank = Vf_pu + Vf_trap + Vf_ull; %m3 - total volume of tank

%% N2 Sizing
%Oxidizer
Po_tank = (10^(-0.1281*(log(Vo_tank) + 0.2498))) * 1e6; % Pa - tank pressure
%Fuel
Pf_tank = (10^(-0.1281*(log(Vf_tank) + 0.2498))) * 1e6; % Pa - tank pressure
pb_o = fs*Po_tank; % pa design  burst pressure
mo_tank = (pb_o * Vo_tank)/(phi_tank * g);% kg - tank mass
%Fuel
pb_f = fs*Pf_tank; % pa design  burst pressure
mf_tank = (pb_f * Vf_tank)/(phi_tank * g);
%Pressurant Tanks

%N2 as pressurant
Pf = (Po_tank + Pf_tank)/2; %final tank pressure - average of fuel/oxid pres
Tf = T_in * ((Pf/P_in)^((gamma -1)/gamma));
Vf = (Vf_tank + Vo_tank);
%Calculate mpress at intial conditions
mpress_in = (Vf *P_in)/ (R*T_in); % kg pressurant mass at inital conditions
V_ptank = ((mpress_in*R*Tf)/ (Pf)) - (Vf); % m3 % required pressurant tank volume
%Use inital values to compute mass/volume of pressurant
V_press = V_ptank + Vf; %m3- volume of the pressurant
mpress_f = (V_press*Pf)/(R*Tf); % Mass of the pressurant
mtank = (P_in * V_ptank)/(g*6350); % Mass of pressurant tank

%% Tank Sizing
PressVol = 1000*mpress_f/Nitrogen_density;
TankPressVol = PressVol*1.05;
LOXVol = vTotal_LOX * 1.15;
MethVol = vTotal_Meth * 1.15;
D_LOX = 2*((LOXVol/1000*3)/(4*pi))^(1/3);
D_Meth = 2*((MethVol/1000*3)/(4*pi))^(1/3);

%% Print Values
format short
disp('Mass of N2 in kg');
disp(mpress_f);

disp('Volume of N2 in L')
disp(PressVol);

disp('Tank Volume for N2');
disp(TankPressVol);

disp('Total Volume of LOX Tank: 10% Ullage + 5% Line Loss');
disp(LOXVol);

disp('Tank Diameter for Spherical LOX Tank');
disp(D_LOX);

disp('Total Volume of Methane Tank: 10% Ullage + 5% Line Loss');
disp(MethVol);

disp('Tank Diameter for Spherical Methane Tank');
disp(D_Meth);