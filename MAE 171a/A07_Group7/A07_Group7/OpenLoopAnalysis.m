clear all
close all
clc

test1 = readtable("mass_1_test_1.txt");
test2 = readtable("mass_1_test_2.txt");
test3 = readtable("mass_1_test_3.txt");
test4 = readtable("mass_1_test_4.txt");
test5 = readtable("mass_1_test_5.txt");

m = 3;
time = [table2array(test1(2:end,m)) table2array(test2(2:end,m)) table2array(test3(2:end,m)) table2array(test4(2:end,m)) table2array(test5(2:end,m))];
m = 4;
encoder1 = [table2array(test1(2:end,m)) table2array(test2(2:end,m)) table2array(test3(2:end,m)) table2array(test4(2:end,m)) table2array(test5(2:end,m))];

encoderSettle = zeros(1,5);
for n = 1:5
    figure();
    encoderSettle(n) = mean(encoder1(230:330,n));
    plot(time(:,n),encoder1(:,n));
    hold on
    % x = time(15);
    % line([x x], [-300 300]);
    plot(time, encoderSettle(n)*1.02*ones(1,length(time)));
    hold on
    plot(time, encoderSettle(n)*0.98*ones(1,length(time)));
    hold off
    [t_0(n)] = breakdown(encoder1(1:230,n), encoderSettle(n));
end

for i = 1:length(t_0)
    t0(i) = time(t_0(i));
    y0(i) = encoder1(t_0(n),i);
end

n = 3;
test1Ts = 0.673;
test2Ts = 0.673;
test3Ts = 0.682;
test4Ts = 0.682;
test5Ts = 0.682;


function [t0] = breakdown(StepR, Settle)
    binaryStep = sign(diff(StepR));
    signChanges = diff(binaryStep);
    switchIndices = find(signChanges ~= 0) + 1;
    t0 = switchIndices(1);
end

   