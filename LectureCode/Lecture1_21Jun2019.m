% Lecture1_21Jun2019.m

clear all; close all; clc;

a = 1; % numeric data class

b = 'hello123'; % character data class (aka 'string')

c = true; % logical data class (aka 'boolean')

d = @(x) 2 + x; % function_handle data class
e = @(x,y) y * d(x); % can call a function in a function 

mat1 = [1 2 3 4]; % matrix arrays, row vector
mat1 = 1:0.33:4; % incremental values >> start & end values
mat1 = linspace(1, 4, 10); % number of values >> increment value

mat2 = [1; 2; 3; 4]; % matrix arrays, column vector
mat2 = (1:4).'; % row vector transpose = column vector 
mat2 = linspace(1, 4, 10).';

mat3 = [1 2 3 4;
        2 3 4 5;
        3 4 5 6;
        4 5 6 7]; % matrix array, actual matrix
mat3 = [1:4; 2:5; 3:6; 4:7]; 

cell1 = {mat1 mat2 mat3; 
         a b d}; % cell array

str(1).a = 1;
str(1).b = 1:4;
str(1).c = 'hello world!';

str(2).a = 2;
str(2).b = [];
str(3).c = '';

%% Subsetting

clc;

mat3; % original matrix
mat3(2:3, 2:3); % subset middle 2x2 box

mat3(4,:); % subsets row 4
mat3(:,2); % subsets column 2

class(cell1(1)); % cell class
class(cell1{1}); % double class

value1 = cell1(1,:); % this is correct
value2 = cell1{1,:}; % this is incorrect

cell1{1}(1); % nested subsetting, not suggested, but possible
cell1{2,2}(5); % 'o' from 'hello world!'

str(1).a = 1;
str(2).a = 2;
str(3).a = 3;

value2 = str.a; % this is incorrect
value2 = [str.a]; % concatenate structure fields by row
value2 = cat(1, str.a); % concatenate structure fields by column 

%% Bad Example, Don't do this :(

str1.a = 1;
str1.b = 2;
str1.c = 3;

str2.a = 5;
str2.b = 6;
str2.c = 7;
str2.str = str1;

str1.str = str2;
str3 = str1.str; % convoluted nonsense, don't do this

%% Indexing

clc;
f = magic(5);

% conditional operators
% < % less than
% <= % less than or equal
% > % greater than
% >= % greater than or equal
% == % equals 
% | % or
% & % and
% 
% || % stricter or 
% && % stricter and
% 
% isequal(a,b) % everything must be the same

% index = f <= 5 | f >= 20;
index = f <= 5;
f(index); % logical indexing

condition1 = [1 2 4 5 6 1 4 6 9 1 7 4 8 5];
condition2 = [9 1 3 8 1 3 8 1 7 4 1 0 3 7];
index = condition1 == 6 & condition2 == 1;

index1 = condition1 == 6;
index2 = condition2 == 1;
index = [index1; index2];
all(index,2); % functional equivalent to &
any(index,1); % functional equivalent to |

g = 11:20;
% index = [5 6 3 2 10 9 1 4 7 8];
index = randperm(length(g)); % random shuffle
g(index);

h = magic(10);
index = randperm( size(h,1) );
h(index,:);
index = randperm( size(h,2) );
h(:,index);

index1
find(index1)
    