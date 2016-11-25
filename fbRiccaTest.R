###FACEBOOK API/SOCIALMEDIALAB TEST
#Donovan Eyre
#Tutorial URL: http://vosonlab.net/papers/SocialMediaLab/SocialMediaLab_package_tutorial.pdf

#install SML packages and magrittr (which is used in this tutorial)
install.packages("httr")
if (!"devtools" %in% installed.packages()) install.packages("devtools")
require(devtools)
devtools::install_version("httr", version="0.6.0", repos="http://cran.us.r-project.org")
if (!"SocialMediaLab" %in% installed.packages()) {
        devtools::install_github("voson-lab/SocialMediaLab/SocialMediaLab")
}
require(SocialMediaLab)
if (!"magrittr" %in% installed.packages()) install.packages("magrittr")
require(magrittr)
if (!"igraph" %in% installed.packages()) install.packages("igraph")
require(igraph)
if (!"gender" %in% installed.packages()) devtools::install_github("ropensci/genderdata")
require(gender)

#load packages
library(SocialMediaLab)
library(magrittr)
library(devtools)
library(igraph)
library(gender)

#create vars for app ID and appSecret from facebook dev page
appID <- "1626767754290262"
appSecret <- "dd54ae9da795a54438dc352b7e2af2c5"

g_bimodal_facebook_ricca <- Authenticate("Facebook",
                                         appID = appID, appSecret = appSecret) %>%
        SaveCredential("FBCredential.RDS") %>%
        Collect(pageName="riccavitamusic", rangeFrom="2016-07-01",
                rangeTo="2016-11-01", writeToFile=TRUE) %>%
        Create("Bimodal")

myRiccaVitaData <- read.csv("2016-07-01_to_2016-11-01_riccavitamusic_FacebookData.csv")