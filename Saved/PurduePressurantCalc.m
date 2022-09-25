%Amanda Chastain
%AAE 450 Propulsion Group
%Orbital Subgroup
%Propellant Tank Sizing
t = 87; %s - flight time
%Tank Volumes
%Oxidizer
mdoto = 2.25;           %kg/s - max flow rate for LOX
rhoo = 1168;            %kg/m3 - density of propellant @ 1200 psi
mo = mdoto * t;         %kg - mass of propellant for flight time
Vo_pu = mo/rhoo;        %m3 - useable propellant volume
Vo_trap = 0.05 * Vo_pu; %m3 - unuseable propellant trapped in feed system
Vo_ull= (Vo_pu + Vo_trap) * 0.1; %m3 - uulleage volume
Vo_tank = Vo_pu + Vo_trap + Vo_ull; %m3 - total volume of tank
%Fuel
mdotf = 0.72; %kg/s - max flow rate for Methane
rhof = 438.4; %kg/m3 - density of propellant @ 1200 psi
mf = mdotf * t; %kg - mass of propellant for flight time
Vf_pu = mf/rhof; %m3 - useable propellant volume
Vf_trap = 0.05 * Vo_pu; %m3 - unuseable propellant trapped in feed system
Vf_ull= (Vf_pu + Vf_trap) * 0.1; %m3 - uulleage volume
Vf_tank = Vf_pu + Vf_trap + Vf_ull; %m3 - total volume of tank
%Tank Pressures
%Assumes a pressure fed system choosen from tank volumes
%Oxidizer
Po_tank = (10^(-0.1281*(log(Vo_tank) + 0.2498))) * 1e6; % Pa - tank pressure
%Po_tank = 17000000;
%Fuel
Pf_tank = (10^(-0.1281*(log(Vf_tank) + 0.2498))) * 1e6; % Pa - tank pressure
%Pf_tank = 17000000;
%Tank Masses
fs = 2; %safety factor to account to errors (2- common for pressure vessels)
phi_tank = 10000; %meters- tank mass factor for metallic tanks
g = 9.812865328; %m/s2- gravitational constant
%Oxidizer
pb_o = fs*Po_tank; % pa design  burst pressure
mo_tank = (pb_o * Vo_tank)/(phi_tank * g); % kg - tank mass
%Fuel
pb_f = fs*Pf_tank; % pa design  burst pressure
mf_tank = (pb_f * Vf_tank)/(phi_tank * g);
%Pressurant Tanks
%N2 as pressurant
gamma = 1.40; %Specific heat ratio N2
R = 8314/28.0134; %Specific gas constant for N2
P_in = 41.36854e6;% Pa - Assumed initial pressure
T_in= 273; % K - Assumed inital temperature
Pf = (Po_tank + Pf_tank)/2;  %final tank pressure - average of fuel/oxid pres
Tf = T_in * ((Pf/P_in)^((gamma -1)/gamma));
Vf = (Vf_tank + Vo_tank);
%Calculate mpress at intial conditions
mpress_in = (Vf *P_in)/ (R*T_in); % kg pressurant mass at inital conditions
V_ptank = ((mpress_in*R*Tf)/ (Pf)) - (Vf); % m3 % required pressurant tank volume
%Use inital values to compute mass/volume of pressurant
V_press = V_ptank + Vf; %m3- volume of the pressurant
mpress_f = (V_press*Pf)/(R*Tf); % Mass of the pressurant
mtank = (P_in * V_ptank)/(g*6350); % Mass of pressurant tank