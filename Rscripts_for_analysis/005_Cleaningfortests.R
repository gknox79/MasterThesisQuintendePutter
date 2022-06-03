## First analytical test 
#libraries
library(ggplot2)
library(tidyverse)
library(readr)
library(car)
library(olsrr)
library(gt)
library(corrplot)
library(tableHTML)

library(rcorr)
library(Hmisc)
#According to  intro research to marketing 
Total_data <- read.csv("Dataforanalysis.csv") # should make read in doc  # Need to decide if viewerscore is good fto make this graph instaed of using time in top ten
#pre test 1 --- Independence
Total_data$Time_in_Top10<- Total_data$Time_in_Top10 + 1 # additional day needs to be added, count is wrong otherwise.
view(Total_data)
summary(Total_data)
Total_data %>% filter(time_in_top10 == "80") # delete later 
Total_data %>% ggplot(aes(x = Post_sentiment, y = time_in_top10)) + geom_point() +
  scale_x_continuous(limits = c(0,100)) + scale_y_continuous(limits = c(0,10))


#get rid of Na, Nan, inf
view(Total_data)


Total_data <- Total_data %>% filter(Pre_release_sentiment != "Inf") #here i delete the INF, perhpas use the original data for volume effects.. 
Total_data <- Total_data %>% filter(Post_sentiment != "Inf")

view(Total_data)
# Problematic is is that i cant take the log transformation of a sentiment that is zero, so delete those 
Total_data<- Total_data %>% filter(Pre_release_sentiment != 0) # keeps 256


write.csv(Total_data,"for_statisticaltests.csv", row.names = FALSE)
 
##### models # can make multipel models with this, but still genre needs to be added.

