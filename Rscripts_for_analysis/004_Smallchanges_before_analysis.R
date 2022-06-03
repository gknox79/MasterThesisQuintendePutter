#### Selected cols needed for first round of analysis
Complete_dataset <- read_csv("Complete_data.csv")


Total_data <- Complete_dataset %>% select(Title, total_time_top10, Debut_Rank,
                                    Highest_Rank, Days_2_peak, NetflixExcl, Movie, Sequel, 
                                    averageRating, numVotes, Pre_tweet_volume, Pre_release_sentiment, Post_tweet_volume, Post_release_sentiment,
                                    Action, Adventure, Comedy, Documentary, Drama_corrected, Fantasy_correct, Horror, Romance, `Sci-Fi`, Thriller, Viewerscore)
view(Total_data)
#rename some columns 
colnames(Total_data)[which(colnames(Total_data)=='total_time_top10')] <- 'Time_in_Top10'
colnames(Total_data)[which(colnames(Total_data)=='average_Rating')] <- 'IMDb_Rating'
colnames(Total_data)[which(colnames(Total_data)=='numVotes')] <- 'VotesIMDb'
colnames(Total_data)[which(colnames(Total_data)=='Pre_tweet_volume')] <- 'Prevol_tweets'
colnames(Total_data)[which(colnames(Total_data)=='pre_release_sentiment')] <- 'Pre_Sentiment'
colnames(Total_data)[which(colnames(Total_data)=='Post_tweet_volume')] <- 'Postvol_tweets'
colnames(Total_data)[which(colnames(Total_data)=='Post_release_sentiment')] <- 'Post_sentiment'
colnames(Total_data)[which(colnames(Total_data)=='Drama_corrected')] <- 'Drama'
colnames(Total_data)[which(colnames(Total_data)=='Fantasy_correct')] <- 'Fantasy'

view(Total_data)

#write to csv 
write.csv(Total_data, "Dataforanalysis.csv", row.names = FALSE)





