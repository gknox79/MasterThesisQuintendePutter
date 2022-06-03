#Combine all the Twitter files --> Need full number fro the thesis report 
getwd()
rm(csv_list)
#Packages 
library(dplyr)
library(readr)
#read in the files as plaintext
multimerge = function(path){
    filenames = list.files(path = path, full.names = TRUE)
    rbindlist(lapply(filenames, fread))
}

path <- "API_data"
Dataframe = multimerge(path)



files <- list.files('API_data', pattern = ".csv$", recursive = TRUE, full.names = TRUE)
Mergeddata <- read_csv(files) %>% bind_rows()

rm(Mergeddata)


# estimating the total amount of Tweets 