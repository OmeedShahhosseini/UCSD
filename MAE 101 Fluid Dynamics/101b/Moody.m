%% Moody Function (Straight Pipes)
% Input: Reynolds number and equivalent roughness
% Output: friction factor 

function f = Moody(Re,rel_e)
% Iteration method
n = 3;
A = rel_e/3.7;
B = 2.51/Re;

% Reynolds Number weaker than transitional flow
if Re <= 2300 % Laminar
    f = 64/Re;
elseif Re < 4000 % Transition
    disp('You are dealing with transition flow')
    f = NaN;
else
    % Turbulent Flow
    x = -1.8*log10((6.9/Re)+A^1.11); %S.H. Haarland Relationship as initial guess
    for i=1:n % Newton's Method
        y = x + 2*log10(A+B*x); % Colebrook Equation
        yi = 1+2*(B/log(10))/(A+B*x);
        x = x - y/yi;
    end

    f = 1/x^2;
end