# Complete dataset Manipulation Part 1

#--- Libraries ---#

library(readr)
library(dplyr)
library(stringr)
library(data.table)
library(modelsummary)
library(tidyverse)
library(fastDummies)
library(lubridate)
getwd()

#--- Load data ---#
files = list.files('data', pattern = 'csv', full.names = T)

#--- Make one list & dataset ---#
tmp <- lapply(files, fread)
all_data <- rbindlist(tmp)
Complete_Data <- tibble(all_data)
print("test")
#--- Remove whats not necessary anymore ---#
rm(files, tmp, all_data, file)

#--- data checks ---#

head(Complete_Data, 10)
tail(Complete_Data, 10)

#--- Create date class objects ---#
values = seq(from = as.Date("2021-01-01"), to = as.Date("2021-12-31"), by = 'day')
Complete_Data = cbind(Complete_Data, date = rep(values, each = 10)) 
names(Complete_Data)[names(Complete_Data) == 'date'] <- 'Top10_date' 

#--- Get rid of column WatchNow and X ---#
cols_to_drop = c('WatchNow', 'V1')
Complete_Data = Complete_Data[, which(!colnames(Complete_Data)%in%cols_to_drop)]

#--- Move order of the data ---#

Col_order <- c("Title", "Top10_date", "Rank", "YD", "LW", "Days InTop 10", "Viewer-shipScore", "Type",
               "NetflixExcl.", "NetflixReleaseDate")
Complete_Data <- Complete_Data[, Col_order]

#--- Creating Dummy Variables ---# 

# Netflix exclusive 
Complete_Data$NetflixExcl. <- ifelse(Complete_Data$NetflixExcl. == 'Yes', 1, 0) #if exclusive value is equal to 1


# Filter out stand-up comedian --> low number of observations
Complete_Data <- Complete_Data %>% group_by(Title) %>% filter(Type != "Stand-Up Comedy")

# Change Movie / series to 1 & 0's 

Complete_Data$Type <- ifelse(Complete_Data$Type == 'Movie', 1, 0) #if movie its 1, series is 0
names(Complete_Data)[names(Complete_Data)=='Type'] <- 'Movie' 

#--- change order of rows --> each serie / movie complete then the next movie etc. 

Complete_Data <- Complete_Data %>% arrange(Title, Top10_date) #not sure, perhaps change later 


#--- Filter out productions made in 2021 --> then move it to long data frame --> one obs. per movie otherwise hard for analysis

Complete_Data$NetflixReleaseDate <- mdy(Complete_Data$NetflixReleaseDate)

# Need to set up variables to correct types

Complete_Data$Top10_date <- as.Date(Complete_Data$Top10_date)
Complete_Data$NetflixReleaseDate <- as.Date(Complete_Data$NetflixReleaseDate)


# Filter out publishing dates after 1 jan 2021
# 3650 rows before filtering out published before 2021

Complete_Data %>% filter(NetflixReleaseDate < '2021-01-01')
# Problem i don't want to filter out all, since there are sequals in the dataset...
# select those, find out about the prequels and get rid of the others --> store the others with a variable that it is a sequel 

temp <- Complete_Data %>% filter(NetflixReleaseDate < '2020-12-31')

summary(temp)
temp <- temp %>% arrange(desc(NetflixReleaseDate))
?arrange

view(Complete_Data)


#--- save Dataset --- #

# --- Create dictionary and export csv file ---#
dir.create(("cleaned_data"), showWarnings = FALSE)

# weird that it is not creating it in the correct folder, need to fix this later 
write.csv(Complete_Data, "Complete_data_Netflix.csv", row.names = FALSE)

getwd()
