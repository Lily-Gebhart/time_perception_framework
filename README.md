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
- **Standard Stimuli:** The stimuli that will always be presented with the standard duration.
- **Comparison Stimuli:** The stimuli that will be compared with each standard stimulus. Different comparison stimuli may be directly compared with each standard stimulus. 
- **Standard Durations:** The duration of each standard image, user provided or otherwise.
- **Comparison Durations:** Any number and length of stimulus durations to be compared with the standard durations can be specified.
- **Number of Trials:** The number of trials for each duration can also be changed. The same number of trials will be run for each duration. 


# How to customize experiments 
All experiments are customized using the parameters in the input_file.m file. Descriptions of each parameter are included in the input file. The parameters that can be changed are structured roughly as they are outlined above.  Examples of how to change the parameters to run each task follow in the "Example" sections. Only parameters relevant to the experiment at hand need to be changed and will be displayed in each example.  

Suppose for all experiments that we've downloaded the experiment code folder to the directory: "downloads/time_perception_code". We want to save our data after every five trials, the background to be white, and three breaks to be in our experiment. We want to run 10 training trials before our experiment begins and 10 trials for each duration (and stimulus, depending on the experiment) combination. 

Let's assume for now that we're running participant 1 on the experiment. Below is the code as it appears in the input_file.m file for reference. 

```
% General Parameters - to be changed for each operating system and experiment.
directory_link = "Change me!";      % directory for experiment folders
save_after = 0;                     % Save data after __ trials.
participant_number = 0;             % participant number
background_color = "Change me!";    % Choices: "white", "gray"
num_breaks = 0;                     % Number of breaks participants will have throughout the experiment.
num_training_trials = 0;            % Number of training trials to include before data collection. 
num_trials = 0;                     % How many trials per duration-stimulus combination.
experiment_type = "Change me!";     % Choices: "reproduction", "comparison"

% Parameters Specific to the Time Reproduction Task
replication_type = "Change me!";    % Choices: "start_stop", "hold", "stop"
stimulus_type = ["Change me!"];     % Choices: "default", ["image path #1", "image path #2, ...].
durations = [];                     % Durations to test per stimulus. Assumes same  durations for each stimulus.

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
twoimage_comp_durations = [[]];     % What comparison durations should be used relative to each standard duration? List in order of standard durations indicated above.
```


## Replication Experiment Example
Suppose we want to run a replication experiment with the default stimulus to assess how well participants can remember and distinguish between close together time intervals.  First we'll set the experiment type to replication under the General Parameters section. 

```
% General Parameters - to be changed for each operating system and experiment.
directory_link = "downloads/time_perception_code";      % directory for experiment folders
save_after = 5;                                         % Save data after __ trials.
participant_number = 1;                                 % participant number
background_color = "white";                             % Choices: "white", "gray"
num_breaks = 3;                                         % Number of breaks participants will have throughout the experiment.
num_training_trials = 10;                               % Number of training trials to include before data collection. 
num_trials = 10;                                        % How many trials per duration-stimulus combination.
experiment_type = "replication";                        % Choices: "reproduction", "comparison"
```

For this version of the experiment, we want participants to hold down on the space bar when they replicate intervals to respond. Since we want to use the default stimulus, we'll set the stimulus type accordingly. We will test the default stimulus on five durations - 0.4s, 0.45s, 0.5s, 0.55s, 0.6s - with ten trials for each duration so we can average them later on. We'll set these parameters in the Time Reproduction Task section. 

```
% Parameters Specific to the Time Reproduction Task
replication_type = "hold";                           % Choices: "start_stop", "hold", "stop"
stimulus_type = ["default"];                         % Choices: "default", ["image path #1", "image path #2, ...].
durations = [0.4s, 0.45s, 0.5s, 0.55s, 0.6s];        % Durations to test per stimulus. Assumes same durations for each stimulus.
```

Suppose that as a follow up experiment, we want to use two non-default stimuli, say two tree images with links "oak_tree.jpg" and "maple_tree.jpg". We can easily make these adjustments in the Time Reproduction task section. 

```
% Parameters Specific to the Time Reproduction Task
replication_type = "hold";                           % Choices: "start_stop", "hold", "stop"
stimulus_type = ["oak_tree.jpg", "maple_tree.jpg"];  % Choices: "default", ["image path #1", "image path #2, ...].
durations = [0.4s, 0.45s, 0.5s, 0.55s, 0.6s];        % Durations to test per stimulus. Assumes same durations for each stimulus.
```

## Single Image Comparison Experiment Example

Suppose for the single image comparison experiment, we want to run a similar experiment - seeing how well participants can differentiate between close together intervals. We'll switch the experiment type parameter to comparison before setting the rest of the parameters. 

```
% General Parameters - to be changed for each operating system and experiment.
directory_link = "downloads/time_perception_code";      % directory for experiment folders
save_after = 5;                                         % Save data after __ trials.
participant_number = 1;                                 % participant number
background_color = "white";                             % Choices: "white", "gray"
num_breaks = 3;                                         % Number of breaks participants will have throughout the experiment.
num_training_trials = 10;                               % Number of training trials to include before data collection. 
num_trials = 10;                                        % How many trials per duration-stimulus combination.
experiment_type = "comparison";                         % Choices: "reproduction", "comparison"
```

Let's say we want to use the default stimulus for now and assess whether participants feel like the comparison durations are shorter, equal or longer than the standard durations. We'll let the standard duration be 0.5 seconds, and compare it to five other intervals: 0.4s, 0.45s, 0.5s, 0.55s, 0.6s. 
Since we're running a single image comparison task, we'll want to make sure to flip the single image parameter to true. 

```
% Parameters Specific to the Time Comparison Task
single_image = true;                    % Is a single image presented on each trial and compared to a standard (true)? Otherwise, two images will be directly compared on each trial. 
comp_type = "shorter/equal/longer";     % How should images be compared? 
                                            % Choices: "shorter/longer", "equal/not equal", "shorter/equal/longer". 

% If one image is compared on each trial:
stimulus = "default";                              % Choices: "default", "standard image link"
standard_duration = 0.5;                           % Duration of standard image.  
comp_durations = [0.4, 0.45, 0.5, 0.55, 0.6];      % Durations for comparison images. 
```

Let's say instead we want participants to just see if the comparison image is equal or unequal in duraiton compared to the standard image, and we want to use the "oak_tree.jpg" image instead of the standard image. We would flip the parameters to something like this:

```
% Parameters Specific to the Time Comparison Task
single_image = true;                    % Is a single image presented on each trial and compared to a standard (true)? Otherwise, two images will be directly compared on each trial. 
comp_type = "equal/not equal";          % How should images be compared? 
                                            % Choices: "shorter/longer", "equal/not equal", "shorter/equal/longer". 

% If one image is compared on each trial:
stimulus = "oak_tree.jpg";                         % Choices: "default", "standard image link"
standard_duration = 0.5;                           % Duration of standard image.  
comp_durations = [0.4, 0.45, 0.5, 0.55, 0.6];      % Durations for comparison images. 
```

## Double Image Comparison Experiment Example
Suppose for the double image comparison experiment, we want to run the first example used for the single image comparison task, keeping the order of the standard and comparison images fixed. We need to flip the single_image parameter to false, with the remainder of the parameters changed as follows. 

```
% If two images are compared on each trial:
comp_order = "fixed";                                       % Choices: "fixed", "random"
comp_stimuli = [];                                          % Paired list of stimulus links, indicating which stimuli should be compared. The first image in each pair will be the "standard". If kept empty, the default images will be used. 
twoimage_standard_durations = [0.5];                        % Durations for standard images. Each duration will be used for each standard image.
twoimage_comp_durations = [[0.4, 0.45, 0.5, 0.55, 0.6]];    % What comparison durations should be used relative to each standard duration? List in order of standard durations indicated above.
```

Now suppose we want to run a more complicated experiment. Let's assume we want to compare how a generic tree image ("generic_tree.jpg") is perceived compared to an oak tree image ("oak_tree.jpg") and a maple tree image ("maple_tree.jpg"). We want to look at two different durations, 0.5 seconds and 1.0 seconds for our standard, generic tree image, and five different durations surrounding each of these intervals 0.4s, 0.45s, 0.5s, 0.55s, 0.6s and 0.9s, 0.95s, 1.0s, 1.05s, 1.1s respectively for our oak tree and maple tree images. Let's say we want to randomize the order of the standard and comparison images as well. These changes would be reflected as follows in the experiment parameters. 

```
% If two images are compared on each trial:
comp_order = "random";                                                                          % Choices: "fixed", "random"
comp_stimuli = [["generic_tree.jpg", "oak_tree.jpg"], ["generic_tree.jpg", "maple_tree.jpg"];   % Paired list of stimulus links, indicating which stimuli should be compared. The first image in each pair will be the "standard". If kept empty, the default images will be used. 
twoimage_standard_durations = [0.5, 1.0];                                                       % Durations for standard images. Each duration will be used for each standard image.
twoimage_comp_durations = [[0.4, 0.45, 0.5, 0.55, 0.6], [0.9, 0.95, 1.0, 1.05, 1.1]];           % What comparison durations should be used relative to each standard duration? List in order of standard durations indicated above.
```

# How to run experiments 

## File framework 

## Saving Participant Data

# Sample Experiment Based on this Framework: Love & Time Perception

# Questions? 
If you have questions, comments, or concerns, contact ...
