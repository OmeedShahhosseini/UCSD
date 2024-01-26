clear all;
close all
clc

%% Import Data from Mass 1 Tests
test1 = readtable("mass_1_test_1.txt");
test2 = readtable("mass_1_test_2.txt");
test3 = readtable("mass_1_test_3.txt");
test4 = readtable("mass_1_test_4.txt");
test5 = readtable("mass_1_test_5.txt");

%% Import Data from Mass 2 Tests
% test1 = readtable("mass_2_test_1.txt");
% test2 = readtable("mass_2_test_2.txt");
% test3 = readtable("mass_2_test_3.txt");
% test4 = readtable("mass_2_test_4.txt");
% test5 = readtable("mass_2_test_5.txt");

%% Set arrays for Time and Encoder 1 values
m = 3;
time = [table2array(test1(2:end,m)) table2array(test2(2:end,m)) table2array(test3(2:end,m)) table2array(test4(2:end,m)) table2array(test5(2:end,m))];
m = 4;
encoder1 = [table2array(test1(2:end,m)) table2array(test2(2:end,m)) table2array(test3(2:end,m)) table2array(test4(2:end,m)) table2array(test5(2:end,m))];

%% Plots Encoder Data and Finds Settling Time, adds 2 lines for the settling time margin. 
encoderSettle = zeros(1,5);
for n = 1:5
    encoderSettle(n) = mean(encoder1(230:330,n));
    [t_0(n), ts(n), num(n)] = breakdown(encoder1, encoderSettle(n), n);
    figure();
    plot(time(:,n),encoder1(:,n));
    hold on
    x = time(ts(n));
    line([x x], [-300 300]);
    plot(time, encoderSettle(n)*1.02*ones(1,length(time)));
    hold on
    plot(time, encoderSettle(n)*0.98*ones(1,length(time)));
    hold off
end

for i = 1:length(t_0)
    t0(i) = time(t_0(i));                                                   %Overshoot Time [t0]
    y0(i) = encoder1(t_0(i),i);                                             %Initial Overshoot Value [y0]
    tn(i) = time(ts(i));                                                    %Settling Time [tn]
    yn(i) = encoder1(ts(i),i);                                              %Settling Peak [yn]
    yinf(i) = mean(encoder1(230:330,i));                                    %Settling Value [yinf]
    n = 3;                                                                  %number of oscillations between t0 and tn
end

%% Mean Values for Mass
t0 = mean(t0);
y0 = mean(y0);
tn = mean(tn);
yn = mean(yn);
yinf = mean(yinf);
n = 4;
format shortG
disp('Average values across 5 tests used for calculations')
disp(mat2str(["t0="+t0 "y0="+y0 "tn="+tn "yn="+yn "yinf="+yinf "n="+n]))
%% Visually Confirmed values for Mass 1 Settling time. 
% test1Ts = 0.673;
% test2Ts = 0.673;
% test3Ts = 0.682;
% test4Ts = 0.682;
% test5Ts = 0.682;

%% This function will find the index of each positive and negative peak.
% Output: [index of 1st peak, index of settled peak, number of oscillations between those peaks]
function [t0,ts,n] = breakdown(encoder1, Settle, enc)
    binaryStep = sign(diff(encoder1(1:230,enc)));
    signChanges = diff(binaryStep);
    switchIndices = find(signChanges ~= 0) + 1;
    t0 = switchIndices(1);
    n = 0;
    dub = 0;
    for i = 1:length(switchIndices)
        if encoder1(switchIndices(i),enc) > Settle
            %disp(encoder1(switchIndices(i),enc));
            n = n+1;
            % disp(encoder1(switchIndices(i),enc))
            if encoder1(switchIndices(i),enc) < Settle*1.02
                ts = switchIndices(i);
                break;
            end
        end
        if switchIndices(i+1) - switchIndices(i) == 1
            dub = dub + 1;
        end
    end
    % disp(dub);
    n=n-dub;
end

   