##Twitter API/twitteR Test
#Donovan Eyre

# Install relevant packages
install.packages("twitteR")
install.packages("httr")
install.packages("wordcloud")
install.packages("tm")

# Load 'em
library(httr)
library(twitteR)
library(wordcloud)
library(tm)

#Setting up oauth

#enter app keys and tokens
consumerKey <- "dxW6K6MDLt8krA1GBrsYaGfIW"
consumerSecret <- "slIDtlo5M4skRduKRnrQqIvsxiQxkihziqSvNbAm3QGhCeVPL3"
accessToken <- "802282794026201092-iFNeByUoum2NfBNjgbwe7M92l4k85V1"
accessTokenSecret <- "6nfvDsfdPikeETOKjyGxw28jvX9Hn9xi3lSd7qOI5wDg3"

#intiate oauth
cred <- setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)

#Test pulling latest 10 tweet from Obama (@POTUS)
userTimeline("POTUS", 10)

# Tweet source chart from tutorial - adapted for user instead of trend
library(ggplot2)
# Get David's timeline (API can pull from max last two weeks I think)
# We will need to set up some kind of recurring pull in the future to keep
# Clients' info updated
testTweets <- userTimeline('howdeyreyou', n = 100)
sources <- sapply(charkTweets, function(x) x$getStatusSource())
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


# Searching for hashtag mentions in Nashville

# Use the searchTwitter funtion to find a word in five miles of the lat/long of Nash

nashSearch <- function(term) { 
        searchTwitter(term, 
              # NOTE no spaces in geocode arg
              geocode = "36.1627,-86.7816,5mi",
              n = 500, 
              retryOnRateLimit = 1)
}

# Make a wordcloud from a user's recent tweets

# Pull recent tweets (may not actually be 100 due to API limitation)
charkTweets <- userTimeline('howdeyreyou', n = 100)

# Separate text and save it
charkText <- sapply(charkTweets, function(x) x$getText())

# Create corpus (what is this exactly? look into it)
charkText_corpus <- Corpus(VectorSource(charkText))

# Cleanup text (remove stopwords, capitalizations, punctuation)
charkText_corpus <- tm_map(charkText_corpus,
                   content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte')),
                   mc.cores=1)
charkText_corpus <- tm_map(charkText_corpus, content_transformer(tolower), mc.cores=1)
charkText_corpus <- tm_map(charkText_corpus, removePunctuation, mc.cores=1)
charkText_corpus <- tm_map(charkText_corpus, function(x)removeWords(x,stopwords()), mc.cores=1)

#Generate that wordcloud!
wordcloud(charkText_corpus, min.freq = 100, max.words = 200)
