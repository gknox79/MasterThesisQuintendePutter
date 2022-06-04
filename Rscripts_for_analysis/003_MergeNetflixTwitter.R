###### ======= Libraries ======= ######
library(dplyr)
library(tidyverse)
library(qdapTools)

library(rlang)
# read in dataframe --> fix all the things wrong metioned in previous doc

Netflix_data <- read_csv("DatasetNetflixTopten_changed.csv")
Twitter_data <- read_csv("Twitter_api_data_test.csv")


### Checking types of variabes before mrege
typeof(Netflix_data$Title)
typeof(Twitter_data$Title)


###### ======= Join datasets together ======= ######
## change twilight names to correct ones 

Twitter_data$Title[which(Twitter_data[137, ])] <- "The Twilight Saga: Eclipse"

view(Twitter_data)
Complete_dataset<- left_join(Netflix_data, Twitter_data, by = "Title")
view(Complete_dataset)

###### ======= Get rid of column and make genre into seperate columns  ======= ######
cols_to_delete <- "...1"
Complete_dataset <- Complete_dataset[, which(!colnames(Complete_dataset)%in%cols_to_delete)]
view(Complete_dataset)
Test <- Complete_dataset

#### Splitting Genre 
typeof(Test$genres)

# example from Stackoverflow 
testtest <- cbind(Test["genres"], mtabulate(strsplit(as.character(Test$genres), ",")))

testtest <- testtest %>%  mutate(Fantasy_correct = +if_any(contains('fantasy')))
testtest <- testtest %>% mutate(Crime_corrected = +if_any(contains('crime')))
testtest <- testtest %>% mutate(Drama_corrected = +if_any(contains('Drama')))
testtest <- testtest %>% mutate(Mystery_corrected = +if_any(contains('Mystery')))
testtest
#rename 
cols_to_delete <- c("Fantasy", "Drama", "Crime", "Mystery", "cols_to_delete", " Fantasy", " Crime", " Drama", " Mystery" )
testtest <- testtest[, which(!colnames(testtest)%in%cols_to_delete)]

colnames(testtest)
view(testtest)

### Filter out genres I intend to keep --> see if this is reasonable to do 
# Perhaps try to merge all the colnames not in the 7 into others. 
testtest %>% mutate(others = +if_any(contains("Mystery_corrected", "Crime_Corrected")))


Cols_to_keep <- c("Action", "Adventure", "Anime", "Comedy", "Documentary", "Drama_corrected", "Fantasy_correct", "Reality", "Romance", "Horror", "Thriller", "Sci-Fi")
testtest <- testtest[, which(colnames(testtest)%in%Cols_to_keep)]
view(testtest)

Complete_dataset <- (bind_cols(Complete_dataset, testtest))
view(Complete_dataset)
## get rid of genre column 

cols_to_delete <- "genres"
Complete_dataset <- Complete_dataset[, which(!colnames(Complete_dataset)%in%cols_to_delete)]
view(Complete_dataset)

#reorder and clean file further, check for cols that can be deleted.filter out those for censoring 

obs_tocheck <- Complete_dataset %>% filter(Lastday_2021 == "2021-12-31")
view(obs_tocheck)
rm(obs_tocheck)
#delete the ones that are still in the top ten on january 1 2022
Complete_dataset <- Complete_dataset %>% subset(Title != "Crime Scene: The Times Square Killer")
Complete_dataset <- Complete_dataset %>% subset(Title != "Don't Look Up")
Complete_dataset <- Complete_dataset %>% subset(Title != "Emily in Paris")
Complete_dataset <- Complete_dataset %>% subset(Title != "The Silent Sea")
Complete_dataset <- Complete_dataset %>% subset(Title != "The Witcher")
view(Complete_dataset)


#delete excessive columns 
#Netflix release perhaps for seasonality? --> discuss on meeting
cols_to_delete <- c("Firstday_2021", "Lastday_2021")
Complete_dataset <- Complete_dataset[, which(!colnames(Complete_dataset)%in%cols_to_delete)]
view(Complete_dataset)
#rename some columns 
Test <- Complete_dataset %>% select(Title, total_time_top10, Debut_Rank,
                                    Highest_Rank, Days_2_peak, NetflixExcl, Movie, Sequel, 
                                    averageRating, numVotes, Pre_tweet_volume, Pre_release_sentiment, Post_tweet_volume, Post_release_sentiment,
                                    Action, Adventure, Comedy, Documentary, Drama_corrected, Fantasy_correct, Horror, Romance, `Sci-Fi`, Thriller)
view(Test)
#reorder total dataset 


##write to csv
write.csv(Complete_dataset, "Complete_data.csv", row.names = FALSE )

