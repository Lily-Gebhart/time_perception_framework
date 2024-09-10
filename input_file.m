%DON'T CHANGE THIS: Screen Set Up for Running Psychtoolbox
 KbName('UnifyKeyNames');
 Screen('Preference', 'SkipSyncTests', 1);
 sca; 
 close all;                       
 clear;
 

% General Parameters - to be changed for each operating system and experiment.
directory_link = "Change me!";      % directory for experiment folders
save_after = 0;                     % Save data after __ trials.
participant_number = 0;             % participant number
background_color = "Change me!";    % Choices: "white", "gray"
num_breaks = 0;                     % Number of breaks participants will have throughout the experiment.
num_training_trials = 0;            % Number of training trials to include before data collection. 
experiment_type = "Change me!";     % Choices: "reproduction", "comparison"



% Parameters Specific to the Time Reproduction Task
replication_type = "Change me!";    % Choices: "start_stop", "hold", "stop"
stimulus_type = ["Change me!"];     % Choices: "default", ["image path #1", "image path #2, ...].
durations = [];                     % Durations to test per stimulus. Assumes same  durations for each stimulus.
num_trials = 0;                     % How many trials per duration-stimulus combination.



% Parameters Specific to the Time Comparison Task
single_image = true;                % Is a single image presented on each trial and compared to a standard (true)? Otherwise, two images will be directly compared on each trial. 
comp_type = [];                     % How should images be compared? 
                                        % Choices: "shorter/longer", "equal/not equal", "shorter/equal/longer". 

% If one image is compared on each trial:
stimulus = "Change me!";           % Choices: "default", "standard image link"
standard_duration = 0;             % Duration of standard image.  
comp_durations = [];               % Durations for comparison images. 
num_comp_trials = 0;               % How many trials per duration being compared. 

% If two images are compared on each trial:
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
