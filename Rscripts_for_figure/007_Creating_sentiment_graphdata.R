## Figure for sentiment development through the window of -30 and 30 days 

#--- Libraries ---# 
library(readr)
library(dplyr)
library(tidyverse)
#--- Import Data ---#

Data <- read_csv("Movie_data_descriptive/Cleaned_017_ArmyoftheDead.csv")
view(Data)

#--- Testing out possible ways to measure sentiment in a way....

test <- 
  Data %>% 
  group_by(newvar) %>% 
  summarize()

test <- Data %>% group_by(newvar) %>% mutate(Sentimentscore = sum(Sentiment_Vader == "positive")/sum(Sentiment_Vader == "negative"))
view(test)

testtest <- test  %>%  group_by(newvar)%>% dplyr::summarize(Sentiment = Sentimentscore)
duplicated(testtest)
 
#getting rid of dupes 
testtest <- testtest[!duplicated(testtest),]

                                                   

# so the plan is to merge all the data from movies together -->  works for bigger files, so just need to 


# ---- Merging all the data from the movie descriptive doc.

files <- list.files('Movie_data_descriptive', pattern = ".csv$", recursive = TRUE, full.names = TRUE)
Mergeddata <- read_csv(files) %>% bind_rows()


#--- Apply 
Data<- Mergeddata %>% group_by(newvar) %>% mutate(Sentimentscore = sum(Sentiment_Vader == "positive")/sum(Sentiment_Vader == "negative"))

Data2 <- Data  %>%  group_by(newvar)%>% dplyr::summarize(Sentiment = Sentimentscore)

Data2 <- Data2[!duplicated(Data2),]

#--- Get rid of the variables out of the window [-30,30]
Data_for_graph <- Data2 %>% filter(newvar >= -30)
Data_for_graph <- Data_for_graph %>% filter(newvar <= 30)


#--- Save sentiment graph data for movies ---# 

write.csv(Data_for_graph, "Sentiment_graph_movies.csv", row.names = FALSE)

##################################--- Do the similar Series ---## ###################################
files <- list.files('Series_data_descriptive', pattern = ".csv$", recursive = TRUE, full.names = TRUE)
Mergeddata <- read_csv(files) %>% bind_rows()


#--- Apply 
Data<- Mergeddata %>% group_by(newvar) %>% mutate(Sentimentscore = sum(Sentiment_Vader == "positive")/sum(Sentiment_Vader == "negative"))

Data2 <- Data  %>%  group_by(newvar)%>% dplyr::summarize(Sentiment = Sentimentscore)

Data2 <- Data2[!duplicated(Data2),]

##--- clean out data out of window [-30,30]
Data_for_graph <- Data2 %>% filter(newvar >= -30)
Data_for_graph <- Data_for_graph %>% filter(newvar <= 30)

##### ---- write series data out -----#### 
write.csv(Data_for_graph, "Sentiment_graph_series.csv", row.names = FALSE)


dataset <- file
view(dataset)


# use this to clean out the incorrect amount of columns 
file <- read_csv("Series_data_descriptive/Cleaned_286_TheWalkingDead.csv")

col_to_delete <- c("...2")
file <- file[, which(!colnames(file)%in%col_to_delete)]
write.csv(file, "Series_data_descriptive/Cleaned_286_TheWalkingDead.csv", row.names = FALSE)


### Use for if newvar is not there 
dataset <- file
#getting rid of hours, min and sec
dataset$created_at <- strftime(dataset$created_at, format = "%Y-%m-%d")
#making start date
startdate <- dataset$created_at[1]
#setting up to be compared 
dataset$newvar <- round(difftime(dataset$created_at, startdate, units = "days"), digits = 0)
#immediate reorder
dataset <- dataset[order(dataset$newvar), ]
#write to csv doc
file <- dataset
