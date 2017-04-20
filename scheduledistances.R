# load needed libraries
# pay attention to the order these libraries get loaded; 
# several of them mask objects from each other
library(XML)
library(httr)
library(data.table)
library(rvest)
library(lubridate)
library(stringr) 
                 
# basketball URL elements
urlSeasons <- 2005:2017
urlMonths <- c("october", "november", "december", 
               "january", "february", "march", "april")
urlBeginning <- "http://www.basketball-reference.com/leagues/NBA_"
urlMid <- "_games-"
urlEnd <- ".html"

# initialize loop counters and assemble URLs
i <- 1
j <- 1
bball.urls <-data.frame()
for (i in seq(urlSeasons)) {
      for (j in seq(urlMonths)) {
            bball.urls <- rbind(bball.urls, 
                                print(paste(urlBeginning, 
                                            urlSeasons[i], 
                                            urlMid, 
                                            urlMonths[j], 
                                            urlEnd, 
                                            sep = "")), 
                                stringsAsFactors = FALSE)
      }
}
colnames(bball.urls) <- "SeasonURL"

# extract data using XPath and the rvest package:

i <- 1
temp <- list()
for(i in seq(bball.urls$SeasonURL)) {
  try({
    temp[[length(temp) + 1]] <- bball.urls[i, ] %>%
      read_html() %>% 
      html_nodes(xpath ='//*[@id="schedule"]') %>%
      html_table
  })
}

# bind scraped data to a single data frame
i <- 1
matchups <- data.frame()
for (i in seq(temp)) {
  matchups <- rbind(matchups, temp[[i]][[1]])  
}

# convert date & time columns
matchups$Date <- parse_date_time(matchups$Date, "a, b! d! Y!")
matchups$`Start (ET)` <- parse_date_time(matchups$`Start (ET)`, "H!:M! Op!")

# at this point I got annoyed with the 
# playoffs rows and since I'm much more familiar 
# with Excel I gave up and cleaned the data there

write.csv(matchups, "matchups.csv")

# after cleaning the data and removing playoffs rows, I 
# imported the data and continued

matchups <- read.csv("matchups.csv")


# pull airport codes from csv and generate url elements
air.codes <- read.csv("airportcodes.csv", stringsAsFactors = FALSE)
air.urlBeginning <- "http://www.travelmath.com/flying-time/from/"
air.urlMid <- "/to/"

# initialize loop counters and generate airport distance URLs
i = 1
j = 1
air.urls <- data.frame()
for (i in seq(air.codes$Airport.Code)) {
      for (j in seq(air.codes$Airport.Code)) {
            air.urls <- rbind(air.urls, 
                              print(
                                paste(air.urlBeginning, 
                                          air.codes$Airport.Code[i],
                                          air.urlMid,
                                          air.codes$Airport.Code[j],
                                          sep = "")),
                              stringsAsFactors = FALSE)
            }
}

# generate loop counter and pull URL node using relevant XPath string
i <- 1
air.distanceNode <- list()
for (i in 1:1225) {
      air.distanceNode[[length(air.distanceNode) + 1]] <- air.urls[i, ] %>% 
            read_html() %>%
            html_nodes(xpath = '//*[@id="flyingtime"]')
}

# split node and extract time
i <- 1
x <- 1
air.distance <- data.frame()
      for (i in 1:1225) {
      x <- str_split_fixed(
            str_split_fixed(air.distanceNode[[i]], ">", n = 3)[, 2],
            "<", n = 3)[1, 1]
      air.distance[[length(air.distance) + 1]] <- x # everything up to this line works; this line is broken
      i + 1
      }
air.distance <- air.distance[2:1226]

# column-bind urls to distances
air.times <- cbind(air.urls, air.distance)
colnames(air.times) <- c("url", "flight.time")

# I then exported air.times and cleaned up the time column in excel, 
# then reimported it into r as air.times

# split url column, extract from and to destinations, bind to air.times
temp <- data.frame()
temp <- as.data.frame(
      str_split_fixed(
            str_split_fixed(
                  air.times$url, 
                  "/from/", 2)[, 2], 
            "/to/", 2), stringsAsFactors = FALSE)
colnames(temp) <- c("from", "to")
air.times <- cbind(air.times, temp)
rm(temp)

# matched up teams, cities, and airport codes in Excel
# read the results into R
teamcodes <- read.csv("teamcodes.csv")