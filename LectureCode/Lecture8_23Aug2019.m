% Lecture8_23Aug2019.m

clear all; close all; clc;

%%

devices = PsychHID('Devices');
keyboardDevice = 5; % internal keyboard

answerKey = {'f', 'j'}; % f = left, j = right
try
    ListenChar(-1); % suppress keyboard input
    KbEventFlush(keyboardDevice); % clear keyboard queue
    Screen('Preference', 'Verbosity', 0);
    Screen('Preference', 'SkipSyncTests', 1);
    
    screenNumber = Screen('Screens');
    rect = Screen('Rect', screenNumber);
    windowSize = rect / 3; % reduced window size
    fr = Screen('FrameRate', screenNumber);
    
    fontColor = WhiteIndex(screenNumber); % white
    bkColor = BlackIndex(screenNumber); % black
    [windowPtr,rect] = Screen('OpenWindow', screenNumber, bkColor, ...
        windowSize);
    xCenter = mean(1:rect(3)); yCenter = mean(1:rect(4));
    
    Screen('DrawText', windowPtr, 'Response Please!', ...
        xCenter, yCenter, fontColor);
    Screen('Flip', windowPtr);
    
    %     [~,~,keyCode] = KbCheck(keyboardDevice);
    %     while ~any(strcmp(answerKey, KbName(keyCode)))
    %         [~,~,keyCode] = KbCheck(keyboardDevice);
    %     end
    %     userInput = KbName(keyCode);
    
    responseTime = 5; % maximum response time, seconds
    userInput = cell(ceil(responseTime * fr), 1);
    startTime = GetSecs();
    while (GetSecs()-startTime) < responseTime 
        currentFrame = ceil((GetSecs()-startTime) * fr);
        [~,~,keyCode] = KbCheck(keyboardDevice);
        userInput{currentFrame} = KbName(keyCode);
    end
    endTime = GetSecs() - startTime;
    
    Screen('Flip', windowPtr); % refresh the screen
    
%     startTime = GetSecs();
%     WaitSecs(2); % wait time, seconds
%     endTime = GetSecs() - startTime;
    
    Screen('CloseAll');
    ListenChar(0); % unsupress keyboard input
catch ME
    Screen('CloseAll');
    ListenChar(0); % unsupress keyboard input
    rethrow(ME);
end
