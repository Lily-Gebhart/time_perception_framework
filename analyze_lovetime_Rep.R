# Code to analyze a time replication experiment

# Import packages
install.packages("readr")
install.packages("dplyr")
install.packages("ggpubr")
library(readr)
library(dplyr)
library(ggpubr)

results_dir = "/Users/lilygebhart/Downloads/Research_Files/Levitan_Research/Love_Time_Perception_Experiment/IR/Data_Files/" # Replication results directory name
time_conditions = c(0.5, 0.75, 1.2)
avg_data = data.frame(participant_num=numeric(), Time_050_E=numeric(), Time_0750_E=numeric(), Time_120_E=numeric(), Time_050_Cp=numeric(), Time_0750_Cp=numeric(), Time_120_Cp=numeric(), Time_050_Co=numeric(), Time_0750_Co=numeric(), Time_120_Co=numeric())
stimuli = c('exp_image', 'control_person_image',  'control_object_image')
# First unpack and average results files for each participant
files = list.files(results_dir)
print(files)
for (file in files){
  data = read.csv(file=paste(results_dir, "/", file, sep=''), sep=',', header=T)
  # now extract data from each time condition
  avg_times = c()
  for (stimulus in stimuli){
  for (time in time_conditions){
    time_data = data$Participant.Response.Time[data$Intended.Presentation.Time == time & data$Stimulus.Type == stimulus] 
    cat(file, " ", stimulus, ' ', time)
    print(mean(time_data))
    avg_times = c(avg_times, mean(time_data))
  }
  }
  avg_data[nrow(avg_data) + 1,] = c(parse_number(file), avg_times)
}

# Printing Our Data Frame
print(avg_data)

# Plot the data...
plot_075_12_E <- ggpaired(avg_data, 
         cond1      = "Time_0750_E", 
         cond2      = "Time_120_E",
         color      = "condition",
         line.color = "gray", 
         line.size  = 0.4,
         palette    = "jco") + ylim(0, 2)

plot_075_12_Cp <- ggpaired(avg_data, 
                          cond1      = "Time_0750_Cp", 
                          cond2      = "Time_120_Cp",
                          color      = "condition",
                          line.color = "gray", 
                          line.size  = 0.4,
                          palette    = "jco") + ylim(0, 2)

plot_075_12_Co <- ggpaired(avg_data, 
                          cond1      = "Time_0750_Co", 
                          cond2      = "Time_120_Co",
                          color      = "condition",
                          line.color = "gray", 
                          line.size  = 0.4,
                          palette    = "jco") + ylim(0, 2)

plot_05_12_E <- ggpaired(avg_data, 
                          cond1      = "Time_050_E", 
                          cond2      = "Time_120_E",
                          color      = "condition",
                          line.color = "gray", 
                          line.size  = 0.4,
                          palette    = "jco") + ylim(0, 2)

plot_05_12_Cp <- ggpaired(avg_data, 
                          cond1      = "Time_050_Cp", 
                          cond2      = "Time_120_Cp",
                          color      = "condition",
                          line.color = "gray", 
                          line.size  = 0.4,
                          palette    = "jco") + ylim(0, 2)

plot_05_12_Co <- ggpaired(avg_data, 
                          cond1      = "Time_050_Co", 
                          cond2      = "Time_120_Co",
                          color      = "condition",
                          line.color = "gray", 
                          line.size  = 0.4,
                          palette    = "jco") + ylim(0, 2)

plot_05_075_E <- ggpaired(avg_data, 
                          cond1      = "Time_050_E", 
                          cond2      = "Time_0750_E",
                          color      = "condition",
                          line.color = "gray", 
                          line.size  = 0.4,
                          palette    = "jco") + ylim(0, 2)

plot_05_075_Cp <- ggpaired(avg_data, 
                          cond1      = "Time_050_Cp", 
                          cond2      = "Time_0750_Cp",
                          color      = "condition",
                          line.color = "gray", 
                          line.size  = 0.4,
                          palette    = "jco") + ylim(0, 2)

plot_05_075_Co <- ggpaired(avg_data, 
                          cond1      = "Time_050_Co", 
                          cond2      = "Time_0750_Co",
                          color      = "condition",
                          line.color = "gray", 
                          line.size  = 0.4,
                          palette    = "jco") + ylim(0, 2)

ggarrange(plot_05_075_E, plot_05_075_Cp, plot_05_075_Co,
         plot_05_12_E,plot_05_12_Cp, plot_05_12_Co,
         plot_075_12_E, plot_075_12_Cp, plot_075_12_Co,
         ncol=3, nrow=3)


library(ggplot2)
library(tidyr)
library(dplyr)

plot_three_condition_paired <- function(data, subject_col, condition_cols, title) {
  # Check input
  if (length(condition_cols) != 3) {
    stop("Please provide exactly three condition columns.")
  }
  
  # Convert to long format
  long_data <- data %>%
    select(all_of(c(subject_col, condition_cols))) %>%
    pivot_longer(
      cols = all_of(condition_cols),
      names_to = "condition",
      values_to = "value"
    ) %>%
    mutate(
      condition = factor(condition, levels = condition_cols),  # preserve original order
      subject = factor(!!sym(subject_col))
    )
  
  # Plot
  ggplot(long_data, aes(x = condition, y = value, group = subject)) +
    geom_line(color = "grey80", size = 0.8, alpha = 0.8) +
    geom_point(size = 2, alpha = 0.8) +
    geom_boxplot(aes(group = condition), width = 0.4, alpha = 0.5, outlier.shape = NA) +
    theme_minimal(base_size = 14) +
    ylim(0, 2) +
    labs(title = title,
         x = "Stimulus",
         y = "Reproduction Time Estimate (s)")
}

condition05 <- plot_three_condition_paired(avg_data, "participant_num", c("Time_050_E", "Time_050_Cp", "Time_050_Co"), "0.5 Second Duration")
condition075 <-  plot_three_condition_paired(avg_data, "participant_num", c("Time_0750_E", "Time_0750_Cp", "Time_0750_Co"), "0.75 Second Duration")
condition120 <-  plot_three_condition_paired(avg_data, "participant_num", c("Time_120_E", "Time_120_Cp", "Time_120_Co"), "1.2 Second Duration")
ggarrange(condition05, condition075, condition120,
          ncol=3)