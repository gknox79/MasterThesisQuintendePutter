# IMDB data 

IMDb_Data <- read_tsv("data-6.tsv")
# get the data 
Netflix_data_cleaned <- read.csv('cleaned_data/Cleaned_data_Netflix.csv')

#data view


head(IMDB_Data)

# correcting all the titles in the data set that are not correctly spelled

#A california christmas
IMDB_Data %>% filter(primaryTitle == "A California Christmas: City Lights")
Netflix_data_cleaned %>% filter(Title == "A California Christmas: City Lights")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "A California Christmas: Cit…")] <- "A California Christmas: City Lights"

# Age of  Samurai: Battle for Japan 
IMDB_Data %>% filter(primaryTitle == "Age of Samurai: Battle for Japan")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Age of Samurai: Battle for …")] <- "Age of Samurai: Battle for Japan" # copy names--> less error


# Elite
Élite
IMDB_Data %>% filter(primaryTitle == "Elite")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Ãlite")] <- "Elite"

# Animals on the Loose: A You vs. Wild Movie
IMDB_Data %>% filter(primaryTitle == "Animals on the Loose: A You vs. Wild Movie")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Animals on the Loose: A You…")] <- "Animals on the Loose: A You vs. Wild Movie"
view(Netflix_data_cleaned)

# Bob Ross: Happy Accidents, Betrayal & Greed
IMDB_Data %>% filter(primaryTitle == "Bob Ross: Happy Accidents, Betrayal & Greed")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Bob Ross: Happy Accidents, …")] <- "Bob Ross: Happy Accidents, Betrayal & Greed"


# Cocaine Cowboys: The Kings of Miami
IMDB_Data %>% filter(primaryTitle == "Cocaine Cowboys: The Kings of Miami")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Cocaine Cowboys: The Kings …")] <- "Cocaine Cowboys: The Kings of Miami"
view(Netflix_data_cleaned)

# Crime Scene: The Times Squa…
IMDB_Data %>% filter(primaryTitle == "Crime Scene: The Times Square Killer")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Crime Scene: The Times Squa…")] <- "Crime Scene: The Times Square Killer"
view(Netflix_data_cleaned)

# Crime Scene: The Vanishing at the Cecil Hotel
IMDB_Data %>% filter(primaryTitle == "Crime Scene: The Vanishing at the Cecil Hotel")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Crime Scene: The Vanishing …")] <- "Crime Scene: The Vanishing at the Cecil Hotel"

# CDisenchantment
IMDB_Data %>% filter(primaryTitle == "Disenchantment")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Disenchantment")] <- "Disenchantment"

# Don't Look up
IMDB_Data %>% filter(primaryTitle == "Don't Look Up")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Donât Look Up")] <- "Don't Look Up"

# Fear Street Part 1: 1994
IMDB_Data %>% filter(primaryTitle == "Fear Street: Part One - 1994")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Fear Street Part 1: 1994")] <- "Fear Street: Part One - 1994"

# Fear Street Part 1: 1978
IMDB_Data %>% filter(primaryTitle == "Fear Street: Part Two - 1978")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Fear Street Part 2: 1978")] <- "Fear Street: Part Two - 1978"

# Fear Street Part 1: 1666
IMDB_Data %>% filter(primaryTitle == "Fear Street: Part Three - 1666")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Fear Street Part 3: 1666")] <- "Fear Street: Part Three - 1666"

# Finding 'Ohana
IMDB_Data %>% filter(primaryTitle == "Finding 'Ohana")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Finding âOhana")] <- "Finding 'Ohana"

# He's All That
IMDB_Data %>% filter(primaryTitle == "He's All That")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Heâs All That")] <- "He's All That"

# I care a lot 
IMDB_Data %>% filter(primaryTitle == "I Care a Lot")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "I Care a Lot.")] <- "I Care a Lot"


# Jenni Rivera: Mariposa de Barrio
IMDB_Data %>% filter(primaryTitle == "Jenni Rivera: Mariposa de Barrio")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Jenni Rivera: Mariposa de B…")] <- "Jenni Rivera: Mariposa de Barrio"

#JoJo's Bizarre Adventure
IMDB_Data %>% filter(primaryTitle == "JoJo's Bizarre Adventure")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Jojoâs Bizarre Adventure")] <- "JoJo's Bizarre Adventure"

#Jupiter's Legacy
IMDB_Data %>% filter(primaryTitle == "Jupiter's Legacy")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Jupiterâs Legacy")] <- "Jupiter's Legacy"


# need to fix jurassic world --> periods in and periods out of top ten
test <- Netflix_data_cleaned

Netflix_data_cleaned$Viewerscore[which(Netflix_data_cleaned$Title == 'Jurassic World: Camp Cretac…')] <- 83
Netflix_data_cleaned$total_time_top10[which(Netflix_data_cleaned$Title == "Jurassic World: Camp Cretac…")] <- 17

# get rid of duplicate row
Netflix_data_cleaned <- Netflix_data_cleaned[-c(117), ]

#Jurassic world 
IMDB_Data %>% filter(primaryTitle == "Jurassic World: Camp Cretaceous")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Jurassic World: Camp Cretac…")] <- "Jurassic World: Camp Cretaceous"

#King Arthur: Legend of the Sword
IMDB_Data %>% filter(primaryTitle == "King Arthur: Legend of the Sword")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "King Arthur: Legend of the …")] <- "King Arthur: Legend of the Sword"

#Life in Colour
IMDB_Data %>% filter(primaryTitle == "Life in Colour")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Life in Color with David At…")] <- "Life in Colour"

#Madagascar 3: Europe's Most Wanted
IMDB_Data %>% filter(primaryTitle == "Madagascar 3: Europe's Most Wanted")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Madagascar 3: Europe's Most…")] <- "Madagascar 3: Europe's Most Wanted"

#Masters of the Universe: Revelation
IMDB_Data %>% filter(primaryTitle == "Masters of the Universe: Revelation")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Masters of the Universe: Re…")] <- "Masters of the Universe: Revelation"

#Monsters Inside: The 24 Faces of Billy Milligan
IMDB_Data %>% filter(primaryTitle == "Masters of the Universe: Revelation")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Monsters Inside: The 24 Fac…")] <- "Monsters Inside: The 24 Faces of Billy Milligan"

#MMy Little Pony: A New Generation
IMDB_Data %>% filter(primaryTitle == "My Little Pony: A New Generation")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "My Little Pony: A New Gener…")] <- "My Little Pony: A New Generation"

#Night Stalker: The Hunt for a Serial Killer
IMDB_Data %>% filter(primaryTitle == "Night Stalker: The Hunt for a Serial Killer")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Night Stalker: The Hunt for…")] <- "Night Stalker: The Hunt for a Serial Killer"

#Octonauts: The Ring of Fire
IMDB_Data %>% filter(primaryTitle == "Octonauts: The Ring of Fire")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Octonauts & The Ring of Fire")] <- "Octonauts: The Ring of Fire"

#Resident Evil: Infinite Darkness
IMDB_Data %>% filter(primaryTitle == "Resident Evil: Infinite Darkness")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Resident Evil: Infinite Dar…")] <- "Resident Evil: Infinite Darkness"

# fix single all the way
Netflix_data_cleaned$Firstday_2021[which(Netflix_data_cleaned$Title == "Single All the Way")] <- '2021-12-03'
Netflix_data_cleaned$total_time_top10[which(Netflix_data_cleaned$Title == "Single All the Way")] <- 4
Netflix_data_cleaned$Debut_Rank[which(Netflix_data_cleaned$Title == "Single All the Way")] <- 7
Netflix_data_cleaned$Days_2_peak[which(Netflix_data_cleaned$Title == "Single All the Way")] <- 0
Netflix_data_cleaned$Viewerscore[which(Netflix_data_cleaned$Title == "Single All the Way")] <- 13
Netflix_data_cleaned <- Netflix_data_cleaned[-c(202), ]

#Talladega Nights: The Ballad of Ricky Bobby
IMDB_Data %>% filter(primaryTitle == "Talladega Nights: The Ballad of Ricky Bobby")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Talladega Nights: The Balla…")] <- "Talladega Nights: The Ballad of Ricky Bobby"

#The Christmas Chronicles: Part Two
IMDB_Data %>% filter(primaryTitle == "The Christmas Chronicles: Part Two")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "The Christmas Chronicles 2")] <- "The Christmas Chronicles: Part Two"

#The Last Letter from Your Lover
IMDB_Data %>% filter(primaryTitle == "The Last Letter from Your Lover")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "The Last Letter From Your L…")] <- "The Last Letter from Your Lover"

#The Mitchells vs the Machines
IMDB_Data %>% filter(primaryTitle == "The Mitchells vs the Machines")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "The Mitchells vs. The Machines")] <- "The Mitchells vs the Machines"

#The Princess Switch 3
IMDB_Data %>% filter(primaryTitle == "The Princess Switch 3")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "The Princess Switch 3: Roma…")] <- "The Princess Switch 3"

#The Sons of Sam: A Descent into Darkness
IMDB_Data %>% filter(primaryTitle == "The Sons of Sam: A Descent into Darkness")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "The Sons of Sam: A Descent …")] <- "The Sons of Sam: A Descent into Darkness"

#The Twilight Saga: Breaking Dawn - Part 1
IMDB_Data %>% filter(primaryTitle == "The Twilight Saga: Breaking Dawn - Part 1")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "The Twilight Saga: Breaking…")] <- "The Twilight Saga: Breaking Dawn - Part 1"

#The Witcher: Nightmare of the Wolf
IMDB_Data %>% filter(primaryTitle == "The Witcher: Nightmare of the Wolf")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "The Witcher: Nightmare of t…")] <- "The Witcher: Nightmare of the Wolf"

#The World's Most Amazing Vacation Rentals
IMDB_Data %>% filter(primaryTitle == "The World's Most Amazing Vacation Rentals")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "The Worldâs Most Amazing Va…")] <- "The World's Most Amazing Vacation Rentals"

#There's Someone Inside Your House
IMDB_Data %>% filter(primaryTitle == "There's Someone Inside Your House")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Thereâs Someone Inside Your…")] <- "There's Someone Inside Your House"

#This Is a Robbery: The World's Greatest Art Heist
IMDB_Data %>% filter(primaryTitle == "This Is a Robbery: The World's Greatest Art Heist")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "This is a Robbery: The Worl…")] <- "This Is a Robbery: The World's Greatest Art Heist"

#Tiger King: Murder, Mayhem and Madness
IMDB_Data %>% filter(primaryTitle == "Tiger King")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Tiger King: Murder, Mayhem …")] <- "Tiger King: Murder, Mayhem and Madness"

#To All the Boys: Always and Forever
IMDB_Data %>% filter(primaryTitle == "To All the Boys: Always and Forever")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "To All the Boys Always and …")] <- "To All the Boys: Always and Forever"

#Top Secret UFO Projects: Declassified
IMDB_Data %>% filter(primaryTitle == "Top Secret UFO Projects: Declassified")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Top Secret UFO Projects: De…")] <- "Top Secret UFO Projects: Declassified"

#Trollhunters: Rise of the Titans
IMDB_Data %>% filter(primaryTitle == "Trollhunters: Rise of the Titans")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Trollhunters: Rise of the T…")] <- "Trollhunters: Rise of the Titans"

#Turning Point: 9/11 and the War on Terror
IMDB_Data %>% filter(primaryTitle == "Turning Point: 9/11 and the War on Terror")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Turning Point: 9/11 and the…")] <- "Turning Point: 9/11 and the War on Terror"

#Workin' Moms
IMDB_Data %>% filter(primaryTitle == "Workin' Moms")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Workinâ Moms")] <- "Workin' Moms"

#road to victory 
IMDB_Data %>% filter(primaryTitle == "WWII in Color: Road to Victory")
Netflix_data_cleaned$Title[which(Netflix_data_cleaned$Title == "Workinâ Moms")] <- "Workin' Moms"

write.csv(Netflix_data_cleaned, "fixed_names_data_Netflix.csv", row.names = FALSE) 
