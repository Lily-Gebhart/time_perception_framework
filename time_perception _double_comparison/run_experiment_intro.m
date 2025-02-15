function run_experiment_intro()
% Runs the experiment intro, identical but customizable for each
% experiment! 

if exp_type == "replication"
    statements = 'In the task, you will be presented with an image for a period of time.  Pay attention to how long the image is presented on the screen. \n \n Press the spacebar to continue';
    statements = append(statements, 'When the image is removed from the screen, you will be replicating how long the image felt like it was on screen. \n \n Press the spacebar to continue');
    if replication_type == "start_stop"
        statements = append(statements, 'Click the spacebar to start the interval, and click the spacebar again to indicate when you think the image was removed from screen. \n \n Press the spacebar to continue.');
    elseif replication_type == "hold"
        statements = append(statements, 'Hold down on the spacebar to indicate how long it felt like the image was onscreen.');
    elseif replication_type == "stop"
        statements = append(statements, 'Soon after the image leaves the screen, a black "plus" will appear on screen.');
        statements = append(statements, 'The appearance of the "plus" indicates the start of the interval. Click the spacebar to indicate when the interval should end.');
    else
        % Error!!
    end
elseif exp_type == "comparison_single"
    statements = 'In the task, you will be asked how the durations of images presented on each trial compare to a standard image. \n \n Press the spacebar to continue.';
    statements = append(statements, 'The duration of the standard image will be presented before the training trials begin, and again before the experimental trials begin. \n \n Press the spacebar to continue.');
    statements = append(statements, 'In each trial, an image will be presented, then a black "plus" will appear on the screen. \n \n Press the spacebar to continue.');
    if comp_type == "shorter/longer"
        statements = append(statements, 'Once the black plus appears, press the 1 key if the image presented felt shorter in duration than the standard image or press the 2 key if the image presented felt longer than the standard image. \n \n Press the spacebar to continue.');
    elseif comp_type == "equal/not equal"
        statements = append(statements, 'Once the black plus appears, press the 1 key if the image presented felt like it was presented for the same duration as the standard image. Press 2 otherwise. \n \n Press the spacebar to continue.');
    else 
        statements = append(statements, 'Once the black plus appears, press the 1 key if the image presented felt shorter in duration than the standard image. \n Press 2 if the image presented feels like it was presented for the same duration as the standard image. Press 3 if the image presented felt longer than the standard image. \n \n Press the spacebar to continue.');
    end 
elseif exp_type == "comparison_double"
    statements = 'In the task, you will be presented with two images, one after the other. \n \n Press the spacebar to continue.';
    statements = append(statements, 'After both images are presented, a black "plus" will appear on the screen. \n \n Press the spacebar to continue');
    statements = append(statements, 'Once the black plus appears, you will make a judgement about how long the second image was on screen relative to the first image. \n \n Press the spacebar to continue.');
    if comp_type == "shorter/longer"
        statements = append(statements, 'Press the 1 key if the second image presented felt shorter in duration than the first image. \n Press the 2 key if the second image presented felt longer than the first image. \n \n Press the spacebar to continue.');
    elseif comp_type == "equal/not equal"
        statements = append(statements, 'Press the 1 key if the second image presented felt like it was presented for the same duration as the first image. \n Press 2 otherwise. \n \n Press the spacebar to continue.');
    else 
        statements = append(statements, 'Press the 1 key if the second image presented felt shorter in duration than the first image. \n Press 2 if the second image presented feels like it was presented for the same duration as the first image. \n Press 3 if the second image presented felt longer than the first image. \n \n Press the spacebar to continue.');
    end
end  
    statements = append(statements, 'Please do not count the durations of the images to compare them. You can press the "escape" button at any time to end the experiment. \n \n Press the spacebar to continue');
    statements = append(statements, 'Please ask the proctor if you have any questions. \n \n Press the spacebar to continue.');
    statements = append(statements, 'The training segment will begin when you press the spacebar. \n \n Press the spacebar to begin.');
    run_textblock(statements);
end 