# explorative

totaldata_regression_analysis

Regression_data <- read_csv("DataforRegressions.csv")

# Model 1 Simple Model
model_1 <- 
  lm(log(Debut_Rank) ~
       log(Prevol_tweets) * log(Pre_release_sentiment),
      data = Regression_data)
summary(model_1)
  
# Model 2 Extended Model
model_2 <- lm(log(Debut_Rank) ~
                log(Prevol_tweets) * log(Pre_release_sentiment) +
                NetflixExcl + 
                Movie + 
                Sequel,
              data = Regression_data)

summary(model_2)

# Model 3 - Complete Model
model_3 <- lm(log(Debut_Rank) ~
                log(Prevol_tweets) * log(Pre_release_sentiment) + 
                NetflixExcl + 
                Movie + 
                Sequel+ 
                Action + Adventure + Comedy + Documentary + Drama + Horror + Romance + Thriller,
              data = Regression_data)

summary(model_3)


# make model 4 here with only volume --> so the bigger dataset can be used here. use total data 2 here. 

Total_data <- 
  read_csv("Dataforanalysis.csv")
Total_data$Time_in_Top10<- Total_data$Time_in_Top10 + 1 
Total_data <- Total_data[-c(265),] 
Total_data <- Total_data[-c(207),]
Total_data <- 
  Total_data %>% 
  filter(Prevol_tweets != 0)

model_4 <- 
  lm(log(Debut_Rank) ~
       log(Prevol_tweets)+
       NetflixExcl +
       Movie +
       Sequel +
       Action + Adventure + Comedy + Documentary + Drama + Horror + Romance + Thriller,
     data = Total_data
       )

summary(model_4)


#modelsummary(models = models)

models <- list(model_1, model_2, model_3, model_4)

#Setting up Formatting 
gm <- tibble::tribble(
  ~raw, ~clean, ~fmt,
  "nobs", "N", 0,
  "r.squared", "R<sup>2</sup>", 3,
  "adj.r.squared", "R<sup>2</sup> Adj.", 3)

test <- modelsummary(models,
                     coef_map = c('(Intercept)' = 'Intercept',
                                  'log(Prevol_tweets)' = 'Tweet Volume Pre-release (log)',
                                  'log(Pre_release_sentiment)' = 'Tweet Sentiment Pre-Release (log)',
                                  'log(Prevol_tweets):log(Pre_release_sentiment)' = 'Pre-release Tweet volume x Pre-release Tweet Sentiment (log)',
                                  'NetflixExcl' = 'Netflix Exclusive',
                                  'Movie' = 'Movie',
                                  'Sequel' = 'Sequel',
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

write.csv(totaldata_regression, "cleaned_data.csv", row.names = FALSE)
test

