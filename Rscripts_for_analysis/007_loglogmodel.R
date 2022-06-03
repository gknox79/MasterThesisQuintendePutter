#--- Libraries ---# 
library(modelsummary)
library(fixest)

#--- Get Data ---#
Regression_data <- read_csv("DataforRegressions.csv")
Regression_data <- Total_data
#--- Linear Regression --#

#Model 1 - Just the important variables 
model1 <- 
  lm(log(Time_in_Top10) ~
       log(Prevol_tweets) +
       log(Pre_release_sentiment) +
       log(Postvol_tweets) + 
       log(Post_sentiment), 
     Regression_data)

summary(model1)

#Model 2 - adding some control variables 

model2 <- 
  lm(log(Time_in_Top10) ~ 

       NetflixExcl + 
       Movie + 
       Sequel +
       averageRating + 
       VotesIMDb + 
       log(Prevol_tweets) + 
       log(Pre_release_sentiment) + 
       log(Postvol_tweets) + 
       log(Post_sentiment), 
     Regression_data)

summary(model2)

#Model 3 - Complete model with all genres included 

model3 <- 
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
       log(Pre_release_sentiment) + 
       log(Postvol_tweets) + 
       log(Post_sentiment), 
     Regression_data)

summary(model3)

# making an out put that is representable 

#insert models 
models <- list(model1, model2, model3)
modelsummary(models = models)
get_gof(model1)
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
summary(model1)

write.table(test, "summary.csv")



