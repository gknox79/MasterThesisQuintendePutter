# filter out the important variables from imdb, combine movies and series. 
# keep this file as way for how test file later used was constructed --> if publishing i need to clean and explain this better .

#filter IMDB variables
cols_to_keep = c('titleType', 'primaryTitle', 'originalTitle', 'startYear', 'genres')

IMDB_Data2 <- IMDB_Data[, which(colnames(IMDB_Data)%in%cols_to_keep)]

# filter out movies for both --> tryout a merge there 

#try merge on orignal title and title 
?left_join
test <- left_join(Netflix_data_cleaned, IMDB_Data2, by = c("Title" = "originalTitle"))
# BETTER IDEA   -- TRY MOVIES FIRST 
Netflix_data_cleaned_movies <- Netflix_data_cleaned %>% filter(Movie == '1') # works
IMDB_Data2_movies <- IMDB_Data2 %>% filter(titleType == 'movie' | titleType == 'tvMovie') # works 

view(test)

head(IMDB_Data2_movies)


#### --- Create the correct movie data --- filter out the dupes --> then move on to series --> merge them back in. 
Movie_data <- left_join(Netflix_data_cleaned_movies, IMDB_Data2_movies, by = c('Title' = 'primaryTitle'))
view(Movie_data)
# selecting rows to keep --> long task, likely to make errors

# filter the ones that are double --> make dataframe with correct filtering ---> merge back in. 
subset(Movie_data, duplicated(Title))
?duplicated

duplicated(Movie_data$Title)
overview <- Movie_data[duplicated(Movie_data[, 1]),]
view(overview)

# So now i need to select the right rows --> then this is complete . not much to win by doing this this particular way. looks like hand work..
# select the movie rows i want to keep 
view(Movie_data)


count(Movie_data, duplicated(Title))

# have to select rows manually it seems 
Netflix_data_cleaned_movies %>% filter(Title == "Home")
Movie_data[c(1:3, 5), ]
Movie_data2 <- Movie_data[c(1:10,19,31:36,38,39,43, 54,61,63,66:68,70:74,
                            77:80, 82:84,87,90,93:96,98,100:104,106:110,155, 172,176,177,179,180,
                            186, 191, 192,194:198,202,224,228,230:233,242, 255, 265, 268:275,277:278,280:281,291,306:310,
                            316,324, 328,334:344,352:355,357:362, 364, 366:368,375,378,380,381, 383:385,388, 390:393, 395:397,
                            400:405, 410, 418, 420, 421,423:426, 429, 434:436, 445, 451,459,461,462, 464,466:467,471:472,476:479), ]

# save movie data2 --> thats the correct one for now
# do the same for series.. 
Netflix_data_cleaned_series <- Netflix_data_cleaned %>% filter(Movie == '0') # works
view(Netflix_data_cleaned_series)
IMDB_Data2_series <- IMDB_Data2 %>% filter(titleType == 'tvSeries' | titleType == "tvMiniSeries") # works 
# same for tvseries
head(IMDB_Data2)
head(IMDB_Data)
tail(IMDB_Data2)
IMDB_Data2 %>% count(titleType)
#merge
Series_data <- left_join(Netflix_data_cleaned_series, IMDB_Data2_series, by = c('Title' = 'primaryTitle'))
view(Series_data)
Series_data2 <- Series_data[c(1:4, 6:9,11:16, 18:20, 23:26, 28:37, 40:45, 48:50, 55,57,59:61, 63,67,70, 71,
                              73:81,84:87,89,90,92,93,95:104,106:108,112:116,118:124,126:127,129:132,134,135,
                              137,139,142:144,146,149:150,152,163:164,166:168,171:175,180:196,200,204,205,207:213,215),]

#series data and movie data now cleaned and correct --> need to merge them togetehr now 
Data_combined_genres <- bind_rows(Movie_data2,Series_data2)
view(Data_combined_reviews)
# couple NA's, can possibly be manually coded back in to the list.

getwd()

write.csv(Data_combined_genres, "Cleaned_data_genres.csv", row.names = FALSE) # clean file in spare time 
# change days to 17 and get rid of the duplicate row
