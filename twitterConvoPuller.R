## Sports Conversations on Twitter - Creating Bimodal Networks
## Donovan Eyre
## 2017-04-17

# Install relevant packages
install.packages("twitteR")
install.packages("httr")
install.packages("devtools")
install.packages("rjson")
install.packages("bit64")
install.packages("genderizeR")

# Load 'em
library(twitteR)
library(httr)
library(devtools)
library(rjson)
library(bit64)
library(genderizeR)
library(plyr)

### Set up authentication

# Enter app keys and tokens
myKey <- "dxW6K6MDLt8krA1GBrsYaGfIW"
mySecret <- "slIDtlo5M4skRduKRnrQqIvsxiQxkihziqSvNbAm3QGhCeVPL3"
myToken <- "802282794026201092-iFNeByUoum2NfBNjgbwe7M92l4k85V1"
myTokenSecret <- "6nfvDsfdPikeETOKjyGxw28jvX9Hn9xi3lSd7qOI5wDg3"

setup_twitter_oauth(myKey, mySecret, myToken, myTokenSecret)

### Collect data

tweets <- searchTwitter("nfldraft", 
                            n = 100000, 
                            lang = "en")

tweets <- twListToDF(tweets) # Change output list to data.frame

# Remove non-alphanumeric characters from tweet text (except "@")
tweets$text <- gsub("[^[:alnum:@]///' ]", "", tweets$text)

### Get corresponding names for @usernames in the DF using usersearch then add them to DF as new col

# Get list of @usernames
screenNames <- unique((tweets$screenName))

# Lookup all usernames and pull user object for each (includes name)
users <- lookupUsers(screenNames)

# Change users object to df
users <- twListToDF(users)

# Remove everything but screenName and name columns
users <- data.frame(users$screenName, users$name)
names(users) <- c("screenName", "name") # Rename columns to remove "user."

# Insert names as a new column in tweets NOT WORKING, RETURNING LESS ROWS THAN tweets DF
tweets <- merge(tweets, users, by = "screenName", all.x = TRUE)

# Remove non-alphanumeric characters
#tweets$name <- gsub("[^[:alnum:]///' ]", "", tweets$name)

# Remove unwanted columns THIS MAY NOT BE WORKING
tweets <- tweets[, -c(15,16,18)]

# Pulling out tweets that are responses or have been responded-to (within the data we have)
convos <- subset(tweets, is.na(tweets$replyToSN) == FALSE 
                 | tweets$screenName %in% tweets$replyToSN == TRUE)

# Predict gender using genderize

genKey <- "5eb5fead910f2944d35f97d1fbea9bce"

# Create genderDB from name column in convos
genderDB <- findGivenNames(convos$name, textPrepare = TRUE, genKey)

# Predict gender and create DF of predictions
nameGenders <- genderize(convos$name, genderDB)

# Merge gender predictions with main df
convos <- cbind(convos, nameGenders)

# Add probabilities to convos df

names(genderDB)[1] <- "givenName" # Change first col name to same as convos
genderDB <- as.data.frame(genderDB) # Change genderDB to df
probs <- genderDB[,c(1,3)] # remove all cols except givenName and probability
convos <- merge(convos, genderDB)

# Remove unused columns
convos$replyToSID <- NULL
convos$replyToUID <- NULL
convos$genderIndicators <- NULL
convos$favorited <- NULL
convos$count <- NULL
convos$retweeted <- NULL

# Sort final df (NEED TO CHANGE POSITIONS NUMBERS BC REMOVED ANOTHER COL
#convos <- convos[,c(3:15, 1, 2)]
#convos <- convos[,c(1:12, 14:15, 13)]

# Make ascending by time
convosFinal <- arrange(convos, created)

### SCRATCH

# Check any limits that have been affected
#x <- getCurRateLimitInfo()
# subset(x, as.numeric(x$limit) - as.numeric(x$remaining) != 0)


# Predict gender and convert output to df
#nameGenders <- gender(tweets$name, years = c(1950, 2005))
#nameGenders <- as.data.frame(nameGenders)

# Subset based on SN that was replied to most (need to add code to find this automatically)
#bhsub <- subset(tweets, tweets$replyToSN == "CMPunk")
