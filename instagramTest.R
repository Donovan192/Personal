#install.packages("SocialMediaLab")
#install.packages("instaR")

# Load packages
library(instaR)
library(SocialMediaLab)

# Set up OAuth

# Create ID and Secret
instaID <- "5f70b5069cb44dfcbba5e0736cd8461d"
        
instaSecret <- "617ea6e1182c4d5da12c68de4a784246"

myInstaOAuth <- instaOAuth(instaID, instaSecret, scope = c("basic", "public_content"))

# Create token object
instaAccessToken <- myInstaOAuth$credentials$access_token

# Save OAuth info on disk for later use
save(myInstaOAuth, file = "myInstaOAuth")
load("myInstaOAuth")