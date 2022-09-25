figure(3);


x = f_vec;
y = transfer_vec;

fit = polyfit(x,y,10);

x1 = linspace(0,length(transfer_vec));
y1 = polyval(fit,x1);
figure
plot(x,y,'o')
hold on
plot(x1,y1)
hold off