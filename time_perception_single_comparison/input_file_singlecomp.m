%DON'T CHANGE THIS: Screen Set Up for Running Psychtoolbox
 KbName('UnifyKeyNames');
 Screen('Preference', 'SkipSyncTests', 1);
 sca; 
 close all;                       
 clear;
 
% General Parameters - to be changed for each operating system and experiment.
directory_link = "/Users/lilygebhart/Downloads/time_perception/time_perception_single_comparison/";      % directory for experiment folders
save_after = 5;                     % Save data after __ trials.
participant_number = 4;             % participant number
background_color = "white";         % Choices: "white", "grey"
num_breaks = 1;                     % Number of breaks participants will have throughout the experiment.
num_training_trials = 5;            % Number of training trials to include before data collection. 

% Parameters Specific to the Time Comparison Task
comp_type = "shorter/longer";       % How should images be compared? 
                                        % Choices: "shorter/longer", "equal/not equal", "shorter/equal/longer". 
stimulus = "default.jpg";               % Choices: "default", or insert your own jpg image.
standard_duration = 1;             % Duration of standard image.  
comp_durations = [0.5, 1, 1.5];               % Durations for comparison images. 
num_comp_trials = 10;               % How many trials per duration being compared. 


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
    
% Run experiment
data_table = run_singlecomp_experiment(directory_link, save_after, participant_number, ...
    background_color, num_breaks, num_training_trials, stimulus, standard_duration, ...
    comp_durations, num_comp_trials, comp_type, ...
    white, grey, black, window, screenXpixels, screenYpixels); 

Screen('Close', window); % Closing screen
