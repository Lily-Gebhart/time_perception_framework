# Code to analyze a time replication experiment

# Import packages
install.packages("readr")
install.packages("dplyr")
install.packages("ggpubr")
library(readr)
library(dplyr)
library(ggpubr)

results_dir = "/Users/lilygebhart/Downloads/time_perception/time_perception_replication/results" # Replication results directory name
time_conditions = c(1, 2)
avg_data = data.frame(participant_num=numeric(), Time_1=numeric(), Time_2=numeric())

# First unpack and average results files for each participant
files = list.files(results_dir)
for (file in files){
  data = read.csv(file=paste(results_dir, "/", file, sep=''), sep=',', header=T)
  # now extract data from each time condition
  avg_times = c()
  for (time in time_conditions){
    time_data = data$Response[data$Time_Condition == time]
    avg_times = c(avg_times, mean(time_data))
  }
  avg_data[nrow(avg_data) + 1,] = c(parse_number(file), avg_times)
}

# Printing Our Data Frame
print(avg_data)

# Check for normality using Shapiro Wilk test.
shapiro.test(avg_data$Time_1)
shapiro.test(avg_data$Time_2)
# Our p value > 0.05, so the distributions aren't significantly different from normal. 
# We can proceed with parametric testing... 

# Running a paired t test in R
t.test(avg_data$Time_1, avg_data$Time_2, paired=TRUE, alternative="two.sided")
# We can conclude that there is a significant difference between the one second and two second conditions

# Plot the data...
ggpaired(avg_data, 
         cond1      = "Time_1", 
         cond2      = "Time_2",
         color      = "condition", 
         line.color = "gray", 
         line.size  = 0.4,
         palette    = "jco")

