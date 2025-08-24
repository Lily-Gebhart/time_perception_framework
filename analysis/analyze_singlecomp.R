# Code to analyze a single comparison time perception experiment.
# Sources:(1) https://www.rpubs.com/Strongway/psy_fun 


# Install packages (if not already downloaded).
#install.packages("readr")
#install.packages("quickpsy")
#install.packages("tidyverse")
#install.packages("broom")
#install.packages("patchwork")

# Import packages
library(readr)
library(quickpsy)
library(tidyverse)
library(broom)
library(patchwork)

# Change results directory and time conditions 
results_dir = "" # Edit Me! Add the single comp results directory name here!
time_conditions = c() # Edit Me! Add a vector of time conditions here!

# Construct data frame.
avg_data = data.frame(participant_num=numeric(), time_condition=numeric(), avg_longer=numeric(), longer=numeric(), shorter=numeric(), num_trials=numeric())

# First unpack and average results files for each participant
files = list.files(results_dir)
for (file in files){
  data = read.csv(file=paste(results_dir, "/", file, sep=''), sep=',', header=T)
  # Now extract data from each time condition
  time_counts = c()
  for (time in time_conditions){
    longer_response = sum(data$Response[data$Time_Condition == time] == "longer")
    avg = longer_response / sum(data$Time_Condition == time)
    avg_data[nrow(avg_data) + 1,] = c(parse_number(file), time, avg, longer_response, sum(data$Time_Condition == time) - longer_response, sum(data$Time_Condition == time))
    }
}

# Printing to make sure things look right
print(avg_data)

# Visualize Psychometric curves
avg_data %>% ggplot( aes(x=time_condition, y=avg_longer)) +  
  geom_point(size=3) + 
  geom_smooth(method=glm, method.args= list(family = binomial(logit)), 
              se = FALSE) +
  xlab('Durations (sec)') + ylab('Proportion of Longer Response') +
  facet_grid(.~participant_num)

# Estimate Psychometric Functions using a GLM approach
glm_results = avg_data %>% 
  group_by(participant_num) %>%
  do(tidy (glm(cbind(longer,shorter) ~ time_condition, 
               family = binomial(logit), data=.)))
glm_results

# Calculate PSEs and JNDs
psy_results = glm_results %>%
  select(., one_of(c('participant_num', 'term','estimate'))) %>%
  spread(.,term, estimate) %>% rename(., b=time_condition, a = `(Intercept)`) %>%
  mutate(., pse = -a/b, jnd = log(3)/b)
head(psy_results)
