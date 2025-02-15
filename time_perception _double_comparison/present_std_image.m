function present_std_image()
% For the comparison_single experiment type
    run_textblock('Press the spacebar for the standard image duration.');
    WaitSecs(0.5);
    Screen('DrawTexture', window, stimulus, [], [], 0);
    Screen('Flip', window);
    WaitSecs(standard_duration);
    Screen('FillRect', window, background_color);
    Screen('Flip', window);
    WaitSecs(0.5);
    run_textblock('Compare the durations of images in each trial with this standard image. \n \n Press the spacebar to begin the trials.')
end