
## Checking files
if(!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")){
  print("Downloading necessary files...")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile ="getdata-projectfiles-UCI HAR Dataset.zip", method = "curl")
}

if(!file.exists("UCI HAR Dataset")) {
  print("Unzipping files...")
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

## Set correct precision
options(digits=12)

## Reading files

## Ignore first two columns and then load 561 double values
colClasses = c(NULL, NULL, rep("double", 561))

print("Reading files...")
testFile <- read.table("UCI HAR Dataset/test/X_test.txt", colClasses=colClasses)
activityTestFile <- read.table("UCI HAR Dataset/test/y_test.txt")
subjectTestFile <- read.table("UCI HAR Dataset/test/subject_test.txt")

trainFile <- read.table("UCI HAR Dataset/train/X_train.txt", colClasses=colClasses)
activityTrainFile <- read.table("UCI HAR Dataset/train/y_train.txt")
subjectTrainFile <- read.table("UCI HAR Dataset/train/subject_train.txt")

## Adding details of subject and activity

testFile <- cbind(activityTestFile, testFile)
testFile <- cbind(subjectTestFile, testFile)

trainFile <- cbind(activityTrainFile, trainFile)
trainFile <- cbind(subjectTrainFile, trainFile)

## Merges all the data

## 1 - Merges the training and the test sets to create one data set.

mergedData <- rbind(testFile, trainFile)

## 4 - Appropriately labels the data set with descriptive variable names.

featuresFile <- read.table("UCI HAR Dataset/features.txt")
colnames(mergedData) <- c("Subject", "Activity", as.vector(featuresFile[,2]))

## 2 - Extracts only the measurements on the mean and standard deviation 
## for each measurement. 

meanSTDData <- mergedData[,which(grepl("mean()", names(mergedData), fixed=TRUE) |
                            grepl("std()", names(mergedData), fixed=TRUE) |
                            grepl("Subject", names(mergedData), fixed=TRUE) |
                            grepl("Activity", names(mergedData), fixed=TRUE))]

## 3 - Uses descriptive activity names to name the activities in the data set

meanSTDData$Activity[meanSTDData$Activity == 1] <- "WALKING"
meanSTDData$Activity[meanSTDData$Activity == 2] <- "WALKING_UPSTAIRS"
meanSTDData$Activity[meanSTDData$Activity == 3] <- "WALKING_DOWNSTAIRS"
meanSTDData$Activity[meanSTDData$Activity == 4] <- "SITTING"
meanSTDData$Activity[meanSTDData$Activity == 5] <- "STANDING"
meanSTDData$Activity[meanSTDData$Activity == 6] <- "LAYING"

## 5 - From the data set in step 4, creates a second, independent tidy data set with
## the average of each variable for each activity and each subject.
library(dplyr)

summarisedData <- as.data.frame(meanSTDData %>% group_by(Subject, Activity) %>% summarise_each(funs(mean)))

summarisedData