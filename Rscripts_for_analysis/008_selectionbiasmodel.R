# Data analysis without Sentiment 

# ----Load in Data ----#
Total_data <- 
  read_csv("Dataforanalysis.csv")# this is the dataset with the 5 observations of censoring removed. 

# ---Time in top ten correction ---#
Total_data$Time_in_Top10<- Total_data$Time_in_Top10 + 1 

# Delete 0s, NA and other stuff for the log variables
view <- Total_data %>% filter(Prevol_tweets == 0 )
Total_data %>% filter(Postvol_tweets == 0)

Total_data2 <- 
  Total_data %>% 
  filter(Prevol_tweets == 0)

# Model to check assumptions ### post sentiment model 

summarise(Total_data)
model <- lm(log(Time_in_Top10) ~ 
              Debut_Rank + Days_2_peak + 
              averageRating + VotesIMDb +
              log(Postvol_tweets), Total_data)

plot(model)

# getting rid of outliers 

Total_data <- Total_data[-c(265),] 
Total_data <- Total_data[-c(207),]


#Complete statistical model Post sentiment dont inlcude 
Post_sentiment_model <- 
  lm(log(Time_in_Top10) ~ 
       Debut_Rank + 
       Days_2_peak + 
       NetflixExcl + 
       Movie + 
       Sequel + 
       averageRating + 
       VotesIMDb +
       Action + 
       Adventure + 
       Comedy + 
       Documentary + 
       Drama + 
       Horror + 
       Romance + 
       Thriller + 
       log(Postvol_tweets),
     Total_data)

summary(Post_sentiment_model)


# -------- Including Pre-release sentiment -------- # 


Total_data2 <- 
  Total_data %>% 
  filter(Prevol_tweets != 0)

# --- Checking assumptions ---# 

model <- lm(log(Time_in_Top10) ~ 
              Debut_Rank + Days_2_peak + 
              averageRating + VotesIMDb +
              log(Postvol_tweets) + log(Prevol_tweets), Total_data2)

Pre_Post_sentiment_model <- 
  lm(log(Time_in_Top10) ~ 
       NetflixExcl + 
       Movie + 
       Sequel + 
       averageRating + 
       VotesIMDb +
       Action + 
       Adventure + 
       Comedy + 
       Documentary + 
       Drama + 
       Horror + 
       Romance + 
       Thriller + 
       log(Prevol_tweets) +
       log(Postvol_tweets),
     Total_data2)
summary(Pre_Post_sentiment_model)



#---- putting it in a better looking table
models <- list(Pre_Post_sentiment_model)

# --- making the table

gm <- tibble::tribble(
  ~raw, ~clean, ~fmt,
  "nobs", "N", 0,
  "r.squared", "R<sup>2</sup>", 3,
  "adj.r.squared", "R<sup>2</sup> Adj.", 3)

test <- modelsummary(models,
                     coef_map = c('(Intercept)' = 'Intercept',
                                  'log(Prevol_tweets)' = 'Tweet Volume Pre-release (log)',
                                  'log(Pre_release_sentiment)' = 'Tweet Sentiment Pre-Release (log)',
                                  'log(Postvol_tweets)' = 'Tweet Volume Post-release (log)',
                                  'log(Post_sentiment)' = 'Tweet Sentiment Post-Release (log)',
                                  'Debut_Rank' = 'Debut Rank',
                                  'Days_2_peak' = 'Days to Peak',
                                  'NetflixExcl' = 'Netflix Exclusive',
                                  'Movie' = 'Movie',
                                  'Sequel' = 'Sequel',
                                  'averageRating' = 'Average IMDb Rating',
                                  'VotesIMDb' = 'Number of IMDb Votes',
                                  'Action' = 'Action',
                                  'Adventure' = 'Adventure',
                                  'Comedy' = 'Comedy',
                                  'Documentary' = 'Documentary',
                                  'Drama' = 'Drama',
                                  'Horror' = 'Horror',
                                  'Romance' = 'Romance',
                                  'Thriller' = 'Thriller'
                     ),
                     estimate = "{estimate}{stars}",
                     fmt = 3,
                     #statistic = "statistic",
                     gof_map = gm,
                     stars = c('*' = 0.1, '**' = 0.05, '***' = 0.01),
                     notes = 'Note: The dependent variable in all the models showcased is the time spend in the Netflix top ten
             measured in days. This dependent variable is log-transformed. The standard error is shown in the parentheses.'
) ### add in notes
test
