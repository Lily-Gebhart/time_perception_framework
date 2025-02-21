function [est_time, total_num_trials, results_table, exp_condition_list, train_condition_list, break_times] = setup_task(comp_durations, num_comp_trials, num_training_trials, num_breaks)
    % Total number of trials and conditions in the experiment
    total_num_conditions = length(comp_durations);
    total_num_trials = total_num_conditions * num_comp_trials;

    % Creating the randomized experiment and training condition numbers
    exp_condition_list = repmat(1:total_num_conditions, 1, total_num_trials);
    exp_condition_list = exp_condition_list(randperm(length(exp_condition_list)));
    train_condition_list = randi(total_num_conditions, 1, num_training_trials);
    
    % Determining break times based on the specified number of breaks.
    break_times = round(linspace(1, total_num_trials, num_breaks+2)); 
    break_times = break_times(:, 2:num_breaks+1) - 1;
    
    % Creating the results table. 
    table_var_types = ["string", "double", "string"];
    table_var_names =  ["Image", "Time_Condition", "Response"];
    results_table = table('Size', [total_num_trials 3], 'VariableTypes', table_var_types, 'VariableNames', table_var_names);
    
    % Determining estimated experiment time. Includes training and
    % experimental durations, response time, segway time of 1 second per
    % experiment, and 300 seconds of introduction and break time.
    est_time = (mean(comp_durations) + 0.5)*num_training_trials + sum(total_num_trials * (comp_durations + 0.5)) + 300 + (total_num_trials + num_training_trials);
    % Converting to minutes
    est_time = est_time / 60;
end