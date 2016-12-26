setwd("~/OneDrive/Development/coursera_data_science/getting_and_cleaning_data/week2")

# Question 1 ####

library(httr)
library(httpuv)
library(jsonlite)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.

myapp <- oauth_app("github",
                   key = "96cc66823afca3eb83ce",
                   secret = "a1ddeaf2f306cef4dbca11ddbaee6d7100714919")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
repo <- "datasharing"
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
result2 <- content(req)

df <- fromJSON(toJSON(result2))
subset(df,name=="datasharing", select=c("name","created_at"))

# Question 2 and 3 ####

library(sqldf)

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

download.file(fileurl,"acs.csv", method="curl")

acs <- read.csv("acs.csv", header = TRUE)

# sqldf("select * from acs")
# sqldf("select * from acs where AGEP < 50 and pwgtp1")
sqldf("select pwgtp1 from acs where AGEP < 50")
# sqldf("select pwgtp1 from acs")


sqldf("select distinct AGEP from acs")
# sqldf("select distinct pwgtp1 from acs")

# Question 4 ####

# library(XML)
library(RCurl)

webpage <- getURL("http://biostat.jhsph.edu/~jleek/contact.html")
webpage <- readLines(tc <- textConnection(webpage))
close(tc)

nchar(webpage[10])
nchar(webpage[20])
nchar(webpage[30])
nchar(webpage[100])

# Question 4 ####

df <- read.fwf(file=url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"),
                        skip=4, widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4))
sum(df$V4)