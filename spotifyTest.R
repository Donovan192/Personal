## HTTR Connect to Spotify Test
packs <- c("httr", "magrittr", "devtools", "Rspotify", "dplyr")

sapply(packs, library, character.only = TRUE) # This may not work but not priority

# Authenticate
appID <- "rTestApp"
clientID <- "de0815c4b23541b8af112b5f2d952606"
clientSec <- "1e6fb8e631a444c5ae2f65041b7e76d4"

my_oauth <- spotifyOAuth(appID, clientID, clientSec)

# Pull user info
law <- getUser(user_id = "hernameislaw", token = my_oauth)
dono <- getUser(user_id = "Underworld", token = my_oauth)

# Get song info (e.g. danceability, energy, key, etc. pretty cool)
getFeatures("7xQYVjs4wZNdCwO0EeAWMC", token = my_oauth)