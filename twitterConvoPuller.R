## Sports Conversations on Twitter - Creating Bimodal Networks
## Donovan Eyre
## 2017-04-17

# Install relevant packages
#install.packages("twitteR")
#install.packages("httr")
#install.packages("tm")
install.packages("SocialMediaLab")
install.packages("igraph")

# Load 'em
#library(httr)
#library(twitteR)
#library(tm)
library(SocialMediaLab)
library(igraph)


# Setting up authentication

# Enter app keys and tokens
myKey <- "dxW6K6MDLt8krA1GBrsYaGfIW"
mySecret <- "slIDtlo5M4skRduKRnrQqIvsxiQxkihziqSvNbAm3QGhCeVPL3"
myToken <- "802282794026201092-iFNeByUoum2NfBNjgbwe7M92l4k85V1"
myTokenSecret <- "6nfvDsfdPikeETOKjyGxw28jvX9Hn9xi3lSd7qOI5wDg3"

myCred <- Authenticate("twitter", apiKey = myKey, apiSecret = mySecret, accessToken = myToken, accessTokenSecret = myTokenSecret)

# Collecting data

tweets <- Collect(myCred, searchTerm = "#BasketballWives", numTweets = 500, language = "en")

# Removing non-supported characters


# Creating bimodal network

network <- Create(dataSource = tweets, type = "bimodal")
