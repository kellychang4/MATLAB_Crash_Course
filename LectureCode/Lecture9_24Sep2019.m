% Lecture9_24Sep2019.m

clear all; close all; clc;

%% Variables

% Number of Trials
nTrials = 16;

% Number of Blocks / Conditions
nConditions = 2; 

% Timing Information 
ISI = 0.25; % seconds
responseTime = 4; % seconds
stimulusTime = 1; % seconds
trialTime = (2*stimulusTime) + ISI + responseTime;

% Response Criteria
responseKeys = 'fj' ; % f = 1st interval, j = 2nd interval

% Stimulus Structure
% Stimulus 1 = Red Circle
% Stimulus 2 = Green Square

%% Protocol / Paradigm / Trial Structure

paradigm = zeros(nTrials, 3); % [nTrials condition userResponse]
paradigm(:,1) = 1:nTrials;
paradigm(:,2) = repmat(1:nConditions, 1, nTrials/2);
paradigm(:,2) = paradigm(randperm(nTrials), 2);

%% Experimental Code

devices = PsychHID('Devices');
keyboardDevice = 3; % internal keyboard device
try
    ListenChar(-1); % suppresses keyboard input
    KbEventFlush(keyboardDevice); % clear keyboard queue
    Screen('Preference', 'Verbosity', 0); 
    Screen('Preference', 'SkipSyncTests', 1); 
    
    screenNumber = Screen('Screens');
    rect = Screen('Rect', screenNumber);
    fr = Screen('FrameRate', screenNumber); 
    
    fontColor = WhiteIndex(screenNumber);
    bkColor = BlackIndex(screenNumber); 
    windowSize = rect / 3; % reduced window size
    [windowPtr,rect] = Screen('OpenWindow', screenNumber, bkColor, windowSize);
    xCenter = mean(1:rect(3)); yCenter = mean(1:rect(4));
    
    nPixel = 100;
    redCircle = uint8(zeros(nPixel, nPixel, 3));
    [xStim,yStim] = meshgrid(1:nPixel); 
    center = mean(1:nPixel);
    rCircle = sqrt((xStim-center).^2 + (yStim-center).^2);
    rIndx = rCircle <= 40;
    redCircle(:,:,1) = rIndx * 255;
    redCircleIndx = Screen('MakeTexture', windowPtr, redCircle);
    
    greenRect = uint8(zeros(nPixel, nPixel, 3));
    gIndx = xStim >= 3 & xStim <= (nPixel-3) & yStim >= 3 & yStim <= (nPixel-3);
    greenRect(:,:,2) = gIndx * 255;
    greenRectIndx = Screen('MakeTexture', windowPtr, greenRect);
    
    imgSize = size(redCircle); imgSize = imgSize(1:2);
    imgRect = @(x,y,s) [x-s(1)/2 y-s(2)/2 x+s(1)/2 y+s(2)/2];
    destRect = imgRect(xCenter, yCenter, imgSize);

    Screen('DrawTexture', windowPtr, redCircleIndx, [], destRect);
    Screen('DrawTexture', windowPtr, greenRectIndx, [], destRect);
    
    for i = 1:nTrials
        if paradigm(i,2) == 1 % condition A
            img1 = redCircleIndx; img2 = greenRectIndx;
        else % condition B
            img1 = greenRectIndx; img2 = redCircleIndx;
        end
        
        Screen('DrawTexture', windowPtr, img1, [], destRect);
        Screen('Flip', windowPtr);
        WaitSecs(stimulusTime);
        
        Screen('Flip', windowPtr);
        WaitSecs(ISI);
        
        Screen('DrawTexture', windowPtr, img2, [], destRect);
        Screen('Flip', windowPtr);
        WaitSecs(stimulusTime);
        
        Screen('Flip', windowPtr); % clear screen

        startTime = GetSecs(); % start response clock
        while (GetSecs()-startTime) < responseTime 
            Screen('DrawText', windowPtr, 'Response', ...
                xCenter-20, yCenter-20, fontColor);
            Screen('Flip', windowPtr);
            
            [~,~,keyCode] = KbCheck(keyboardDevice);
            
            if keyCode(KbName(responseKeys(1))) == 1 % if f was pressed
                paradigm(i,3) = 1; % 1st interval
                break;
            elseif keyCode(KbName(responseKeys(2))) == 1 % if j was pressed
                paradigm(i,3) = 2; % 2nd interval
                break;
            end
        end
        
        while (GetSecs()-startTime) < responseTime; end
    end
    
    saveName = 'results.mat';
    save(saveName, 'paradigm');
    
    ListenChar(0); % unsuppress keyboard input
    Screen('CloseAll');
catch ME
    ListenChar(0); % unsuppress keyboard input
    Screen('CloseAll');
    rethrow(ME);
end

