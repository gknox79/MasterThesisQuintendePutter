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

#--- Loading Data ---# 
Complete_Data <- read.csv('cleaned_data/Complete_data_Netflix.csv')
view(Complete_Data)

#--- Creating one row per movie/observation
Complete_Data2 <- Complete_Data %>% group_by(Title) %>% summarize(Firstday_2021 = min(Top10_date), 
                                                        Lastday_2021 = max(Top10_date),
                                                        Lowest_Rank = max(Rank),
                                                        Highest_Rank = min(Rank),
                                                        Days_in_Top = max(`Days.InTop.10`), 
                                                        min_days_Top10 = min(Days.InTop.10),# need to add another variable uses numbers from previous seasons here
                                                        Viewer_Score = max(`Viewer.shipScore`), 
                                                        Netflix_release = min(NetflixReleaseDate),
                                                        NetflixExcl = min(NetflixExcl.),
                                                        Movie = min(Movie))
view(Complete_Data2)


#--- Filter out those were already in the top ten before 1 jan 2021 ---#
To_be_removed <- Complete_Data2 %>% filter(min_days_Top10 > 1) %>% filter(Firstday_2021 == '2021-01-01')
Complete_Data2 <- anti_join(Complete_Data2, To_be_removed, by = 'Title')


rm(To_be_removed)

#--- dummy creation for productions that have one. problem is that for movies this is much harder, perhaps can do this with IMDB dataset.. 

Complete_Data2$Sequel <- rep(0, nrow(Complete_Data2))
Complete_Data2$Sequel[Complete_Data2$min_days_Top10 > 1] <- 1 

#fix mistakes here already some movies are classified as sequals but are not and other way around, need to correct manually 
Complete_Data2$Sequel[which(Complete_Data2$Title == 'Hop')] <- 0
Complete_Data2$Sequel[which(Complete_Data2$Title == 'Single All the Way')] <- 0
Complete_Data2$Sequel[which(Complete_Data2$Title == 'The Christmas Chronicles')] <- 0

# corrected 
Complete_Data2 %>% filter(Title == 'The Christmas Chronicles 2') 
view(Complete_Data2)

#-- still not correct, only partially filtered out all sequals --> those with first seasons before tracking top ten are not correctly listed here

# all the productions in the sequal_ series must have sequel value
view(test)
test$sequel[test$Netflix_release < '2021-01-01' & test$Movie == '0'] <- 1 
Complete_Data2 %>% filter(Movie == '1', Sequel == '1')
# do this for Complete_data
Complete_Data2$Sequel[Complete_Data2$Netflix_release < '2021-01-01' & Complete_Data2$Movie == '0'] <- 1
view(Complete_Data2)  # seems to be fine now --> only need to check for movies now as well 

sequels_all <- Complete_Data2 %>% filter(Netflix_release < '2021-01-01')
sequels_all %>% filter(Movie == '1') # might need to check all movies manually --> hard to tell which is a sequel and which is not... --> finish this ohopefully today

Complete_Data2 %>% filter(Title == 'Hop')

# make Corrections for movies that are a sequal but are still classified as not.. 
Complete_Data2$Sequel[which(Complete_Data2$Title == 'The Secret Life of Pets 2')] <- 1
Complete_Data2[270,]$Sequel <- 1 #title selection to hard
Complete_Data2$Sequel[which(Complete_Data2$Title == 'The Twilight Saga: Eclipse')] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == 'The Twilight Saga: New Moon')] <- 1 
Complete_Data2$Sequel[which(Complete_Data2$Title == 'A Haunted House 2')] <- 1  
Complete_Data2$Sequel[which(Complete_Data2$Title == 'American Pie: Reunion')] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == 'Animals on the Loose: A You…')] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == 'Army of Thieves')] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == 'Bigfoot Family')] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == 'Death to 2021')] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == 'Fear Street Part 2: 1978')] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == 'Fear Street Part 3: 1666')] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == 'Grumpy Christmas')] <- 1 
Complete_Data2$Sequel[which(Complete_Data2$Title == "Madagascar 3: Europe's Most…")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "My Little Pony: A New Gener…")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "Octonauts & The Ring of Fire")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "Peter Rabbit 2")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "Skylines")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "Sniper: Ghost Shooter")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "Step Up Revolution")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "Talladega Nights: The Balla…")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "The Conjuring 2")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "The Dark Knight")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "The Kissing Booth 3")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "The Loud House Movie")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "To All the Boys Always and …")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "Trollhunters: Rise of the T…")] <- 1
Complete_Data2$Sequel[which(Complete_Data2$Title == "Trollhunters: Rise of the T…")] <- 1

view(Complete_Data2)

#-- Next step -- getting days 2 highest rank & new viewership score

#--- Gettign days to highest rank
Complete_Data2 %>% filter(Netflix_release < '2021-01-01') 

#- get date for highest rank testing first in original dataset 
Complete_Data %>% group_by(Title) %>% filter(min(Rank))
Complete_Data %>% group_by(Title) %>% summarise()

test = Complete_Data
Complete_Data %>% group_by(Title) %>% which.min(Rank = min(Rank))

min(test$Rank)
view(test)


# Other Solutions 
Complete_Data %>% group_by(Title) %>% slice(which.min(Rank)) 
# make a dataset --> merge them so that this is fixed
Time_2_Top_data <- Complete_Data %>% group_by(Title) %>% slice(which.min(Rank))
cols_to_keep = c('Title', 'Top10_date')
Time_2_Top_data = Time_2_Top_data[, which(colnames(Time_2_Top_data)%in%cols_to_keep)]
Complete_Data2 <- left_join(Complete_Data2, Time_2_Top_data, by = "Title")

#substract time_2_top_data - first appearance on list 
view(Complete_Data2)

Complete_Data2$Top10_date - Complete_Data2$Firstday_2021
# making days2top column and store the variables in there.


Complete_Data2$Firstday_2021 <- as.Date(Complete_Data2$Firstday_2021)
Complete_Data2$Top10_date <- as.Date(Complete_Data2$Top10_date)

Complete_Data2$Days_2_peak <- as.numeric(Complete_Data2$Top10_date - Complete_Data2$Firstday_2021)
# Rank debut 
view(Complete_Data)

# Total days 
Complete_Data2$Firstday_2021 <- as.Date(Complete_Data2$Firstday_2021)
Complete_Data2$Lastday_2021 <- as.Date(Complete_Data2$Lastday_2021)
Complete_Data2$total_time_top10 <- as.numeric(Complete_Data2$Lastday_2021 - Complete_Data2$Firstday_2021)
view(Complete_Data2)


# Debut rank
Debut_data <- Complete_Data %>% filter(row_number() == 1)
cols_to_keep = c('Title', 'Rank')
Debut_data = Debut_data[, which(colnames(Debut_data)%in%cols_to_keep)]
names(Debut_data)[names(Debut_data)=='Rank'] <- 'Debut_Rank'

##join datasets 
Complete_Data2<- left_join(Complete_Data2, Debut_data, by = "Title")
view(Complete_Data2)

# Viewership score development 

breaks <- c(seq(1,11))

seq(10,1)
breaks

Complete_Data$Score <- as.numeric(cut(-Complete_Data$Rank, breaks = -breaks, right = TRUE)) 
view(Complete_Data)
?cut
Score_data <- Complete_Data %>% group_by(Title) %>% summarize(Viewerscore = sum(Score))
Complete_Data2 <- left_join(Complete_Data2, Score_data, by = 'Title')
view(Complete_Data2)
# clean dataset of columns that are not needed anymore + reorder
cols_to_keep <- c('Title', 'Firstday_2021', 'Lastday_2021','total_time_top10', 'Debut_Rank', 'Highest_Rank', 'Days_2_peak',
                  'Viewerscore', 'NetflixExcl', 'Movie', 'Sequel', 'Netflix_release')

Netflix_data_cleaned <- Complete_Data2[, which(colnames(Complete_Data2)%in%cols_to_keep)]


## reorder
Col_order <- c('Title', 'Firstday_2021', 'Lastday_2021','total_time_top10', 'Debut_Rank', 'Highest_Rank', 'Days_2_peak',
               'Viewerscore', 'NetflixExcl', 'Movie', 'Sequel', 'Netflix_release')
Netflix_data_cleaned <- Netflix_data_cleaned[, Col_order]
view(Netflix_data_cleaned)
rm(Debut_data, Score_data, test, Test_file, Time_2_Top_data)
rm(breaks, Col_order, cols_to_drop, cols_to_keep, values, x)
# complete data -> addd IMDB --> new file

write.csv(Netflix_data_cleaned, "Cleaned_data_Netflix.csv", row.names = FALSE) # clean file in spare time 

