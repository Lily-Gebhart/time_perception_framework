function [est_time, total_num_trials, results_table, exp_condition_list, train_condition_list, break_times] = setup_task(exp_type)
    % Total number of trials and conditions in the experiment
    if exp_type == "replication"
        total_num_conditions = length(stimulus_type) * length(durations);
        total_num_trials = total_num_conditions * num_trials;
    elseif exp_type == "comparison_single"
        total_num_conditions = length(comp_durations);
        total_num_trials = total_num_conditions * num_comp_trials;
    else 
        total_num_conditions = numel(two_image_comp_durations) * length(comp_stimuli);
        total_num_trials = total_num_conditions * num_comp_trials;
    end 

    % Creating the randomized experiment and training condition numbers
    exp_condition_list = repmat(1:total_num_conditions, 1, num_trials);
    exp_condition_list = exp_condition_list(randperm(length(exp_condition_list)));
    train_condition_list = randperm(total_num_conditions, num_training_trials);
    
    % Determining break times based on the specified number of breaks.
    break_times = round(linspace(1, total_num_trials, num_breaks+2)); 
    break_times = break_times(:, 2:num_breaks+1);
    
    % Creating the results table. 
    if exp_type == "replication"
        table_var_types = ["string", "double", "int8"];
        table_var_names =  ["Image1", "Time_Condition", "Response"];
        results_table = table('Size', [total_num_trials 3], 'VariableTypes', table_var_types, 'VariableNames', table_var_names);
    elseif exp_type == "comparison_single"
        table_var_types = ["string", "double", "string"];
        table_var_names =  ["Image1", "Time_Condition", "Response"];
        results_table = table('Size', [total_num_trials 3], 'VariableTypes', table_var_types, 'VariableNames', table_var_names);
    else 
        table_var_types = ["string", "string", "double", "double", "int8"];
        table_var_names =  ["Standard_Image", "Comp_Image", "Standard_Time_Condition", "Comp_Time_Condition", "Response"];
        results_table = table('Size', [total_num_trials 5], 'VariableTypes', table_var_types, 'VariableNames', table_var_names);
    end

    % Determining estimated experiment time. Includes training and
    % experimental durations, response time, segway time of 1 second per
    % experiment, and 300 seconds of introduction and break time.
    if exp_type == "replication"
        est_time = 2*(mean(durations) * num_training_trials) + 2*sum(num_trials * durations) + 300 + (total_num_trials + num_training_trials);
    elseif exp_type == "comparison_single"
        est_time = (mean(durations) + 0.5)*num_training_trials + sum(num_trials * (durations + 0.5)) + 300 + (total_num_trials + num_training_trials);
    else
        est_time = 2*mean(durations)*num_training_trials + 2*sum(num_trials *durations) + 300 + (total_num_trials + num_training_trials);
    end
    % Converting to minutes
    est_time = est_time / 60;
end