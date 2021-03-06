clear all; close all;

nTrials = 16;
paradigm = zeros(nTrials, 3); % [nTrial condition userAnswer]
paradigm(:,1) = 1:nTrials;
paradigm(:,2) = repmat([1 2], 1, nTrials/2);
paradigm(:,2) = paradigm(randperm(nTrials), 2);
presentTime = 0.5; % seconds
presentISI = 0.25; % seconds

answerKey = [KbName('f') KbName('j')]; % f == left, j == right
answerTime = 4; % seconds

ISI = 0.25; % seconds
nBreaks = 2; nBlocks = nBreaks + 1;
trialBreak = floor(nTrials / nBlocks);
breakAfterTrial = (1:nBreaks) * trialBreak;
breakKey = 'space';

devices = PsychHID('Devices');
keyboardDevice = 6;
try
    ListenChar(-1); % suppress keyboard input
    KbEventFlush(keyboardDevice); % clear keyboard queue
    Screen('Preference', 'Verbosity', 0);
    Screen('Preference', 'SkipSyncTests', 1);
    
    screenNumber = Screen('Screens');
    rect = Screen('Rect', screenNumber);
    fr = Screen('FrameRate', screenNumber);
    
    fontColor = WhiteIndex(screenNumber); % white
    bkColor = BlackIndex(screenNumber); % black
    windowSize = rect / 3; % reduced window size
    [windowPtr,rect] = Screen('OpenWindow', screenNumber, bkColor, windowSize);
    xCenter = mean(1:rect(3)); yCenter = mean(1:rect(4));
    xStrPad = rect(3) * 0.2; yStrPad = rect(4) * 0.04;

    img = imresize(imread('sherlock.jpg'), 0.25);
    imgSize = size(img); imgSize = imgSize([2 1]);
    imgRect = @(x,y,s) [x-s(1)/2 y-s(2)/2 x+s(1)/2 y+s(2)/2];
    destRect = imgRect(xCenter, yCenter, imgSize); 
    texture = Screen('MakeTexture', windowPtr, img);
    
    breakCount = 0;
    for i = 1:nTrials
        
        Screen('DrawTexture', windowPtr, texture, [], destRect+randn(size(destRect)));
        Screen('Flip', windowPtr); % present image 1
        WaitSecs(presentTime);
        
        Screen('Flip', windowPtr); 
        WaitSecs(presentISI); % black screen
        
        Screen('DrawTexture', windowPtr, texture, [], destRect+randn(size(destRect)));
        Screen('Flip', windowPtr); % present image 2
        WaitSecs(presentTime);
        
        Screen('Flip', windowPtr); % black screen
        
        startTime = GetSecs();
        while ((GetSecs()-startTime) < answerTime) && ~paradigm(i,3)
            Screen('DrawText', windowPtr, 'Response', ...
                xCenter-20, yCenter+yStrPad, fontColor);
            Screen('DrawText', windowPtr, ...
                sprintf('%0.2f s', GetSecs()-startTime), ...
                xCenter-20, yCenter-yStrPad, fontColor);
            Screen('Flip', windowPtr); 
            
            [~,~,keyCode] = KbCheck(keyboardDevice);
            if any(answerKey(1) == find(keyCode))
                paradigm(i,3) = 1;
            elseif any(answerKey(2) == find(keyCode))
                paradigm(i,3) = 2;
            end
        end
        
        WaitSecs(ISI); % wait ISI
        
        if any(breakAfterTrial == i)
            breakCount = breakCount + 1;
            Screen('DrawText', windowPtr, ...
                sprintf('Break %d out of %d', breakCount, nBreaks), ...
                xCenter-xStrPad, yCenter+yStrPad, fontColor);
            Screen('DrawText', windowPtr, ...
                sprintf('Press [%s] to continue', breakKey), ...
                xCenter-xStrPad, yCenter-yStrPad, fontColor);
            Screen('Flip', windowPtr);
            
            [~,~,keyCode] = KbCheck(keyboardDevice);
            while ~any(strcmp(KbName(keyCode), breakKey))
                [~,~,keyCode] = KbCheck(keyboardDevice);
            end
        end
    end
    
    Screen('CloseAll');
    ListenChar(0) % unsuppress keyboard input
catch ME
    Screen('CloseAll');
    ListenChar(0) % unsuppress keyboard input
    rethrow(ME);
end
