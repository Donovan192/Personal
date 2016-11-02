###FACEBOOK API/SOCIALMEDIALAB TEST
#Donovan Eyre
#Tutorial URL: http://vosonlab.net/papers/SocialMediaLab/SocialMediaLab_package_tutorial.pdf

#install SML packages and magrittr (which is used in this tutorial)
install.packages("SocialMediaLab")
install.packages("magrittr")

#load packages
library(SocialMediaLab)
library(magrittr)

#create vars for app ID and appSecret from facebook dev page
appID <- "1626767754290262"
appSecret <- "dd54ae9da795a54438dc352b7e2af2c5"

g_bimodal_facebook_donovan_eyre <- Authenticate("Facebook",
        appID = appID, appSecret = appSecret) %>%
        SaveCredential("FBCredential.RDS") %>%
        Collect(pageName="memecream", rangeFrom="2016-10-31",
        rangeTo="2016-11-01", writeToFile=TRUE) %>%
        Create("Bimodal")

myMemeCreamData <- read.csv("2016-10-31_to_2016-11-01_memecream_FacebookData.csv")