% Lecture2_28Jun2019.m

clear all; close all; clc;

%% Data Class Logical Checking

% numeric: double
% char: character
% boolean (logical)

% matrices (vectors), cells, structures

clc;
a = 1;
% isfloat(a)
% isnumeric(a)
% isinteger(a)

b = 'words';
% ischar(b)

c = false;
% islogical(c)

% This the more general function for checking data class equivalence
% isa(a, 'double')

%% Data Class Transformations

% numeric --> character
clc;
a = magic(4);
% aStr = num2str(a)
% aStr = int2str(a)
% aStr = mat2str(a)

% character --> numeric
b = '1';
bNum = str2double(b);
b = '1 2 3 4';
bNum = str2num(b);

% matrix <--> cells
c = magic(4); % matrix
% cCell = num2cell(c);
% cCell = num2cell(c, 1);
% cCell = num2cell(c, 2);
cCell = mat2cell(c, [2 2], [3 1]);
cMat = cell2mat(cCell);

d.a = a;
d.b = b;
d.c = magic(5);
% dCell = struct2cell(d);
% dStr = cell2struct([dCell dCell], {'a', 'b', 'c'});

%% Initialization
% make the variable, before using the variable

clc;

% numeric / matrix
a = []; % empty matrix
% a = NaN(5, 5); % initialize with specific size
% a = zeros(5, 5);
% a = ones(5, 5);

% character
b = ''; % empty quotes
% b = char(1, 2);
% b = string();

% cells
c = {};
c = cell(3, 2);

% structures
d = struct(); % step 1
d(1:2) = struct(); % step 2: structure with size
d = struct('field1', [], 'field2', '');

% helpful functions
% isempty([])
% exist('b', 'var') % does a variable named 'b' exist?
% isfield(d, 'field') % does the fieldname 'field1' exist in structure 'd'

%% Control Flow

clc;
% if/elseif/else control flow
a = randn(1); % random positive or negative value
% a = 0;
if (a > 0) % if a is positive
    fprintf('condition 1: positive\n');
    b = a + 1;
elseif (a < 0) % if a is negative
    fprintf('conditon 2: negative\n');
    b = a - 1;
else % default: no condition is met
    fprintf('else condition: a == 0\n');
    b = 0;
end

% switch control flow
switchValue = 'auditory';
switch switchValue
    case {'retinotopy', 'ret', 'r', 1}
        fprintf('Retinotopy\n');
    case {'auditory', 'aud', 'a', 2}
        fprintf('Auditory\n');
    otherwise % default bucket
        fprintf('What the fuck is this?\n');
end
