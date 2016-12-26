setwd("~/OneDrive/Development/coursera_data_science/getting_and_cleaning_data/week4")
library(dplyr)

#Question 1 ####

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileurl,"idaho.2006.csv", method="curl")

idaho <- read.csv("idaho.2006.csv",header=TRUE)

idnames <- strsplit(names(idaho),split="wgtp")

idnames[123]

# Question 2 ####

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

download.file(fileurl,"gdp.csv", method="curl")

gdp <- read.csv("gdp.csv", header = FALSE, skip = 5, quote = "\"", na.strings = c("",".."),
                nrows = 190, fill=TRUE, strip.white = TRUE)
gdp$V5 <- as.numeric(gsub(',','', gdp$V5))

mean(gdp$V5)

# Question 3 ####

countryNames <- gdp$V4

grep("*United",countryNames)
grep("United$",countryNames)
countryNames[grep("^United",countryNames)] # Correct answer

# Questions 4 ####

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(fileurl,"educational.csv", method="curl")

educational <- read.csv("educational.csv", header = TRUE)

both <- merge(gdp,educational, by.x = "V1", by.y = "CountryCode")

notes <- both$Special.Notes

length(notes[grep("Fiscal year end: June",notes)])

# Question 5 ####

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

length(sampleTimes[grep("2012",sampleTimes)])
