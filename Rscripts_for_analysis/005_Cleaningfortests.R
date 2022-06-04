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
Total_data <- read.csv("Dataforanalysis.csv") 

#pre test 1 --- Independence
Total_data$Time_in_Top10<- Total_data$Time_in_Top10 + 1 
view(Total_data)
summary(Total_data)

#get rid of Na, Nan, inf
view(Total_data)


Total_data <- Total_data %>% filter(Pre_release_sentiment != "Inf") #Use original data for volume estimate effect
Total_data <- Total_data %>% filter(Post_sentiment != "Inf")

view(Total_data)
# Problematic is is that i cant take the log transformation of a sentiment that is zero, so delete those 
Total_data<- Total_data %>% filter(Pre_release_sentiment != 0) # keeps 256


write.csv(Total_data,"for_statisticaltests.csv", row.names = FALSE)
 

