function response = run_trial(directory_link, stimulus, duration, comp_type, window, back_color, black, screenXpixels, screenYpixels)
% Function to run each trial. 
% Requires knowledge of the 
%   stimuli used on each trial (list), 
%   durations each stimulus should be displayed for (list, measurements in seconds),
%   and the response_type (indicated in the main experiment function).
% Returns the trial response. 
stimulus_link = directory_link + stimulus;

texture = Screen('MakeTexture', window, resize_image(imread(stimulus_link), screenYpixels));
Screen('DrawTexture', window, texture, [], [], 0);
Screen('Flip', window);
WaitSecs(duration);
Screen('FillRect', window, back_color); 
Screen('Flip', window);
WaitSecs(0.5);

% Response signal
WaitSecs(0.5);
Screen('FillRect', window, back_color);
Screen('Flip', window);
Screen('TextSize', window, round(screenXpixels/40));
Screen('TextFont', window, 'Arial');
DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);   
Screen('Flip', window);

response = collect_comparison_response(comp_type);
WaitSecs(0.5);
end