function [result] = run_trial(stimuli, durations, exp_type, response_type)
% Function to run each trial. 
% Requires knowledge of the 
%   stimuli used on each trial (list), 
%   durations each stimulus should be displayed for (list, measurements in seconds),
%   and the response_type (indicated in the main experiment function).
% Returns the trial response. 

if exp_type == "comparison_double" && comp_order == "random"
    stimuli = stimuli(randperm(length(stimuli)));

for i = 1:length(stimuli)
    Screen('DrawTexture', window, stimuli(i), [], [], 0);
    Screen('Flip', window);
    WaitSecs(durations(i));
    Screen('FillRect', window, background_color); % Uses universal parameter.
    Screen('Flip', window);
    WaitSecs(0.5);
end

% Response signal
WaitSecs(0.5);
Screen('FillRect', window, gray);
Screen('Flip', window);
Screen('TextSize', window, round(screenXpixels/40));
Screen('TextFont', window, 'Arial');
DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);   
Screen('Flip', window);

if exp_type == "replication"
    response = collect_replication_response(response_type);
    result = [stimuli, durations, response];
else
    response = collect_comparison_response();
    if exp_type == "comparison_single"
        % Altering response to fit what it needs to be for table
        result = [stimuli, durations, response];
    elseif exp_type == "comparison_double"
        result = [stimuli(1), stimuli(2), durations(1), durations(2), response];
    end
end
end