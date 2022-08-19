clc
clear all;
close all;
 
%Plot the elevation of the water in tank A as a function of time until the free surfaces in both tanks are at the same elevation.
int = 1;
rho = 1000; %kg/m^3
g = 9.81; %m/s^2
f = Moody(2300,0);
dynV = 0.00105;

l = 25; %m
D = 0.0025; %m 
h = 2;
A_pipe = pi*(D/2)^2; 
A_res = pi*(3/2)^2; 
% delh = linspace(2,0,100); %m

% for i = 1:length(delh)
% v_squared(i) = (rho*g^2*delh(i)*D*2)/(f*l);
% v(i) = sqrt(v_squared(i));
% Re = rho*v(i)*D/(dynV);
% f = Moody(Re,0);
% end


%plot(flip(delh),v);

%for every timestep, calculate V, use v to find mdot, use mdot to record delh
i = 1;
while h > 0
v_squared(i) = (rho*g^2*h*D*2)/(f*l);
v(i) = sqrt(v_squared(i));
Re = rho*v(i)*D/(dynV);
f = Moody(Re,0);
Vdot(i) = A_pipe*v(i);
v_res(i) = Vdot(i)/(A_res);
dv(i) = sum(v_res);
h = h-sum(v_res); 
height(i) = sum(v_res);
disp(i);
i = i+1;
end

t = linspace(0,i,i+1);
plot(t(1:length(dv)),height);



