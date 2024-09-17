# A User Friendly Approach to Short Duration Time Perception
Included is a body of MATLAB code designed for running time perception experiments using [Psychtoolbox 3.0.19](http://psychtoolbox.org/download) on [MATLAB 2024B](https://www.mathworks.com/products/new_products/latest_features.html). Psychtoolbox is open access and free to use, while MATLAB can be accessed via a subscription by most universities and organizations. No packages or other dependencies are required except for those included here.

# What kinds of experiments can I run using this code?
This code only supports visual prospective time replication and comparison experiments. The following structure is used for all experiments: Insert diagram. 

- Introduction
- Task explanations and introductions
- Training Trials
- Experimental Trials
- Conclusion 

General customizations that can be made to the experiment structure include:
- **Data saving frequency**
- **Background color**: The default options are white or gray.
- **Breaks**: Time perception experiments can be quite long. The number of breaks in the experimental trials segment can be specified. No breaks are integrated into the training segment.
- **Training Trials**: The number of training trials can be specified. These trials randomize stimuli and durations from the list from the options specified.

The following features are integrated in all experiments designed with this framework: 
- Users can press the "ESCAPE" key to exit the experiment at any time.
- Experimental trial data is saved to a datatable specific to each experiment type. Sample analysis scripts are provided.

## Replication Experiments
Time replication experiments assess how well a user can replicate a given time interval, inidirectly assessing patients' working memory capacity as they temporarily store the interval duration before replicating it. The presented time intervals can be auditory or visual. Only visual intervals are supported here. 

The following customizations can be made to the base experiment:
- **Replication Type**: There are several common ways for a participant to replicate the subjective duration of a visual stimulus. They include pressing a key to start and pressing a key to end the replicated interval, holding on a key for the subjective duration of the interval, and receiving a signal that the replicated interval has begun and pressing a key to stop the interval.
- **Durations**: The number and length of intervals 
- **Stimuli**: The default stimulus is a large circle. Any number of user defined images can be used as alternatives to the default stimulus.
- **Number of Trials**: The number of trials for each duration/stimulus combination can also be changed. Note that every duration specified will be matched with every stimulus specified, and the same number of trials will be applied to each duration/stimulus combination. 

## Comparison Experiments 
Time comparison experiments assesses how well a participant can determine the temporal relationship between two presented images. There are two main types of comparison experiments: single and double comparison experiments. 

### Single Comparison Experiments
In single image experiments, participants are presented with one or more "standard" durations that they will make comparisons with throughout the rest of the experiment. In each trial, only a single image is presented and participants are asked to indicate how the duration of the presented stimulus relates to the standard duration(s). For example, when presented with a stimulus on a given trial, participants may be asked to press the "1" key if the stimulus duration felt longer than the standard duration and "2" if the stimulus duration felt shorter than the standard duration. 

Single comparison experiments can be customized in the following ways under this framework:
- **Comparison Type:** The nature of the comparison between trial durations and the standard duration can be customized by specifying whether the trial duration is _shorter or longer_ than the standard duration, _equal or unequal_ to the standard duration, or _shorter, equal, or longer_ than the standard duration. 
- **Stimulus:** The default stimulus is a large black circle. A user specified image may also be used. This version of the experiment is only designed for a single stimulus.
- **Standard Duration:** The duration of the standard image can be specified. Only one standard duration is supported under this version of the framework.
- **Comparison Durations:** Any number and length of stimulus durations to be compared with the standard duration can be specified.
- **Number of Trials:** The number of trials for each duration can also be changed. The same number of trials will be run for each duration. 

### Double Comparison Experiments
Double comparison experiments operate on the same principles as the single comparison experiments, except the standard duration is presented with the comparison duration on each trial. As a result, double comparison experiments enable a more direct measurement of time perception, and are less reliant on memory of the standard duration as opposed to single comparison experiments. Double comparison experiments have the additional advantage of randomizing the order of presentation of standard and comparison durations on each trial - making it easier to incorporate more stimuli without the awareness of the participant. 

Double comparison experiments can be customized in the following ways under this framework:
- **Comparison Type:** The nature of the comparison between trial durations and the standard duration can be customized by specifying whether the trial duration is _shorter or longer_ than the standard duration, _equal or unequal_ to the standard duration, or _shorter, equal, or longer_ than the standard duration.
- **Trial Order:** The order of the standard and comparison durations on each trial can be kept fixed or randomized.
- **Standard Durations:**


# How to customize experiments 
All experiments are customized using the parameters in the input_file.m file. Descriptions of each parameter are included in the input file, and are explained in the tutorials for each experiment type here. 

```
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

```

## Replication Experiment Example

## Single Image Comparison Experiment Example

## Double Image Comparison Experiment Example


# How to run experiments 

## File framework 

## Saving Participant Data

# Sample Experiment Based on this Framework: Love & Time Perception

# Questions? 
If you have questions, comments, or concerns, contact ...
