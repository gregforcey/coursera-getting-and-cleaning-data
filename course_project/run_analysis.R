setwd("~/OneDrive/Development/coursera_data_science/getting_and_cleaning_data/course_project")

# Download and extract files ####

# fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# 
# download.file(fileurl,"temp.zip", method="curl")
# 
# unzip("temp.zip")
# unlink("temp.zip")

# Read in all the data and merge together ####

library(tidyverse) # Load the tidyverse

# Read in Test and Train data using functions from the readr package

subject.test <- read_table("UCI HAR Dataset/test/subject_test.txt",
                              col_names = FALSE)
x.test <- read_table("UCI HAR Dataset/test/X_test.txt",
                              col_names = FALSE)
y.test <- read_table("UCI HAR Dataset/test/y_test.txt",
                     col_names = FALSE)

subject.train <- read_table("UCI HAR Dataset/train/subject_train.txt",
                           col_names = FALSE)
x.train <- read_table("UCI HAR Dataset/train/X_train.txt",
                     col_names = FALSE)
y.train <- read_table("UCI HAR Dataset/train/y_train.txt",
                     col_names = FALSE)

features <- read_delim("UCI HAR Dataset/features.txt",
                       col_names = FALSE, delim = " ")

activities <- read_table("UCI HAR Dataset/activity_labels.txt",
                         col_names = FALSE)

# Assign the variable names to the datasets and make sure feature names are unique

names(subject.test) <- "subject"
names(x.test) <- make.names(features[[2]], unique = TRUE, allow_ = TRUE)
names(y.test) <- "act.num"

names(subject.train) <- "subject"
names(x.train) <- make.names(features[[2]], unique = TRUE, allow_ = TRUE)
names(y.train) <- "act.num"

names(activities) <- c("act.num","activity")

# Left Join the activity names with the activity ids
# Keep all the ids because that was the left data set

y.test.act <- left_join(y.test, activities, 
                        by="act.num")

y.train.act <- left_join(y.train, activities, 
                         by="act.num")

# Merge all the test and train data together and create a groups variable to 
# indicate test or train data 

all.test <- bind_cols(subject.test,y.test.act,x.test)
all.train <- bind_cols(subject.train,y.train.act,x.train)
all.data <- bind_rows("test" = all.test, "train" = all.train, .id = "groups")

# Remove all data frames except all.data from memory

rm(list=setdiff(ls(), "all.data"))

# Extract only the mean and std measurements from all data ####
# Calculate the means by subject and activity
# Gather all the column names into one column calld measure
# Separate the measure column in to prefix, statistic, and axis
# Separate the prefix column into a time/frequency columna and mesurement type
# Convert the appropriate variables to factors
# Write the result to a tidy csv file

tidy.data <- 
all.data %>%
  select(groups,subject,activity,contains(".mean."),contains(".std.")) %>%
  group_by(subject,activity) %>%
  summarise_each(funs(mean),-groups) %>%
  gather(measure, average, -subject,-activity) %>%
  separate(measure, c("prefix","statistic","axis")) %>%
  separate(prefix, c("timefreq","measurement"),sep=1) %>%
  mutate_at("-average", as.factor)

write.table(tidy.data,"tidy.txt",append = FALSE, row.names = FALSE)
  
str(data.frame(tidy.data))
