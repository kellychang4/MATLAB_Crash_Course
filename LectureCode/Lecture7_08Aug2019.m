% Lecture7_08Aug2019.m

clear all; close all; clc;

%% Draw Shapes

try
    Screen('Preference', 'Verbosity', 0);
    Screen('Preference', 'SkipSyncTests', 1);
    
    screenNumber = Screen('Screens');
    rect = Screen('Rect', screenNumber);
    windowSize = rect / 3; % reduce the open window size
    
    black = BlackIndex(screenNumber);
    white = WhiteIndex(screenNumber);
    gray = GrayIndex(screenNumber);
    
    fr = Screen('FrameRate', screenNumber); % Hz
    ifi = 1 /fr; % seconds
    [windowPtr,rect] = Screen('OpenWindow', screenNumber, gray, windowSize);
    [xCenter,yCenter] = RectCenter(rect);
    
    fixDotSz = 10; % pixels
    fScale = @(x) [-x/2 -x/2 x/2 x/2];
    centerRect = [xCenter yCenter xCenter yCenter];
    fixRect = centerRect + fScale(fixDotSz);
    Screen('FillOval', windowPtr, [255 0 0], fixRect);
    
    Screen('Flip', windowPtr); 
    WaitSecs(5); % seconds
    
    Screen('Flip', windowPtr); % clear screen;
    WaitSecs(5); 
    
    Screen('CloseAll');
    
catch ME
    Screen('CloseAll');
    rethrow(ME);
end

%% Draw Text

try
    Screen('Preference', 'Verbosity', 0);
    Screen('Preference', 'SkipSyncTests', 1);
    
    screenNumber = Screen('Screens');
    rect = Screen('Rect', screenNumber);
    windowSize = rect / 3; % reduce the open window size
    
    black = BlackIndex(screenNumber);
    white = WhiteIndex(screenNumber);
    gray = GrayIndex(screenNumber);
    
    fr = Screen('FrameRate', screenNumber); % Hz
    ifi = 1 /fr; % seconds
    [windowPtr,rect] = Screen('OpenWindow', screenNumber, gray, windowSize);
    [xCenter,yCenter] = RectCenter(rect);
    
    Screen('DrawText', windowPtr, 'Hello!', xCenter, yCenter);
    DrawFormattedText(windowPtr, 'Hello World!', 'center', 'center');
    
    Screen('Flip', windowPtr); 
    WaitSecs(5); % seconds
    
    Screen('Flip', windowPtr); % clear screen;
    WaitSecs(2); 
    
    Screen('CloseAll');
    
catch ME
    Screen('CloseAll');
    rethrow(ME);
end

%% Draw Images / Textures

try
    Screen('Preference', 'Verbosity', 0);
    Screen('Preference', 'SkipSyncTests', 1);
    
    screenNumber = Screen('Screens');
    rect = Screen('Rect', screenNumber);
    windowSize = rect / 3; % reduce the open window size
    
    black = BlackIndex(screenNumber);
    white = WhiteIndex(screenNumber);
    gray = GrayIndex(screenNumber);
    
    fr = Screen('FrameRate', screenNumber); % Hz
    ifi = 1 /fr; % seconds
    [windowPtr,rect] = Screen('OpenWindow', screenNumber, gray, windowSize);
    Screen('BlendFunction', windowPtr, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    [xCenter,yCenter] = RectCenter(rect);

    img = imresize(imread('sherlock.jpg'), 0.3); 
%     img(:,:,4) = any(img >= 200, 3) * 255; % bright pixel mask
%     img = rgb2gray(img);
%     img(:,:,2) = (img >= 200) * 255; % gray scale intensity mask

    x = 1:size(img,2); y = 1:size(img,1); 
    xImg = mean(x); yImg = mean(y);
    [x,y] = meshgrid(x, y);
    r = sqrt((x-xImg).^2 + (y-yImg).^2);
    circleIndx = r <= 80; % circle aperture index
    img(:,:,4) = circleIndx * 255;
    textureIndex = Screen('MakeTexture', windowPtr, img);
    
    Screen('DrawTexture', windowPtr, textureIndex);
    Screen('Flip', windowPtr); 
    WaitSecs(4); % seconds
    
    Screen('Flip', windowPtr); % clear screen;
    WaitSecs(1); 
    
    Screen('CloseAll');
    
catch ME
    Screen('CloseAll');
    rethrow(ME);
end

