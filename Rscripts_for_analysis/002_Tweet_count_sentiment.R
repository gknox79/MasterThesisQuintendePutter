# combining twitter data files with main file did this manual, probably can loop this. 

library(tidyverse)
library(dplyr)

# need some kind of function that makes a table 

#read in data
Files_to_read <- list.files("Data_Splitted", full.names = T)[597:598] # add in splitted datafile

Files_to_read[2]
Files_to_read[1] # control 


Data_prerelease <- read_csv(Files_to_read[2])
Data_postrelease <- read_csv(Files_to_read[1])

### pre release
Pre_Release <- Data_prerelease %>% summarize(Title = "Who Killed Sara? 2",
                                   Positive_tweets_pre = sum(Sentiment_Vader == "positive"),
                                   Negative_tweets_pre = sum(Sentiment_Vader == "negative"),
                                   Pre_release_sentiment =  Positive_tweets_pre / Negative_tweets_pre, #add in sentiment
                                   Pre_tweet_volume = sum(n()))

### post release                                 
Post_Release <- Data_postrelease %>% summarize(Title = "Who Killed Sara? 2",
                                            Positive_tweets_post = sum(Sentiment_Vader == "positive"),
                                            Negative_tweets_post = sum(Sentiment_Vader == "negative"),
                                            Post_release_sentiment =  Positive_tweets_post / Negative_tweets_post, #add sentiment
                                            Post_tweet_volume = sum(n()))



#### Combine the data 

table_file <- left_join(Pre_Release, Post_Release, by = "Title" )
### combine with big file
Total_data <- union(Total_data, table_file)
view(Total_data)
write.csv(Total_data, "Twitter_api_data_test.csv", row.names = FALSE)
#### ================================== testing part here 



Total_data$Pre_release_sentiment <- round(Total_data$Pre_release_sentiment, 2)
Total_data$Post_release_sentiment <- round(Total_data$Post_release_sentiment, 2)
write.csv(Total_data, "Twitter_api_data_test.csv", row.names = FALSE)









