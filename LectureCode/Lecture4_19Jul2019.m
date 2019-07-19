% Lecture4_19Jul2019.m

clear all; close all; clc;

%% Absolute vs. Relative Pathing

% absolute pathing
% typically starts from the computer source directory
% / in linux and macs
% C: in windows

% fullfile(pwd, 'Lecture4')
% cd './Lecture4'
% cd ~

mainDirectory = pwd;
dataDirectory = fullfile(mainDirectory, 'Lecture4');

%% File Listing within a Directory

dataFiles = fullfile(dataDirectory, '*.txt');
files = dir(dataFiles);
fileNames = {files.name};

filePaths = fullfile(dataDirectory, fileNames);
% [path,name,ext] = fileparts(filePaths{1})

%% Regular Expression Definitions

clc;
str = 'Today bagel I ate a bagel';

% anchors
% ^expr - matches beginning of text string
expr = '^Today';

% expr$ - matches end of text string
expr = 'bagel$';

%% Metacharacters

clc;
str = 'may bay hay lay play 0ay';

% metacharacters
% . - any character
expr = '.ay';

% [] - any character contained within the brackets
expr = '[0lh]ay';
expr = '[a-z]ay';
expr = '[A-Z]ay';
expr = '[0-9]ay';
expr = '[a-zA-Z0-9]ay';

% [^] - any character NOT contained within the brackets
expr = '[^0hl]ay'; 

%% Shorthand RegExp Expressions

clc;
str = 'may bay hay lay play 0ay';

% \w - any word character [a-zA-Z0-9]
expr = '\way'; % equivalent to next line
expr = '[a-zA-Z0-9]ay'; % equivalent to previous line

% \W - NOT any word character [^a-zA-Z0-9]
expr = '\Way';

% \d - any digit [0-9]
% \D - NOT any digit [^0-9]
% \s - any whitespace [ \t\r\n\f\v]
% \S - NOT any whitespace [^ \t\r\n\f\v]

%% Quantifies

clc;
str = 'may bay hay lay play 0ay';
str = 'kelly';

% {n,m} - match between n and m occurences
expr = '.{1,2}ay';

% * - match 0 or more occurences
% + - match 1 or more occurences
% ? - match 0 or 1 occurences

str = 'i have ducks';
expr = 'ducks?';

expr = '.*txt';

regexp(str, expr, 'match')

% escape metacharacter symbold status with a \ in front of the character
% therefore, '\.' will match periods and not any character

%% Grouping and Tokens

clc;
str = 'kelly is teaching MATLAB';

% grouping with () parentheses
expr = '(?<firstname>kelly)';

regexp(str, expr, 'match')

%% regexp()

clc;
str = 'Romeo and Juliet';
expr = '\w+';

regexp(str, expr, 'start')
regexp(str, expr, 'end')
regexp(str, expr, 'match')

expr = '(?<match>\w+)';
s = regexp(str, expr, 'names');

expr = '\s+';
regexp(str, expr, 'split')

%% regexprep()

str = 'Romeo and Juliet';
expr = 'and';
rpl = '&';

regexprep(str, expr, rpl)

str = fileNames';
% expr = '\D_\w+';
% rpl = 'C';

% expr = '._Set1';
% rpl = 'C';
regexprep(str, expr, rpl)

%% Additional Options

regexpi(str, expr);
regexprep(str, expr, rpl, 'ignorecase');
regexprep(str, expr, rpl, 'once');

%% Builtin MATLAB String Functions

% string compare
strcmp(str, compStr) % strcmpi()

% string find
strfind(str, compStr) % regexp(str, expr, 'start')

% string split and string join 
strsplit(str, delimiter) % regexp(str, expr, 'split')
strjoin(str, delimiter)

% starts with (^) and ends with ($)
startsWith(str, compStr) % regexp(str, '^expr')
endsWith(str, compStr) % regexp(str, 'expr$')
contains(str, compStr) % returns booleans
