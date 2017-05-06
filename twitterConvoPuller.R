## Sports Conversations on Twitter - Creating Bimodal Networks
## Donovan Eyre
## 2017-04-17

# Install relevant packages
install.packages("twitteR")
install.packages("httr")
install.packages("devtools")
install.packages("rjson")
install.packages("bit64")
install.packages("gender")

# Load 'em
library(twitteR)
library(httr)
library(devtools)
library(rjson)
library(bit64)
library(gender)
library(plyr)

### Set up authentication

# Enter app keys and tokens
myKey <- "dxW6K6MDLt8krA1GBrsYaGfIW"
mySecret <- "slIDtlo5M4skRduKRnrQqIvsxiQxkihziqSvNbAm3QGhCeVPL3"
myToken <- "802282794026201092-iFNeByUoum2NfBNjgbwe7M92l4k85V1"
myTokenSecret <- "6nfvDsfdPikeETOKjyGxw28jvX9Hn9xi3lSd7qOI5wDg3"

setup_twitter_oauth(myKey, mySecret, myToken, myTokenSecret)

### Collect data

blackhawks <- searchTwitter("Blackhawks", 1000, "en", "2017-04-20", "2017-04-30")

blackhawks <- twListToDF(blackhawks) # Change output list to data.frame

# Remove non-alphanumeric characters (except "@")
blackhawks$text <- gsub("[^[:alnum:@]///' ]", "", blackhawks$text)

# Subset based on SN that was replied to most (need to add code to find this automatically)
bhsub <- subset(blackhawks, blackhawks$replyToSN == "CMPunk")


### Get corresponding names for @usernames in the DF using usersearch then add them to DF as new col

# Get list of @usernames
screenNames <- unique((blackhawks$screenName))

# Lookup all usernames and pull user object for each (includes name)
users <- lookupUsers(screenNames)

# Change users object to df
users <- twListToDF(users)

# Remove everything but screenName and name columns
users <- data.frame(users$screenName, users$name)
names(users) <- c("screenName", "name") # Rename columns to remove "user."

# Insert names as a new column in blackhawks NOT WORKING, RETURNING LESS ROWS THAN BLACKHAWKS DF
blackhawks <- merge(blackhawks, users, by = "screenName")

# Pull only first word before whitespace from username
sub(" .*", "", blackhawks$name)

# Predict gender

### SCRATCH

# Check any limits that have been affected
#subset(x, as.numeric(x$limit) - as.numeric(x$remaining) != 0)



