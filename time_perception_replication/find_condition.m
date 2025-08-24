% FUNCTION: Function to find the stimulus, standard duration, and
% comparison duration to present an image for, given a trial indicator
% number. 
function [image, duration] = find_condition(stimulus_type, durations, number)
% Uses the assigned condition number to find the image and duration needed
% for the trial. 
        num_images = length(stimulus_type);
        num_durations = length(durations);
        image_index = mod(number, num_images) + 1;
        image = stimulus_type(image_index);
        duration_index = mod(number-image_index, num_durations) + 1;
        duration = durations(duration_index);
end