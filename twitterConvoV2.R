## Twitter Convo Puller v2
## Donovan Eyre
## 2017-04-17

# Install relevant packages
install.packages("rtweet")
install.packages("httr")
install.packages("devtools")
install.packages("rjson")
install.packages("bit64")
install.packages("genderizeR")
install.packages("plyr")

# Load 'em
library(rtweet)
library(httr)
library(devtools)
library(rjson)
library(bit64)
library(genderizeR)
library(plyr)

### Set up authentication

# Enter app keys and tokens
myKey <- "zodrFtGnBaGHcCvx67NqasA6U"
mySecret <- "ba1X9lD4l7xWBTZafWDqrX05bdEFBFsLUfSD6RK4E4ZkaP7ohX"

create_token(app = "DonovanR", consumer_key = myKey, consumer_secret = mySecret, cache = T)

### Collect data

tweets <- search_tweets("nbadraft", n = 10000, parse = T, lang = "en", include_rts = FALSE,  tweet_mode = "extended")

# Remove non-alphanumeric characters from tweet text (except "@")
tweets$text <- gsub("[^[:alnum:@]///' ]", "", tweets$text)

### Get corresponding names for @usernames in the DF using usersearch then add them to DF as new col

# Get list of @usernames
screenNames <- unique((tweets$screen_name))

# Lookup all usernames and pull user object for each (includes name)
users <- lookup_users(screenNames)

# Remove everything but screenName and name columns
users <- data.frame(users$screen_name, users$name)
names(users) <- c("screen_name", "name") # Rename columns to remove "user."

# Insert names as a new column in tweets NOT WORKING, RETURNING LESS ROWS THAN tweets DF
tweets <- merge(tweets, users, by = "screen_name", all.x = TRUE)

# Remove nonalpha characters
#tweets$name <- gsub("[^[:alnum:]///' ]", "", tweets$name)

# Remove unwanted columns THIS MAY NOT BE WORKING
#tweets <- tweets[, -c(15,16,18)]

# Pulling out tweets that are responses or have been responded-to (within the data we have)
convos <- subset(tweets, is.na(tweets$in_reply_to_status_screen_name) == FALSE 
                 | tweets$screen_name %in% tweets$in_reply_to_status_status_id == TRUE
                 | is.na(tweets$mentions_screen_name) == FALSE
                 | tweets$screen_name %in% tweets$mentions_screen_name == TRUE)

# Predict gender using genderize

genKey <- "5eb5fead910f2944d35f97d1fbea9bce"

# Create genderDB from name column in convos
genderDB <- findGivenNames(convos$name, textPrepare = TRUE, genKey)
#genderDB2 <- genderDB
#colnames(genderDB2)[1] <- "givenName"

# Predict gender and create DF of predictions
nameGenders <- genderize(convos$name, genderDB)
names(nameGenders)[1] <- "nametext"

# Merge gender predictions with main df
convos <- cbind(convos, nameGenders)

# Add probabilities to convos df

names(genderDB)[1] <- "givenName" # Change first col name to same as convos
genderDB <- as.data.frame(genderDB) # Change genderDB to df
probs <- genderDB[,c(1,3)] # remove all cols except givenName and probability
convos <- merge(convos, probs)

# Remove second "text" col (which is actually just name again)
#convos[,37] <- NULL

# Create new df of only relevant columns
convosSubset <- subset(convos, select = c(name,
                                          screen_name, 
                                          created_at,
                                          text,
                                          gender,
                                          probability,
                                          givenName,
                                          is_retweet,
                                          in_reply_to_status_screen_name,
                                          source,
                                          mentions_screen_name,
                                          hashtags)
                       )

# Make ascending by time
convosFinal <- arrange(convosSubset, created_at)

### SCRATCH

# Check any limits that have been affected
#x <- getCurRateLimitInfo()
# subset(x, as.numeric(x$limit) - as.numeric(x$remaining) != 0)