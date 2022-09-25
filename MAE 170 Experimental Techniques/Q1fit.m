% x = f_vec
% y = p;
% 
% fit = polyfit(x,y,2);
% 
% x1 = linspace(0,4*pi);
% y1 = polyval(fit,x1);
% figure
% plot(x,y,'o')
% hold on
% plot(x1,y1)
% hold off
figure(2);

w = f_vec;
w2 = f_psd;
R = 10000;
C = .000001;

G1 = 1./(sqrt((w.*R.*C).^2+1));
G = ;

gMod = sqrt(1./(G.^2)-1);
plot(f_vec,gMod,'.'); 

x = f_vec;
y = gMod;

fit = polyfit(x,y,1);

x1 = linspace(0,length(gMod));
y1 = polyval(fit,x1);
figure(3)
plot(x,y,'o')
hold on
plot(x1,y1)
caption = sprintf('y = 0.01x');
text(1,0,caption);
hold off