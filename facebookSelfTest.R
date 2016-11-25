##facebookSelfTest
#Can pull own data and whatever I can see from friends, let's
#check this out!

install.packages("Rfacebook")
install.packages("httpuv")
library(Rfacebook)
library(httpuv)
library(RColorBrewer)

#token <- "EAACEdEose0cBAAeyGaaaHk0Hg0Uwu0fCfOTcTIyZCmqfNSRS8Cvu5CoqyWa5aNWvZBT4APcOpgGmIGSRjds85nRulqm0UlvDZBZBvltKNQiVwZBTTtjJNe86yKxRINsqo1blYN9yIUQCwwhiPTXYdDIzZBZBaxhtd6hh7EJfWrQJgZDZD"

#me <- getUsers("me", token = token)

appID <- "1626767754290262"
appSecret <- "dd54ae9da795a54438dc352b7e2af2c5"

#fbOAuth(app_id, app_secret, extended_permissions = TRUE)
fb_oauth=fbOAuth(appID, appSecret, extended_permissions = TRUE)
#fb_oauth <- fbOAuth(app_id="123456789", app_secret="1A2B3C4D")
save(fb_oauth, file="fb_oauth")

