% FUNCTION: Function to run each trial. 
function [response] = run_trial(stimulus, standard_duration, comp_duration, comp_order, comp_type, back_color, black, directory_link, window, screenXpixels, screenYpixels)

if comp_order == "random"
    order = randperm(2);
    if order(1) == 1
        duration1 = standard_duration;
        duration2 = comp_duration;
    else
        duration1 = comp_duration;
        duration2 = standard_duration;
    end
else
    duration1 = standard_duration;
    duration2 = comp_duration;
end

stimulus_link = directory_link + stimulus;

% Fixation cross
Screen('FillRect', window, back_color);
Screen('Flip', window);
Screen('TextSize', window, round(screenXpixels/40));
Screen('TextFont', window, 'Arial');
DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);   
Screen('Flip', window);
WaitSecs(1);

% Draw first image to screen
texture = Screen('MakeTexture', window, resize_image(imread(stimulus_link), screenYpixels));
Screen('DrawTexture', window, texture, [], [], 0);
Screen('Flip', window);
WaitSecs(duration1);

% Fixation cross
Screen('FillRect', window, back_color);
Screen('Flip', window);
Screen('TextSize', window, round(screenXpixels/40));
Screen('TextFont', window, 'Arial');
DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);   
Screen('Flip', window);
WaitSecs(1);

% Draw second image to screen
Screen('DrawTexture', window, texture, [], [], 0);
Screen('Flip', window);
WaitSecs(duration2);
Screen('FillRect', window, back_color);
Screen('Flip', window);

% Response signal
Screen('FillRect', window, back_color);
Screen('Flip', window);

response = collect_comparison_response(comp_type);
% Switching response order if presentation was random
if response == "shorter" && duration1 == comp_duration
    response = "longer";
elseif response == "longer" && duration1 == comp_duration
    response = "shorter";

WaitSecs(1);
end