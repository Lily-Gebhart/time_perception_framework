% FUNCTION: function to present the standard image before experimental and
% training trials. 
function present_std_image(directory_link, stimulus, standard_duration, window, background_color, black, screenXpixels, screenYpixels)
    display_screen_text('The standard image duration will now be presented. \n The image durations in the next few trials should be compared to this standard. \n Press the spacebar to continue.', ...
            window, ...
            background_color, ... 
            black, ...
            screenXpixels);
    WaitSecs(0.5);

    if stimulus == "default"
        stimulus_link = directory_link + stimulus + ".jpg";
    else
        stimulus_link = directory_link + stimulus;
    end
    texture = Screen('MakeTexture', window, resize_image(imread(stimulus_link), screenYpixels));
    Screen('DrawTexture', window, texture, [], [], 0);
    Screen('Flip', window);
    WaitSecs(standard_duration);
    Screen('FillRect', window, background_color);
    Screen('Flip', window);
    WaitSecs(0.5);

    display_screen_text('In the trials to follow, please compare the durations of images in each trial with the length of time the standard image was presented. \n \n Press the spacebar to begin the trials.', ...
            window, ...
            background_color, ... 
            black, ...
            screenXpixels);
end