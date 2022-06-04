# Descriptive Figure

#### ------- Libraries ------- ####
library(dplyr)
library(tidyverse)
library(readr)

#### ------- Combining MOvie data ------- ####

#### ------- Load Data ------- ####

files <- list.files("Movie_data_descriptive", full.names = TRUE)
files
# get files
Merged_data_movies <-
  do.call(bind_rows,
          lapply(files, read_csv))  

#### ------- drop shitty column  ------- ####
col_to_drop = c('...2')

Merged_data_movies <- Merged_data_movies[, which(!colnames(Merged_data_movies)%in%col_to_drop)]

#### ------- reorder  ------- ####

Merged_data_movies <- Merged_data_movies[order(Merged_data_movies$newvar), ]

##### ------- Checking for Tweets that are not fitting in the correct time frame --> write down wrong / collection methods   ------- ####


getwd()
Data_insight <- read_csv("API_data/124_TheLittleRascals.csv")
view(Data_insight)

files2 <- list.files("Series_data_descriptive", full.names = TRUE)


#### ------- CGetting Rid of the the docs with days below -30 ------- ####

Merged_data_movies <- 
  Merged_data_movies %>% 
  filter(newvar >= -30)

#### ------- Same for series above 30 days  ------- ####

Merged_data_movies <- 
  Merged_data_movies %>% 
  filter(newvar <= 30)

#### ------- Now do make a table with one column (-30 to 30) and one that sums up the number of tweets. ------- ####

tweet_volume_per_day_movies <- 
  Merged_data_movies %>% 
  count(newvar) # this is fine for now can change column names later on 

write.csv(tweet_volume_per_day_movies, "Tweet_volume_per_day_movies.csv")

#### ------- Do the same for seriees   ------- ####----------------------------------------------------------------

#### ------- Data  ------- ####
files_series <- list.files("Series_data_descriptive", full.names = TRUE)
files_series


Merged_data_series <-
  do.call(bind_rows,
          lapply(files_series, read_csv)) # this works, ignores extra column that is added... 

#### ------- drop shitty column  ------- ####
col_to_drop = c('...2')

Merged_data_series <- Merged_data_series[, which(!colnames(Merged_data_series)%in%col_to_drop)]

#### ------- reorder series  ------- ####

Merged_data_series<- Merged_data_series[order(Merged_data_series$newvar), ]

#### ------- Filter out for part that is over 30 days first   ------- ####

# nothing special just some mistakes here 
Merged_data_series <- 
  Merged_data_series %>% 
  filter(newvar <= 30)

#### ------- Filter out days below -30  ------- ####


Merged_data_series <- 
  Merged_data_series %>% 
  filter(newvar >= -30) 


#### ------- Now do make a table with one column (-30 to 30) and one that sums up the number of tweets. ------- ####

tweet_volume_per_day_series <- 
  Merged_data_series %>% 
  count(newvar) 


write.csv(tweet_volume_per_day_series, "Tweet_volume_per_day_series.csv")



