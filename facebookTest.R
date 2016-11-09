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

#pull star wars bimodal data
g_bimodal_facebook_star_wars <- Authenticate("Facebook",
        appID = appID, appSecret = appSecret) %>%
        SaveCredential("FBCredential.RDS") %>%
        Collect(pageName="StarWars", rangeFrom="2015-03-01",
        rangeTo="2015-03-02", writeToFile=TRUE) %>%
        Create("Bimodal")
#read in data to df
myStarWarsData <- read.csv("2015-03-01_to_2015-03-02_StarWars_FacebookData.csv")

#pull star trek bimodal data
g_bimodal_facebook_star_trek <- LoadCredential("FBCredential.RDS") %>%
        Collect(pageName="StarTrek", rangeFrom="2015-03-01",
                rangeTo="2015-03-02", writeToFile=TRUE) %>%
        Create("Bimodal")
# read in the data to a dataframe
myStarTrekData <- read.csv("2015-03-01_to_2015-03-02_StarTrek_FacebookData.csv")







