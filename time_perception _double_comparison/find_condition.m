function [image, duration] = find_condition(number, exp_type)
% Uses the assigned condition number to find the image and duration needed
% for the trial. 
    if exp_type == "replication"
        num_images = length(stimulus_type);
        num_durations = length(durations);
        image_index = mod(number, num_images);
        image = stimulus_type(image_index);
        duration = durations((number-image_index)/num_durations);
    elseif exp_type == "comparison_single"
        image = stimulus;
        duration = comp_durations(number);
    else 
        % FIXME: Check this and make sure it works. 
        num_images = length(comp_stimuli);
        num_std_durations = len(twoimage_standard_durations);
        num_comp_durations = numel(twoimage_comp_durations)/num_std_durations;
        image_index = mod(number, num_images);
        image = comp_stimuli(image_index);
        duration_index = number - image_index;
        std_duration_index = mod(duration_index, num_std_durations);
        comp_duration_index = (duration_index - std_duration_index)/num_comp_durations;
        std_duration = twoimage_standard_durations(std_duration_index);
        comp_duration = two_image_comp_durations(std_duration_index, comp_duration_index);
        duration = [std_duration, comp_duration];
    end
end