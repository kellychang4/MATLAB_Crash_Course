% Lecture6_02Aug2019.m

clear all; close all; clc;

%% Basic Function Writing

output1 = functionName(arg1);
[~,output2] = functionName([], arg2);

% function [output1,output2] = functionName(arg1, arg2)
% end

%% Modular Function Thinging / Writing
% aka. rock, paper, scissors

% clc;
% playRound();
% 
% function [userThrow] = getUserThrow()
% userThrow = ''; % initialize
% while isempty(userThrow)
%     userThrow = input('rock (r), paper (p), scissors (s)? ', 's');
%     userThrow = lower(userThrow(1));
%     if ~any(strcmp(userThrow, {'r', 'p', 's'}))
%         fprintf('invalid response\n');
%         userThrow = '';
%     end
% end
% end
% 
% function [computerThrow] = getComputerThrow()
% allAnswer = 'rps';
% computerThrow = allAnswer(randi(3, 1));
% end
% 
% function printThrows(userThrow, computerThrow)
% fprintf('(user) %s vs %s (computer)\n', userThrow, computerThrow);
% end
% 
% function [] = compareThrows(userThrow, computerThrow)
% if strcmp(userThrow, computerThrow) % draw condition
%     fprintf('Draw!\n');
% elseif strcmp(userThrow, 'r') && strcmp(computerThrow, 's')
%     fprintf('You Win!\n');
% elseif strcmp(userThrow, 'p') && strcmp(computerThrow, 'r')
%     fprintf('You Win!\n');
% elseif strcmp(userThrow, 's') && strcmp(computerThrow, 'p')
%     fprintf('You Win!\n');
% else
%     fprintf('Computer Wins!\n');
% end
% end
% 
% function playRound()
% userThrow = getUserThrow();
% computerThrow = getComputerThrow();
% printThrows(userThrow, computerThrow);
% compareThrows(userThrow, computerThrow);
% end

%% Input Control of Functions

% clc;
% % functionName(1, [], true);
% functionName(1, [], true)
% 
% function [output1,output2] = functionName(arg1, arg2, replace)
% 
% % Input Control / Default Arguments
% if isempty(arg2)
%     arg2 = 's';
% end
% 
% if ~isnumeric(arg2)
%     warning('this is a warning message, code will still run');
% %     error('the code won''t work because %s');
% end
% 
% if nargin < 3
%     replace = true;
% end
% 
% % Code!
% 
% arg2
% output1 = 1; 
% output2 = 2;
% nargin
% end

%% Variable Inputs and Outputs of Functions

clc;

functionName(1, 2, 'hello', 1000, 100);

% % functionName(arg1, arg2, option1, option2, option3)
% function [output1,varargout] = functionName(arg1, arg2, varargin)
% 
% arg1
% arg2
% option1 = varargin{1}
% 
% % code!
% % varargout{1} = b;
% % varargout{2} = c;
% 
% end

%% "Strucuture-ized" Function Input / Output Method

clc; 
inputStructure.arg1 = 1;
inputStructure.arg2 = 1;
% inputStructure.option1 = 1;

outputStucture = functionName(inputStructure);

function [outputStructure] = functionName(inputStructure)

if ~isfield(inputStructure, 'option1')
    inputStructure.option1 = false;
end

outputStructure.y = inputStructure.arg1 + inputStructure.arg2;
end
