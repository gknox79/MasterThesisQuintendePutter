#---- Reaad in Data ----#

Movie_data <- read_csv("Sentiment_graph_movies.csv")

Series_data <- read_csv("Sentiment_graph_series.csv")


#--- Use this for graphs ----# 


# color 

colors = c("Movies" = "blue",
           "Series" = "orange")

##---- Merge datasets ----##
Dataset_figure1 <- 
  left_join(Movie_data, Series_data, by = "newvar")

names(Dataset_figure1)[names(Dataset_figure1) == "newvar"] <- 'Days_since_release'
Dataset_figure1 <- as.tibble(Dataset_figure1)

##--- Change the names ---###
names(Dataset_figure1)[names(Dataset_figure1) == "Sentiment.x"] <- "Sentiment_Movie"
names(Dataset_figure1)[names(Dataset_figure1) == "Sentiment.y"] <- "Sentiment_Series"

#--- Graph tryout ---# 

Dataset_figure1 %>% 
  ggplot(aes(x = Days_since_release)) +
  geom_line(aes(y = Sentiment_Movie, color = "Movies")) +  #basic object, colour not workign 
  geom_line(aes(y = Sentiment_Series, color = "Series"))  +
  scale_x_continuous(limits = c(-30,30), breaks = seq(-25, 25, 5)) +
  ylim(0,10) +
  labs(x = "Days Since Release",
       y = "Sentiment") + 
  theme_classic() + 
  scale_color_manual(values = colors)


