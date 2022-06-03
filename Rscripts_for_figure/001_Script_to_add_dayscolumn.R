### ====== Create Dir, for new files, so old files are not corrupted ====== ###
dir.create("API_data/Cleaned")


### ====== function to store to add a date variable ====== ###

Adding_days_column <- function(dataname){
  #reading data 
  dataset <- read_csv(dataname)
  #getting rid of hours, min and sec
  dataset$created_at <- strftime(dataset$created_at, format = "%Y-%m-%d")
  #making start date
  startdate <- dataset$created_at[1]
  #setting up to be compared 
  dataset$newvar <- round(difftime(dataset$created_at, startdate, units = "days"), digits = 0)
  #immediate reorder
  dataset <- dataset[order(dataset$newvar), ]
  #write to csv doc
  write.csv(dataset, paste0("Cleaned_",dataname), row.names = FALSE) 
}

### ===== Testing it out ===== ###

Adding_days_column("API_data/001_17Again.csv")
datatest <- read.csv("API_data/001_17Again.csv")
view(datatest)

### ====== Writing method to do this for all the docs in the file  ====== ###

filenames <- list.files("API_data", pattern = "*.csv", full.names = TRUE) # not sure here 
filenames
#changed dir
filenames <- list.files(pattern = "*.csv")
filenames
lapply(filenames, Adding_days_column) # error occuring at file 286 --> fixed, rerun
getwd()


?lapply






