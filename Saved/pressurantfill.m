clc;
clear;
format loose

P_k = 41.3;     %Mpa
V_k = 60;       %liters
N_k = 1:30;
Vt_k = V_k*N_k; %liters

V_p = 100;      %liters

press = (P_k.*Vt_k)./(Vt_k+V_p);

plot(N_k,press*145,'k');
hold on
for n = 1:length(N_k)
    if mod(n,6) == 0
        plot(N_k(n),press(n)*145,'ro','MarkerFaceColor','r','MarkerSize',4);
        hold on 
    else
        plot(N_k(n),press(n)*145,'ko','MarkerFaceColor','k','MarkerSize',3);
        hold on 
    end
end

ylabel('PSI','color','#53868B'); xlabel('Number of K bottles','color','#53868B');
% disp('Maximum Tank Pressure');
% disp(press);
% 
% disp('Approx PSI')
% disp(press*145);
