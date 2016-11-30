## Coursera Getting and Cleaning Data Course Project
setwd('C:/Users/Tinashe/rstuff/webscaping')

#install.packages("dplyr")
#install.packages("reshape2")
library(dplyr)
library(reshape2)

# run_analysis.r File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for 
#    each activity and each subject. 


# read in file,download,create dir and folder
# 1. Merge the training and the test sets to create one data set.

filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Reading trainings tables:
# checking the data:

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
#head(x_train, n=10)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
#head(y_train, n=10)
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
#head(subject_train, n=10)

# Reading testing tables:
# checking the data:
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
#head(x_test, n=10)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
#head(y_test, n=10)
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
#head(subject_test, n=10)

# Reading feature vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')
#head(features, n=10)


# Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')
#head(activityLabels, n=10)


# Assigin column names to the data imported above

colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

#Data merging to one file

merging_train <- cbind(y_train, subject_train, x_train)
merging_test <- cbind(y_test, subject_test, x_test)
all_merged_data <- rbind(merging_train, merging_test)

#head(all_merged_data, 10)
#tail(all_merged_data,10)


# pulling desired column names from the all merged data

colNames <- colnames(all_merged_data)


# 2. Extract only the measurements on the mean and standard deviation for each measurement.
mean_and_standard_deviation <- (grepl("activityId" , colNames) | 
                                grepl("subjectId" , colNames) | 
                                grepl("mean.." , colNames) | 
                                grepl("std.." , colNames) 
                                )
# getting a subset of mean and standard_deviation
get_mean_and_standard_deviation <- all_merged_data[ , mean_and_standard_deviation == TRUE]

# 4. Appropriately label the data set with descriptive activity names. 
labelWithActivityNames <- merge(get_mean_and_standard_deviation, activityLabels,by='activityId',
                                                                  all.x=TRUE)
#5. Creates a second, independent tidy data set with the average of each variable for 
#    each activity and each subject.

second_TidySet <- aggregate(. ~subjectId + activityId, labelWithActivityNames, mean)%>% 
                   group_by(subjectId,activityId)

#write data to a text file
write.table(second_TidySet, "second_TidySet.txt", row.name=FALSE)
