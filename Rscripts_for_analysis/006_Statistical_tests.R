#statistical checks for the data 

library(lmtest)

#--- Load in Data ---#

Total_data <- read.csv("for_statisticaltests.csv")

#--- Log-Log model ---#

model <- lm(log(Time_in_Top10) ~ 
               averageRating + VotesIMDb + log(Prevol_tweets) + log(Pre_release_sentiment) +
               log(Postvol_tweets) + log(Post_sentiment), Total_data)

#--- Linearity Test ---#
plot(model)

#--- Homoscedasticiy Test ---#

install.packages("lmtest")
library(lmtest)
bptest(Model1)

#--- Cook's Distance Test ---#

#--- influential cases ---#
ols_plot_cooksd_bar(model, threshold = 1)
cooksd <- cooks.distance(model)
samplesize = nrow(Total_data)
plot(cooksd,  cex=1, main = "Influential Obs by Cooks Distance")
abline(h = 1, col="red")
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>1, names(cooksd),""), col="red")

# take out number 174 & 225
Total_data <- Total_data[-c(174,225),] 

# --- Show difference in linearity ---#
model_wo_outlier <- lm(log(Time_in_Top10) ~ 
              Debut_Rank + Days_2_peak + 
              averageRating + VotesIMDb + log(Prevol_tweets) + log(Pre_release_sentiment) +
              log(Postvol_tweets) + log(Post_sentiment), Total_data)

#--- Linearity Test 2 ---#
plot(model_wo_outlier)

#--- VIF and Tolerance scres ---#

ols_vif_tol(model_wo_outlier)
cor(Total_data)
Cor_table_data <- Total_data %>% select("Time_in_Top10", "Debut_Rank",
                                                  "Days_2_peak", "averageRating", "VotesIMDb",
                                                  "Prevol_tweets", "Pre_release_sentiment", "Postvol_tweets", "Post_sentiment")
cor(Cor_table_data)



write.csv(Total_data, "DataforRegressions.csv", row.names = FALSE)






