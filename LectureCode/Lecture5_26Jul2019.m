% Lecture5_26Jul2019.m

clear all; close all; clc;

%% Math!!!

A = magic(5);
a = ones(5, 1) * 27;
x = ones(5, 1) * 0.5;

b = A * x;
b2 = a .* x;

% logarithms
log(x); % natural log - ln
exp(x); % exponential

log2(x); % base 2 log
2.^(x); % base 2 power

log10(x); % base 10 log
10.^(x); % base 10 power

% trigonometric
sin(x); % sine function, radians
sind(x); % sine function, degrees

cos(x); % cosine fucntion, radians
cosd(x); % cosine function, degrees

% complex (i or j)
real(i); % real component
imag(i); % imaginary component
sign(i); % sign of the complex component

% fundamental math functions
sum(x); % sum of a vector
cumsum(x); % cumulative sum

mean(x); % mean of vector 
nanmean(x); % mean without NaNs

median(x); % median
nanmedian(x); % median without NaNs

min(x); % min
nanmin(x); % min without NaNs

max(x); % max
nanmax(x); % max without NaNs

std(x); % standard deviation
nanstd(x); % standard deviation without NaNs

% dimensions
length(x) % length of a vector

size(X); % size of matrices
size(X, 1); % size of first dimension of matrix
size(X, 2); % size of second dimension of matrix

numel(X); % number of elements within matrix

%% Data Manipulation

clc;
I = rgb2gray(imread('sherlock.jpg')); % [x y]
size(I);

% transpose doggo
I_transpose = I.'; % flip dimensions if 2D matrix
size(I_transpose);

x = [1 6 3 2 10 9 4 5];
[sorted_x,sort_index] = sort(x);
x(sort_index);

x = [1 1 1 1 1 1 1 2 4 6];
[unique_x,unique_index] = unique(x);
x(unique_index);

X = zeros(150, 50, 60); % [time x y]
frame1 = X(1,:,:);
size(frame1)

frame1 = squeeze(frame1);
size(frame1)

% drops singleton dimensions
Y = ones(1, 2, 1, 1, 5); 
size(Y)
size(squeeze(Y))

clc;
size(X)
reshape_X = reshape(X, 150, 3000); % same as line below
reshape_X = reshape(X, 150, []); % same as line above
size(reshape_X)
undo_X = reshape(reshape_X, 150, 50, 60);
size(undo_X)

clc;
size(X)
shiftdim_X = shiftdim(X, 1);
size(shiftdim_X)

clc;
size(X)
shiftdim_X = shiftdim(X, -1);
size(shiftdim_X)

clc; 
size(X) % [time x y]
permute_X = permute(X, [3 2 1]); % [y x time]
size(permute_X)

%% Matrix Indexing

clc;
size(I); % sherlock doggo

i = I(500, 800) % matrix index
linear_index = sub2ind(size(I), 500, 800);
i = I(linear_index) % linear index

[row_index,col_index] = ind2sub(size(I), linear_index);
i = I(row_index, col_index)

%% What Should I Plot????

% numerical data (continuous)
% categorical data (categories)

% Number of each type of variable:
% 1 numerical = histogram / density
% 2 numerical = scatterplot
% 1 categorial = barplot, reporting percentages
% 2 categorical = contingency table
% 1 numerical, 1 categorical = barplot

% Try not to go past 3 variables on a plot
% x-axis, y-axis, color

%% Plotting!

x = randn(1, 1000); 

clc;
f = figure(1); clf;
% histogram(x, 50); % number of bins
histogram(x, -3:3); % bin edges
binned_x = histcounts(x, -3:3);

% image
f = figure(2); clf;
% image(I);
imagesc(I);
colorbar % shows colorbar

% plot
func = @(x) (x-1).^2 .* (x + 3);
x = -5:5;
y = func(x);

f = figure(3); clf; hold on
plot(x, y, 'o-.', 'Color', [0.5 0.5 0.5], ...
    'LineWidth', 2, 'MarkerSize', 20);
h = plot(x, y + 50, 's--', ...
    'MarkerSize', 10, 'MarkerEdgeColor', 'b', ...
    'MarkerFaceColor', 'm');
h.MarkerFaceColor = 'g';
l = legend('red', 'Location', 'Northwest');
l.FontSize = 12;
l.Box = 'off';

% errorbar
f = figure(4); clf; hold on;
errorbar(x, y, ones(size(y)) * 5, 'o--');

%% Gaussian Example

x = -5:0.1:5;
y = gaussmf(x, [2 0]);
y2 = y(:) * y(:)';

f = figure(5); clf; hold on
subplot(2,1,1);
imagesc(x, x, y2);
set(gca, 'XLim', [-5 5], 'YLim', [-5 5]);
axis square

subplot(2,1,2); 
plot(x, y, 'r-');

print(f, 'figure.png', '-dpng', '-r300');

