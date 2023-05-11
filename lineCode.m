%% Prologue
% Clearing Command Window
close all;
clc;
% Defining the length of row vector
n = 10;
% Defining the row vector of 0's and 1's (R A N D O M)
r = randi([0,1],1,n)
% Defining a flag to exit the incoming loop
loop_flag = 0;

%% Switching between different outputs
fprintf('Please Select the Desired Line Code Output  >>\n');
fprintf('1)Case I: Polar NRZ \n');
fprintf('2)Case II: Polar NRZ Inverted \n');
fprintf('3)Case III: Polar RZ \n');
fprintf('4)Case IV: Bipolar RZ (AMI) \n');
fprintf('5)Case V: Manchester NRZ Split Phase \n');
fprintf('6)Case VI: Multi-level Transmission 3 \n');
fprintf('7)Case VII: Exit Code \n');
while (loop_flag == 0)
    choice = input('Your Choice: ');
    switch choice
        case 1
            Polar_NRZ(r); 
        case 2
            Polar_NRZ_INV(r); 
        case 3
            Polar_RZ(r); 
        case 4
            AMI(r); 
        case 5
            Manchester(r); 
        case 6
            MultiLevel3(r); 
        case 7
            loop_flag = 1;
        otherwise
            fprintf('Invalid Input! Try Again \n');
    end
end

%% Goodbye Message
disp("\nThank You for Using Project Codex Linea.");
fprintf('\n');
disp("Sayonara!");

