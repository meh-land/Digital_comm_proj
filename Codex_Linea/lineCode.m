%% Prologue
% Clearing Command Window
close all;
clc;
% Defining the length of row vector
n = 10;
% Defining the bitrate
bitrate = 1;
% Defining the row vector of 0's and 1's (R A N D O M)
%r = randi([0,1],1,n)
r = [1 0 0 1 0 1];
% Defining a flag to exit the incoming loop
loop_flag = 0;

%% Switching between different outputs
fprintf('Please Select the Desired Line Code Output  >>\n');
fprintf('1)Case I: Polar NRZ Line Encoding \n');
fprintf('2)Case II: Inverted Polar NRZ Line Encoding \n');
fprintf('3)Case III: Polar RZ Line Encoding \n');
fprintf('4)Case IV: AMI Line Encoding \n');
fprintf('5)Case V: Manchester Line Encoding \n');
fprintf('6)Case VI: MLT-3 Line Encoding \n');
fprintf('7)Case VII: Exit Code \n');
while (loop_flag == 0)
    choice = input('Your Choice: ');
    switch choice
        case 1
            Polar_NRZ(r, bitrate); 
        case 2
            Polar_NRZ_INV(r, bitrate); 
        case 3
            Polar_RZ(r, bitrate); 
        case 4
            AMI(r, bitrate); 
        case 5
            Manchester(r, bitrate); 
        case 6
            MultiLevel3(r, bitrate); 
        case 7
            loop_flag = 1;
        otherwise
            fprintf('Invalid Input! Try Again \n');
    end
end

%% Goodbye Message
fprintf('\n');
disp("Thank You for Using Project Codex Linea.");
fprintf('\n');
disp("Sayonara!");
