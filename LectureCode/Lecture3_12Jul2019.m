% Lecture3_12Jul2019.m

clear all; close all; clc;

%% Looping

clc;
% for loops
n = 10;
a = magic(n);
aSEM = NaN(1, n); % initialize aMean vector
for i = 1:n
    aSEM(i) = std(a(:,i)) / sqrt(length(a(:,i)));
end
b = aSEM + randn(size(aSEM));

% while loops
% iteration = 0;a
a = randn(10, 1);
while (mean(a) < 1) % while condition is true, execute while loop
    %     iteration = iteration + 1;
    a = randn(10, 1);
    %     if iteration > 100
    %         break
    %     end
end

% try catch statement
try
    % code to try
catch ME % error message
    % code that will execute when an error is caught ('catch');
    %     save('failstate.mat');
    %     rethrow(ME);
end

%% Search Path
% directory structure order in which MATLAB searches for files / functions

% 0. Functions Defined in Script
% 1. Current Working Directory
% 2. Added Paths (temporarily / permanent)

% permanent: Home --> Environment --> Set Path

% temporarily
addpath('/Desktop/CurrentFolder'); % adds one folder
addpath(genpath('/Desktop/CurrentFolder')); % adds folder with subfolder

% 3. Default MATLAB Documents Path

which filename.m % if all else fails

%% Scope

% global variable (workspace)
% local variable

x = 5; % global variable
y = add(x); % global variable, y

% function y = add(x)
% n = 1; % local variable
% y = x + n; % local variable, y
% end

%% Functions: Global vs. Local Variable

x = 10; 
% only anonymous functions can automatically recognize global variables
f = @(a) a + x; 
f(1) 
% so this works, but not with script function scripts or 
% functions defined at the end of a script

%% Debugging & Commenting!!!

clc;
x = 10; 
f1(x)

function y = f1(x)
y = x + f2(x);
end

function y = f2(x)
a = 1;
y = sum(x2); % error in this line to debug!
end
