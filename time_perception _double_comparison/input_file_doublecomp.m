%DON'T CHANGE THIS: Screen Set Up for Running Psychtoolbox
 KbName('UnifyKeyNames');
 Screen('Preference', 'SkipSyncTests', 1);
 sca; 
 close all;                       
 clear;
 

% General Parameters - to be changed for each operating system and experiment.
directory_link = "/Users/lilygebhart/Downloads/time_perception-main/time_perception_double_comparison/";      % directory for experiment folders
save_after = 0;                     % Save data after __ trials.
participant_number = 0;             % participant number
background_color = "white";         % Choices: "white", "grey"
num_breaks = 1;                     % Number of breaks participants will have throughout the experiment.
num_training_trials = 1;            % Number of training trials to include before data collection. 

% Parameters Specific to the Time Comparison Task
comp_type = [];                     % How should images be compared? 
                                        % Choices: "shorter/longer", "equal/not equal", "shorter/equal/longer". 
comp_order = "Change me!";          % Choices: "fixed", "random"
comp_stimuli = [];                  % Paired list of stimulus links, indicating which stimuli should be compared. The first image in each pair will be the "standard"
twoimage_standard_durations = [];   % Durations for standard images. Each duration will be used for each standard image.
twoimage_comp_durations = [[]];     % What comparison images should be used relative to each standard duration? List in order of standard durations indicated above.



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
    
data_table = run_experiment(); % Running experiment

Screen('Close', window); % Closing screen
