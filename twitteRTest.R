##Twitter API/twitteR Test
#Donovan Eyre

#install and load relevant packages
install.packages("twitteR")
library(twitteR)
#NOTE ROAuth phased out and replaced with httr, apparently
#install.packages("ROAuth")
#library(ROAuth)
install.packages("httr")
library(httr)

#Setting up oauth

#enter app keys and tokens
consumerKey <- "dxW6K6MDLt8krA1GBrsYaGfIW"
consumerSecret <- "slIDtlo5M4skRduKRnrQqIvsxiQxkihziqSvNbAm3QGhCeVPL3"
accessToken <- "802282794026201092-iFNeByUoum2NfBNjgbwe7M92l4k85V1"
accessTokenSecret <- "6nfvDsfdPikeETOKjyGxw28jvX9Hn9xi3lSd7qOI5wDg3"

#intiate oauth
setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)

#Test pulling latest 10 tweet from Obama (@POTUS)
userTimeline("POTUS", 10)