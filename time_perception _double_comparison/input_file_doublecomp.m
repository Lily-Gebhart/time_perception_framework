%DON'T CHANGE THIS: Screen Set Up for Running Psychtoolbox
 KbName('UnifyKeyNames');
 Screen('Preference', 'SkipSyncTests', 1);
 sca; 
 close all;                       
 clear;
 

% General Parameters - to be changed for each operating system and experiment.
directory_link = "/Users/lilygebhart/Downloads/time_perception/time_perception _double_comparison/";      % directory for experiment folders
save_after = 5;                     % Save data after __ trials.
participant_number = 3;             % participant number
background_color = "white";         % Choices: "white", "grey"
num_breaks = 1;                     % Number of breaks participants will have throughout the experiment.
num_training_trials = 5;            % Number of training trials to include before data collection. 

% Parameters Specific to the Time Comparison Task
comp_type = "shorter/longer";                     % How should images be compared? 
                                        % Choices: "shorter/longer", "equal/not equal", "shorter/equal/longer". 
comp_order = "random";          % Choices: "fixed", "random"
stimulus = "default";              % Preferred stimulus jpg file name or "default". The image to be used to represent standard and comparison durations. 
twoimage_standard_durations = [1, 2];   % Durations for standard images. Each duration will be used for each standard image.
twoimage_comp_durations = [0.5, 1, 1.5; 1.5, 2, 2.5];     % What comparison durations should be used relative to each standard duration? List in order of standard durations indicated above.
num_comp_trials = 10;            % How many trials to run for each standard/comparison duration


% Experiment Setup - do not change
PsychDefaultSetup(2);
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
grey = white / 1.5;
black = BlackIndex(screenNumber);
[window, ~] = PsychImaging('OpenWindow', screenNumber, grey);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
 
% Running experiment
data_table = run_doublecomp_experiment(directory_link, save_after, participant_number, ...
    background_color, num_breaks, num_training_trials, stimulus, twoimage_standard_durations, ...
    twoimage_comp_durations, num_comp_trials, comp_type, comp_order, ...
    white, grey, black, window, screenXpixels, screenYpixels); 

Screen('Close', window); % Closing screen
