function results = run_new_experiment()
    % FIXME: If failed at any time, do the exit sequence
    
    if experiment_type == "reproduction"
        exp_type = "reproduction";
    elseif experiment_type == "comparison" && single_image == true
        exp_type = "comparison_single";
    elseif experiment_type == "comparison" && single_image == false
        exp_type = "comparison_double";
    else
        % Error sequence
        run_textblock("Error in experiment_type or single_image. \n \n Press the spacebar to continue.")
        Screen('Close', window); 
    end 

    [est_time, num_trials, results, exp_condition_list, train_condition_list, break_times] = setup_task();

    % Experiment Intro 
    intro_statements = [strcat('Thank you for your interest in participating in this experiment. The experiment is expected to last ', round(est_time), ' minutes. \n \n Press the spacebar to continue.'), ...
                        'You will begin with several practice trials to get used to the task. You can press the escape key at any time to exit the experiment. \n \n Press the spacebar to continue.'];
    run_textblock(intro_statements) 

    % Task specific instructions 
    run_experiment_intro();

    % Presenting standard image for single image comparison experiment. 
    if exp_type == "comparison_single"
        present_std_image();
    end

    % Run training trials
    for trial_counter=1:length(train_condition_list)
        condition_num = train_condition_list(trial_counter);
        [stimulus, duration] = find_condition(condition_num, exp_type);
        run_trial(stimulus, duration, exp_type);
    end

    % Presenting standard image for single image comparison experiment. 
    if exp_type == "comparison_single"
        present_std_image();
    end

    % Segway into the experiment.
    end_training_statements = ['You have completed the training segment. \n \n Press the spacebar to continue.',
                                'There will be several breaks built into the experiment session. If you have any questions, please call the proctor into the room.   \n \n Press the spacebar to continue. ', 
                                'Press the spacebar to begin.'];
    run_textblock(end_training_statements)

    % FIXME add something to present the standard image before experimental
    % trials start

    % Run experiment. Breaks Included When Necessary
    break_statement = 'You may now take a break. \n \n Press the spacebar to continue the session.';
    for trial_counter=1:num_trials
        % FIXME temporarily save the data table
        condition_num = exp_condition_list(trial_counter);
        [stimulus, duration] = find_condition(condition_num, exp_type);
        result = run_trial(stimulus, duration, replication_type);
        results(trial_counter,:) = result;
        if any(break_times == trial_counter)
            run_textblock(break_statement);
        end
    end
    

    % Experiment Outro
    end_statement = 'You have completed the experiment! \n \n Call the proctor into the room.';
    run_textblock(end_statement);

    % Press the spacebar to continue and exit the experiment screen. 
    % End experiment. Exit screen.
    Screen('Close', window);
end