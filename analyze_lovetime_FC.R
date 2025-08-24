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
results_dir = "/Users/lilygebhart/Downloads/Research_Files/Levitan_Research/Love_Time_Perception_Experiment/FC/Forced_Choice_Data_Files/" # Replication results directory name
time_conditions = c(0.75, 1.2) # Edit Me!
comp_multiples = c(-3, -2, -1, 0, 2, 4, 6)
comp_times_075 = c(0.075, 0.3, 0.525, 0.75, 1.2, 1.65, 2.1)
comp_times_120 = c(0.12, 0.48, 0.84, 1.2, 1.92, 2.64, 3.36)
images = c("exp_image", "control_person_image", "control_object_image")

# Construct data frame.
avg_data = data.frame(participant_num=numeric(), image_pairs=numeric(), std_time=numeric(), compar_times=numeric(), avg_longer=numeric(), longer=numeric(), shorter=numeric(), num_trials=numeric())

# First unpack and average results files for each participant
files = list.files(results_dir)
print(files)
file = files[5]
data = read.csv(file=paste(results_dir, "/", file, sep=''), sep=',', header=T)
print(data)
# Now extract data from each time condition
time_counts = c()
for (std_time in time_conditions){
  print("std")
  print(std_time)
for (index in seq(1:3)){
  print("index")
  print(index)
  if (index == 1){
    image1 = "exp_image"
    image2 = "control_person_image"
    image_pair = expression("E x C"[F])
    if (std_time == 0.75){
      lab = "0.75s, E x CF"
    }
    else {
      lab = "1.20s, E x CF"
    }
  }
  else if (index == 2){
    image1 = "exp_image"
    image2 = "control_object_image"
    image_pair = expression("E x C"[O])
    if (std_time == 0.75){
      lab = "0.75s, E x CO"
    }
    else {
      lab = "1.20s, E x CO"
    }
  }
  else {
    image1 = "control_person_image"
    image2 = "control_object_image"
    image_pair = expression("C"[F]*" x C"[O])
    if (std_time == 0.75){
      lab = "0.75, CF x CO"
    }
    else {
      lab = "1.20, CF x CO"
    }
  }
  for (time in comp_multiples){
    print("comp time")
      print(time)
      longer_response = sum(data$Longer_Response[data$Image_1 == image1 & data$Image_2 == image2 & data$Image_2_Multiples == time & data$Time_Condition == std_time] == 2)
      n = length(data$Longer_Response[data$Image_1 == image1 & data$Image_2 == image2 & data$Image_2_Multiples == time & data$Time_Condition == std_time])
      avg = longer_response / n
      if (std_time == 0.75){
        comp_time = comp_times_075[which(comp_multiples == time)]
      }
      else {
        comp_time = comp_times_120[which(comp_multiples == time)]
      }
      avg_data[nrow(avg_data) + 1,] = c(parse_number(file), image_pair, std_time, comp_time, avg, longer_response, n - longer_response, n)
    }
  }
}
# Printing to make sure things look right
avg_data$participant_num <- as.numeric(avg_data$participant_num)
avg_data$std_time <- as.numeric(avg_data$std_time)
avg_data$compar_times <- as.numeric(avg_data$compar_times)
avg_data$avg_longer <- as.numeric(avg_data$avg_longer)
avg_data$longer <- as.numeric(avg_data$longer)
avg_data$shorter <- as.numeric(avg_data$shorter)
avg_data$num_trials <- as.numeric(avg_data$num_trials)
print(str(avg_data))


# Visualize Psychometric curves
avg_data %>% ggplot( aes(x=compar_times, y=avg_longer)) +  
  geom_point(size=3) + 
  geom_smooth(method=glm, method.args= list(family = binomial(logit)), 
              se = FALSE) +
  xlab('Durations (sec)') + ylab('Proportion of Longer Response') +
  facet_grid(image_pairs ~ std_time)

print(avg_data)

# Estimate Psychometric Functions using a GLM approach
print(str(avg_data))
glm_result <- avg_data %>% 
  group_by(image_pairs, std_time) %>%
  do(tidy(glm(cbind(longer, shorter) ~ compar_times, family=binomial(logit), data=.)))


# Calculate PSEs and JNDs
psy_results = glm_results %>%
  select(., one_of(c('label', 'term','estimate'))) %>%
  spread(.,term, estimate) %>% rename(., b=comp_time, a = `(Intercept)`) %>%
  mutate(., pse = -a/b, jnd = log(3)/b)
psy_results