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

# Tweet source chart from tutorial - adapted for user instead of trend
library(ggplot2)
# Get David's timeline (API can pull from max last two weeks I think)
momtweets <- userTimeline('realDonaldTrump', n = 100)
sources <- sapply(momtweets, function(x) x$getStatusSource())
sources <- gsub("</a>", "", sources)
sources <- strsplit(sources, ">")
sources <- sapply(sources, function(x) ifelse(length(x) > 1, x[2], x[1]))
source_table = table(sources)
# Commented out these lines to stop grouping lesser used sources as "other"
#filtered_sources = names(source_table[source_table < quantile(source_table, 0.9)])
#sources[sources %in% filtered_sources] = "other"
source_df = as.data.frame(sources)
ggplot(source_df, aes(sources)) + geom_bar() + coord_flip()
# Had to manually click plot tab to view output;
# Apparently David only tweets from iPhone


