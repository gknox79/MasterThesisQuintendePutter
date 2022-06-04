#Need to split Datasets in to 2 based on the created_at data.

library(dplyr)
library(readr)
library(tidyverse)
library(lubridate)

#--- Read in Data ---#

Data <- read_csv("API_data/262_TheBabySittersClub.csv") # import the File to split here, example here. need to go over all of them manually
# probably can automate this, but not sure
Data$created_at <- ymd_hms(Data$created_at)

#--- Split data ---#

Pre_releasedata <- Data %>% filter(created_at < "2021-10-11 19:00:00") #enter correct splitting time 
Post_releasedata <- Data %>% filter(created_at > "2021-10-11 19:00:01") # enter correct splitting time 

#--- Make folder and store the data ther eStore the data ---#
#dir.create("Data_Splitted") -- only need to do this once. 

write.csv(Pre_releasedata, "Data_Splitted/262_TheBabySittersClub_pre.csv", row.names = FALSE)
write.csv(Post_releasedata, "Data_Splitted/262_TheBabySittersClub_post.csv", row.names = FALSE)
