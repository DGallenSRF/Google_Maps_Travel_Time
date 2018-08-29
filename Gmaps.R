library(gmapsdistance)
library(tidyverse)


setwd("C:/Users/dgallen/Desktop/R/GMaps")

dat <- read.csv('GoogleTTAPI_SampleData.csv')

### Turn the origin and destination lat longs into one string separated by '+'
### the %>% is from the magrittr package loaded with the tidyverser general package
dat <- dat %>%
  mutate(Origin = paste(oLat,'+',oLong,sep=''),
         Dest = paste(dLat,'+',dLong,sep=''))

###this is the API that the user will recieve from the google account
API_Key <- 'AIzaSyACL7GqgMCvgWVgoL6IeHivYLSaWNZNyWA'
set.api.key(API_Key)


### loop through the table and extract the time component of each result

dist <- list()
results <- 
  for(i in 1:length(dat$Origin)){
    result <- gmapsdistance(dat$Origin[i], dat$Dest[i],mode = 'driving')
    dist[i] <- result$'Time'
  }
unlist(dist)

dat$Time_sec <- unlist(dist)

write.csv(dat,'GoogleTTAPI_SampleData_Time.csv')
