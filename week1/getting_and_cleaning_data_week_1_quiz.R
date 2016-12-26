setwd("~/OneDrive/Development/coursera_data_science/getting_and_cleaning_data/week1")

#Question 1 ####
library(dplyr)

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileurl,"idaho.2006.csv", method="curl")

idaho <- read.csv("idaho.2006.csv",header=TRUE)

idaho <- tbl_df(idaho)

idaho %>%
  filter(VAL==24) %>%
  select(VAL) %>%
  print

# Question 2 ####
# 
# Question 3 ####
fileurl2 <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileurl2,"ngap.xlsx", method="curl")

library(openxlsx)

dat <- read.xlsx("ngap.xlsx", rows=18:23, cols=7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

# Question 4 ####

library(XML)
fileurl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileurl3,"ravens.xml", method="curl")
rest <- xmlParse("ravens.xml")
# rootNode <- xmlRoot(rest) # rootnode is the entire document
# xmlName(rootNode)
# rootNode[[1]] # access the first element
# rootNode[[1]][[1]] # access the first subcomponent of the first element
# xpathSApply(rootNode,xmlValue)
# xpathSApply(rootNode,"//price",xmlValue)
zips <- xpathSApply(rest,"/response/row/row/zipcode",xmlValue) #extracts list items with class=score
sum(zips == 21231)

# Question 5 ####

library(data.table)
fileurl4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileurl4,"fss.csv", method="curl")
DT <- fread("fss.csv")

#Which of these approaches is the fastest for doing the calculations?

mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)

sapply(split(DT$pwgtp15,DT$SEX),mean)

DT[,mean(pwgtp15),by=SEX] # this is the correct one

tapply(DT$pwgtp15,DT$SEX,mean)

mean(DT$pwgtp15,by=DT$SEX) # does not give a mean by gender

rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2] # gives an error message
