setwd("~/OneDrive/Development/coursera_data_science/getting_and_cleaning_data/week3")

#Question 1 ####
library(dplyr)

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileurl,"idaho.2006.csv", method="curl")

idaho <- read.csv("idaho.2006.csv",header=TRUE)

idaho <- tbl_df(idaho)

agricultureLogical <- with(idaho, ACR == 3 & AGS == 6)

which(agricultureLogical)

# Question 2 #####

library(jpeg)

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"

download.file(fileurl,"jeff.jpg", method="curl")

jeff <- readJPEG("jeff.jpg",native = TRUE)

quantile(jeff,probs = c(0.3,0.8))

# Question 3 ####

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

download.file(fileurl,"gdp.csv", method="curl")

gdp <- read.csv("gdp.csv", header = FALSE, skip = 5, quote = "\"", na.strings = c("",".."),
                nrows = 190, fill=TRUE, strip.white = TRUE)
gdp$V5 <- as.numeric(gsub(',','', gdp$V5))

names(gdp) <- c("abbr","ranking","blank","country","gdp","v1","v2","v3","v4","v5")

gdp <- select(gdp, abbr,ranking,country,gdp)

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

educational <- read.csv(fileurl, header = TRUE)

both <- merge(gdp, educational, by.x="abbr",by.y="CountryCode")

dim(both)

both %>%
  arrange(desc(ranking)) %>%
  print

# Question 4 ####

both$ranking <- as.numeric(both$ranking)

tapply(both$ranking,both$Income.Group,mean)

# Question 5 ####

both %>%
  select(ranking, Income.Group) %>%
  filter(Income.Group == "Lower middle income", ranking <= 38) %>%
  arrange(ranking) %>%
  print
