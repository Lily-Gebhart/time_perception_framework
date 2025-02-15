function [stimulus, duration, response] = run_trial(stimulus, duration, response_type, background_color, black, ...
    directory_link, window, screenYpixels, screenXpixels)
% Function to run each trial. 
% Requires knowledge of the 
%   stimuli used on each trial (list), 
%   durations each stimulus should be displayed for (list, measurements in seconds),
%   and the response_type (indicated in the main experiment function).
% Returns the trial response. 

if stimulus == "default"
    stimulus_link = directory_link + "default.jpg";
else
    stimulus_link = directory_link + stimulus;
end
texture = Screen('MakeTexture', window, resize_image(imread(stimulus_link), screenYpixels));
Screen('DrawTexture', window, texture, [], [], 0);
Screen('Flip', window);
WaitSecs(duration);
Screen('FillRect', window, background_color);
Screen('Flip', window);
WaitSecs(0.5);

% Response signal
Screen('FillRect', window, background_color);
Screen('Flip', window);
Screen('TextSize', window, round(screenXpixels/40));
Screen('TextFont', window, 'Arial');
DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);   
Screen('Flip', window);
response = collect_replication_response(response_type);
Screen('FillRect', window, background_color);
Screen('Flip', window);
WaitSecs(1);
end