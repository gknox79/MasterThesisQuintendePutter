#Data Cleaning Document --> Retrieve data first --> Add in Dates --> further cleaning --> use dPrep course on creating proper files

#--- Load Libraries ---# 
library(readr)
library(googledrive)
library(httpuv)

#--- Create Directory ---#
dir.create(("data"), showWarnings = FALSE)

drive_auth() # authenticate 

drive_find(n_max = 20)

Downloads <- list(
  c(id = "1G9mtrLcUSU7CCIgF0lkRnDuB7sjNisWL", period =  "01_Jan_2021"),
  c(id = "1-RuntZ75-tXiBZYOB841BZPuoBnsYhzb", period =  "02_Feb_2021"),
  c(id = "1hdl-Jptns01yUPnLEi2arQcXnGWT3rGB", period =  "03_Mar_2021"),
  c(id = "1ls6zGlR8nW1pmM_NDupDvzv0FfyUA4iJ", period =  "04_Apr_2021"),
  c(id = "1wleys1KXlxS-us25FN26oojNFqMq8CGA", period =  "05_May_2021"),
  c(id = "18QK7nc19fxWTZmnWOXLjeeFtRRoGJX-l", period =  "06_Jun_2021"),
  c(id = "10X2cagNEGvKCYgGLUNDXxqb0VKedeiig", period =  "07_Jul_2021"),
  c(id = "1faL6sZinUgBVLHW2Bk9fPC9uBYhMNqQn", period =  "08_Aug_2021"),
  c(id = "1hB170s2KGCwsf1PrnKqNexfcF7vNKnzV", period =  "09_Sep_2021"),
  c(id = "1B6QTC5UpuOh896qfcSfqLtJ4pAIpueUU", period =  "10_Oct_2021"),
  c(id = "1ljOCrehTM4yGwutX_3BECzTUGxWrCGpO", period =  "11_Nov_2021"),
  c(id = "10BKQEcm7URZlY49cf4Lq0JWsFH0hPxjq", period =  "12_Dec_2021"))

for (file in Downloads) {cat(paste0("Downloading ", file['id'], "..."));drive_download(as_id(file['id']),path = paste0('data/period_', file['period'], '.csv'),overwrite = TRUE)}

sink('data/data_download.txt') # dont need this
cat('I am done')
sink()

# data stored in data folder
#data all downloaded from drive in case there are issues with my pc 
