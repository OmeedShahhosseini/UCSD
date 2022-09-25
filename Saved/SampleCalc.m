clear all:
clc;
format long;

%% Variables

%Wg = 0;  %: lb            Weight of Pressurant in Storage
Tg = 491.4;  %: Rankine   Mean temperature of Pressurant
Tu = 460;  %: Rankine       Temperature of pressurant at expulsion
Tv = 162.4;  %: Rankine       Temperature of Vaporization of Propellant(LOX)
Te = 159.7;  %: Rankine       Temperature of propellant(LOX)
Tv2 = 199.8; %: Rankine       Temperature of Vaporization of Propellant(Meth)
Te2 = 189; %: Rankine       Temperature of propellant(Meth)
Cpg = 0.248; %: Btu/lbR       Specific heat of pressurant in prop tanks at a PSI
Cpl = 0.391; %: Btu/lbR       Specific heat of liquid propellant(LOX)
Cpv = 0.218; %: Btu/lbR       Specific heat of propellant vapor(LOX)
%Wv = 0;  %: lb            Total weight of Vaporized propellants(LOX)
hv = 92;  %: Btu/lb        Heat of vaporization of propellants(LOX)
Cpl2 = 0.5047;%: Btu/lbR       Specific heat of liquid propellant(Meth)
Cpv2 = 0.498;%: Btu/lbR       Specific heat of propellant vapor(Meth)
%Wv2 = 0; %: lb            Total weight of Vaporized propellants(Meth)
hv2 = 8.19; %: Btu/lb        Heat of vaporization of propellants(Meth)
z = 1;   %: constant      Compressibility of pressurant
Rp = 48.287;  %: ftlb/lbR      Gas constant of propellant vapor(LOX)
Rp2 = 96.314; %: ftlb/lbR      Gas constant of propellant vapor(Meth)
Rg = 55.165;  %: ftlb/lbR      Gas constant of pressurant
Pt = 864000;  %: lb/ft^2       Maximum Propellant tank pressure
Vt = 5.851;  %: ft^3          Maximum volume of expelled propellant(LOX)
Qw1 = 0; %: Btu           Heat transfer between tank walls and propellant(LOX)
Vt2 = 5.059; %: ft^3          Maximum volume of expelled propellant(Meth)
Qw12 = 0;%: Btu           Heat transfer between tank walls and propellant(Meth)
Qw2 = 0; %: Btu           Heat transfer between pressurant and tank walls

H = 0.196;       %: Btu/s/(ft^2)R Experimentally determined heat transfer coefficient(LOX)
H2 = 0.196;      %: Btu/s/(ft^2)R Experimentally determined heat transfer coefficient(Meth)
A = 0.713;       %: ft^2          Area of gas-liquid interference(LOX)
A2 = 0.639;      %: ft^2          Area of gas-liquid interference(Meth)
time = 200;   %: s             Total flight time
Tm = 491.4;  %: Rankine       Mean temperature of pressurants
%% Equations for LOX

%Solving for Wg (METHLOX, cooler than ambient temp) includes heat transfer

%Wg = (Wv.*(Cpl.*(Tv-Te)+hv+Cpv.*(Tu-Tv))-(Qw1+Qw2))./(Cpg.*(Tg-Tu));

%Solving for Q Heat transfer between prop and pressurant: Btu

Q = H.*A.*time.*(Tm-Te);

%Solving for Wv Weight of Vaporized propellant: lb

Wv = (Cpl.*(Tv-Te)+hv+Cpv.*(Tu-Tv))./Q;

%Solving for Vv Volume occupied by vaporized propellants: ft^3

Vv = (Wv.*z.*Rp.*Tu)/Pt;

%Volume occupied by pressurant gas: ft^3

Vg = Vt-Vv; 

%Solving for Wg (LOX) includes interface heat transfer (without tank wall heat transfer)

Wg = (Pt.*Vg)/(Rg.*Tu);

%% Equations for Methane

 %Solving for Wg (METHLOX, cooler than ambient temp) includes heat transfer

%Wm = (Wv2.*(Cpl2.*(Tv2-Te2)+hv2+Cpv2.*(Tu-Tv2))-(Qw1+Qw2))./(Cpg.*(Tg-Tu));

%Solving for Q Heat transfer between prop and pressurant: Btu

Q2 = H2.*A.*time.*(Tm-Te);

%Solving for Wv Weight of Vaporized propellant: lb

Wv2 = (Cpl2.*(Tv2-Te2)+hv2+Cpv2.*(Tu-Tv2))./Q2;

%Solving for Vv Volume occupied by vaporized propellants: ft^3

Vv2 = (Wv2.*z.*Rp2.*Tu)/Pt;

%Volume occupied by pressurant gas: ft^3

Vg2 = Vt2-Vv2; 

%Solving for Wg (LOX) includes interface heat transfer (without tank wall heat transfer)

Wm = (Pt.*Vg2)/(Rg.*Tu);

%% Total weight of N2

Wt = Wg + Wm;
