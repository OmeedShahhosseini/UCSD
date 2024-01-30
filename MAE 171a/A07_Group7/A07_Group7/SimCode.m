clear;
clc;
close all;

%%  Run
run('OpenLoopAnalysis2.m');

% Variables
U=.05; 
n=3; % not n=4
wd=zeros(1,5); Bwn=wd; wn=wd; B=wd; k=wd; m=wd; d=wd;
y=zeros(size(time));
time=time(:,1);

% Assumptions
N = 1;
% wd(N)=(2*pi*n)/(tn(N)-t0(N)); % Damped Resonance Frequency
% Bwn(N)=((1)/(tn(N)-t0(N)))*log((y0(N)-yinf(N))/(yn(N)-yinf(N))); % Exponential Decay Term
% wd(N)= 34.33;
% Bwn(N)= 7.5139; 
wd(N)=18.19;
Bwn(N)=0.593;

% wn(N)=sqrt((wd(N)).^2+(Bwn(N)).^2); % Undamped Resonance Frequency
% B(N)=(Bwn(N))/(wn(N)); % Damping Ratio
% wn(N) = 35.15;
% B(N)=0.214;
wn(N) = 18.194;
B(N) = .021;

yinf = mean(encoder1(230:330,1));

k(N)=U/yinf; % Stiffness Constant
m(N)=k(N)*(wn(N))^2; % (Mass/Inertia)
d(N)=k(N)*((2*B(N))/(wn(N))); % Damping Constant


% deltaT = tn(1)-t0(1);
% B_omega = (1/deltaT)*log((y0(1)-yinf(1))/(yn(1)-yinf(1)));
% plot(time,exp(-B_omega*time));

% for N=1:5
% % Simulation
% y(:,N) = ((U)./(k(N))).*(1-(exp(-Bwn(N).*time)).*sin((wd(N).*time)));
y2(:,N) = ((1)./(k(N))).*(1-(exp(-Bwn(N).*(time-.5))).*sin((wd(N).*(time-.5))))-690;
figure(N+5)
plot(time,y(:,N),'r');
title(sprintf('Simulation of Mass #1 Run %d',N));
hold on 
plot(time,y2(:,N),'r');
plot(time,encoder1(:,1),'b')
hold off
% end
