### descriptive Figure 

### ========= packages ========= ###

library(ggplot2)
library(dplyr)
library(tidyverse)
library(data.table)

### ========= read datasets ========= ###
movies <- read_csv("Tweet_volume_per_day_movies.csv")
series <- read_csv("Tweet_volume_per_day_series.csv")

### ========= Rename n column  & getting rid of ...1 column ========= ###

names(movies)[names(movies) == "n"] <- 'Daily_Tweets_Movies'

names(series)[names(series) == "n"] <- 'Daily_Tweets_Series'

cols_to_drop <- c('...1')

movies <- movies[, which(!colnames(movies)%in%cols_to_drop)]
series <- series[, which(!colnames(series)%in%cols_to_drop)]

### ========= Merge datasets  ========= ###

Dataset_figure1 <- 
  left_join(movies, series, by = "newvar")

names(Dataset_figure1)[names(Dataset_figure1) == "newvar"] <- 'Days_since_release'


### ========= test runs ========= ###
Dataset_figure1 %>% 
  ggplot(aes(x = Days_since_release, y = Daily_Tweets_Movies)) + 
  geom_point() # need to figure this out for tomorrow or this evening 


Dataset_figure1 <- as.tibble(Dataset_figure1)

test <- data.frame(Dataset_figure1)
# shouldnt matter that much ---> try out example stackoverflow


colors = c("Movies" = "blue",
           "Series" = "orange")

colo
#leave tittle out, dont need it --> do that with word. Same for notes 
plot_descriptive <-
  Dataset_figure1 %>% 
  ggplot(aes(x = Days_since_release)) +
  geom_line(aes(y = Daily_Tweets_Movies, color = "Movies")) +  #basic object, colour not workign 
  geom_line(aes(y = Daily_Tweets_Series, color = "Series"))  +
  scale_x_continuous(limits = c(-30,30), breaks = seq(-25, 25, 5)) +
  labs(x = "Days Since Release",
       y = "Number of Tweets") + 
  theme_bw() + 
  scale_color_manual(values = colors)




