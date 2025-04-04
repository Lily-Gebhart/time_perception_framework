# Code to analyze a double comparison time perception experiment
# Sources:(1) https://www.rpubs.com/Strongway/psy_fun 


# Install packages (if not already downloaded)
#install.packages("readr")
#install.packages("quickpsy")
#install.packages("tidyverse")
#install.packages("broom")

# Import packages
library(readr)
library(quickpsy)
library(tidyverse)
library(broom)

# Change results directory and time conditions. 
results_dir = "/Users/lilygebhart/Downloads/time_perception/time_perception_double_comparison/results" # Replication results directory name
std_time = 1
comp_times = c(0.5, 1, 1.5)

# Construct data frame.
avg_data = data.frame(participant_num=numeric(), std_time=numeric(), comp_time=numeric(), avg_longer=numeric(), longer=numeric(), shorter=numeric(), num_trials=numeric())

# First unpack and average results files for each participant
files = list.files(results_dir)
for (file in files){
  data = read.csv(file=paste(results_dir, "/", file, sep=''), sep=',', header=T)
  print(data)
  # Now extract data from each time condition
  time_counts = c()
  for (time in comp_times){
    longer_response = sum(data$Response[data$Comp_Time_Condition == time & data$Standard_Time_Condition == std_time] == "longer")
    n = sum(data$Comp_Time_Condition == time & data$Standard_Time_Condition == std_time)
    avg = longer_response / n
    avg_data[nrow(avg_data) + 1,] = c(parse_number(file), std_time, time, avg, longer_response, n - longer_response, n)
  }
}

# Printing to make sure things look right
print(avg_data)

# Visualize Psychometric curves
avg_data %>%ggplot( aes(x=comp_time, y=avg_longer)) +  
  geom_point(size=3) + 
  geom_smooth(method=glm, method.args= list(family = binomial(logit)), 
              se = FALSE) +
  xlab('Durations (sec)') + ylab('Proportion of Longer Response') +
  facet_wrap(~participant_num)

# Estimate Psychometric Functions using a GLM approach
glm_results = avg_data %>% 
  group_by(participant_num) %>%
  do(tidy (glm(cbind(longer,shorter) ~ comp_time, 
               family = binomial(logit), data=.)))
glm_results

# Calculate PSEs and JNDs
psy_results = glm_results %>%
  select(., one_of(c('participant_num', 'term','estimate'))) %>%
  spread(.,term, estimate) %>% rename(., b=comp_time, a = `(Intercept)`) %>%
  mutate(., pse = -a/b, jnd = log(3)/b)
psy_results