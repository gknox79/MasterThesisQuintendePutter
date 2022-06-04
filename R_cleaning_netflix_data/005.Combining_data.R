library(readr)
library(dplyr)
library(stringr)
library(data.table)
library(modelsummary)
library(tidyverse)
library(fastDummies)
library(lubridate)
install.packages('data.table')
getwd()
# getting reviews and combining this with the genre file , remove all from environment
Complete_Data <- read.csv('cleaned_data/fixed_names_data_Netflix.csv')

# get review dataset

genre_data <- as.data.frame(fread("data/data-6.tsv"))
review_data<-as.data.frame(fread("data/review_data.tsv"))

head(genre_data)
head(review_data)

#--- Binding the two datasets ---# 

Genres_review_data <- left_join(review_data, genre_data, by = 'tconst')
rm(genre_data)
rm(review_data)
head(Genres_review_data)
?head
head(Genres_review_data, n = 5)

# --- Filter IMDB variables out ---#

cols_to_keep = c('titleType', 'primaryTitle', 'originalTitle', 'startYear', 'genres', 'averageRating',
                 'numVotes')

IMDb_data <- Genres_review_data[, which(colnames(Genres_review_data)%in%cols_to_keep)]
head(IMDb_data)

#--- Change order IMDB data ---#
col_order = c('primaryTitle', 'originalTitle', 'titleType', 'genres', 'averageRating','numVotes', 'startYear')
IMDb_data<- IMDb_data[, col_order]
head(IMDb_data)

# --- Combining Datasets ---# 

# Filter titletypes that are not needed in the dataset

IMDb_data <- IMDb_data %>% filter(titleType == 'movie' | titleType == 'tvMovie' | titleType == 'tvSeries' | titleType == 'tvMiniSeries')

# Combining the data 
Combined_data<- left_join(Complete_Data, IMDb_data, by = c('Title' = 'primaryTitle'))
view(Combined_data)
# filter out again both 

#Combined_data <- Combined_data[c(), ]

# try to do this with previous dataset <- merge those together keep the correct ones only?
test_data <- read.csv('cleaned_data/Cleaned_data_genres.csv')
view(test_data)
?left_join
Data_complete <- left_join(test_data, Combined_data)
rm(Combined_data, Complete_Data, Genres_review_data, IMDb_data, test, test_data)



view(Data_complete)
Data_complete %>% count(is.na(titleType)) # 15 rows with NA values 

# --- Delete them ---n# 
Data_complete %>% na.exclude() %>% count(Title)
?complete.cases

Data_complete <- Data_complete[complete.cases(Data_complete), ]

# --- Add +1 to total time as now it has zero's --- # 

Data_complete$total_time_top10 <- Data_complete$total_time_top10 + 1

# --- Deleting columns that are not needed anymore 

cols_to_delete <- c('titleType', 'originalTitle', 'startYear')
Data_complete <- Data_complete[, which(!colnames(Data_complete)%in%cols_to_delete)]

write.csv(Data_complete, "Data_complete_review_genre.csv", row.names = FALSE)
