%DON'T CHANGE THIS: Screen Set Up for Running Psychtoolbox
 KbName('UnifyKeyNames');
 Screen('Preference', 'SkipSyncTests', 1);
 sca; 
 close all;                       
 clear; 
 

% General Parameters - to be changed for each operating system and experiment.
directory_link = "/Users/lilygebhart/Downloads/time_perception/time_perception_replication/";      % directory for experiment folders
save_after = 5;                     % Save data after __ trials.
participant_number = 3;             % participant number
background_color = "white";         % Choices: "white", "grey"
num_breaks = 1;                     % Number of breaks participants will have throughout the experiment.
num_training_trials = 5;            % Number of training trials to include before data collection. 


% Parameters Specific to the Time Reproduction Task
replication_type = "hold";    % Choices: "start_stop", "hold", "stop"
stimulus_type = "default";     % Choices: "default", ["image path #1", "image path #2, ...].
durations = [1,2];                     % Durations to test per stimulus. Assumes same  durations for each stimulus.
num_trials = 10;                     % How many trials per duration-stimulus combination.


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
data_table = run_experiment(directory_link, save_after, participant_number, ...
    background_color, num_breaks, num_training_trials, replication_type, stimulus_type, durations, ...
    num_trials, white, grey, black, window, screenXpixels, screenYpixels); 

Screen('Close', window); % Closing screen
