clear all
close all 
clc 

n=8;
format shortG

for i=1:n+1
    k = i-1;
    ck = (factorial(2*n-k)*factorial(n))/(factorial(2*n)*factorial(k)*factorial(n-k)) 
end
d = 0.1

rlocus(tf([-d/2 1],[d/2 1 0]));

figure

rlocus(tf([d^2/12 -d/2 1],[d^2/12 d/2 1 0]));

figure

rlocus(tf([d^4/1680 -d^3/84 3*d^2/28 -d/2 1],[d^4/1680 d^3/84 3*d^2/28 d/2 1 0]));

figure 

rlocus(tf([d^8/518918400 -d^7/7207200 d^6/205920 -d^5/9360 d^4/624 -d^3/60 7*d^2/60 -d/2 1],[d^8/518918400 d^7/7207200 d^6/205920 d^5/9360 d^4/624 d^3/60 7*d^2/60 d/2 1 0]));

d = 0.2


rlocus(tf([-d/2 1],[d/2 1 0]));

figure

rlocus(tf([d^2/12 -d/2 1],[d^2/12 d/2 1 0]));

figure

rlocus(tf([d^4/1680 -d^3/84 3*d^2/28 -d/2 1],[d^4/1680 d^3/84 3*d^2/28 d/2 1 0]));

figure 

rlocus(tf([d^8/518918400 -d^7/7207200 d^6/205920 -d^5/9360 d^4/624 -d^3/60 7*d^2/60 -d/2 1],[d^8/518918400 d^7/7207200 d^6/205920 d^5/9360 d^4/624 d^3/60 7*d^2/60 d/2 1 0]));