# Coursera Getting and Cleaning Data Course Project

Getting and Cleaning Data Course Project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Create one R script called run_analysis.R that does the following:

### Read in test and train data sets using read.table

tstDat <- read.table("./Dataset/test/X_test.txt", header = FALSE)
tstDatAct <- read.table("./Dataset/test/y_test.txt", header = FALSE)
tstDatSub <- read.table("./Dataset/test/subject_test.txt", header = FALSE)
trnDat <- read.table("./Dataset/train/X_train.txt", header = FALSE)
trnDatAct <- read.table("./Dataset/train/y_train.txt", header = FALSE)
trnDatSub <- read.table("./Dataset/train/subject_train.txt", header = FALSE)

### Read in features.txt file containing index of file names
features <- read.table("./Dataset/features.txt", header = FALSE)

### Read in activity_labels.txt file containing index if descriptive activity names
activities <- read.table("./Dataset/activity_labels.txt", header = FALSE)

### Uses descriptive activity names to name the activities in the data set.
### Replace activity numbers with activity names from activity_labels.txt.
trnDatAct <- merge(trnDatAct, activities)
trnDatAct <- select(trnDatAct, -V1)
tstDatAct <- merge(tstDatAct, activities)
tstDatAct <- select(tstDatAct, -V1)

### Merge Test and Training data into one data set.
### Add the subject and activity columns to the test and train datasets.
### Combine the test and train datasets.
tstDatComb <- cbind(tstDatSub, tstDatAct, tstDat)
trnDatComb <- cbind(trnDatSub, trnDatAct, trnDat)
combDat <- rbind(tstDatComb, trnDatComb)

### Appropriately labels the data set with descriptive variable names.
### Apply variable names from features.txt file and add names for activity and subjects columns. 
### Clean up column names by removing invalid characters: parenthesis, commas, etc.
names(combDat) <- c("subjects", "activity", as.character(features[, 2]))
names(combDat) <- gsub('\\(|\\)|\\,', "", names(combDat))
names(combDat) <- gsub('\\-', "_", names(combDat))
names(combDat) <- gsub("tBody", "timeBody", names(combDat))
names(combDat) <- gsub("fBody", "frequencyBody", names(combDat))
names(combDat) <- gsub("tGravity", "timeGravity", names(combDat))
names(combDat) <- gsub("fGravity", "frequencyGravity", names(combDat))
names(combDat) <- gsub("Acc", "Accelerometer", names(combDat))
names(combDat) <- gsub("Mag", "Magnitude", names(combDat))
names(combDat) <- gsub("BodyBody", "Body", names(combDat))
names(combDat) <- make.names(names=names(combDat), unique=TRUE, allow_ = TRUE)


### Extracts only the measurements on the mean and standard deviation for each measurement.
### Convert to tbl_df
### User dplyr select command to select mean, std, subjects, and activity columns
combDat_tbl <- tbl_df(combDat)
combDat_sel <- select(combDat_tbl, subjects, activity, contains("mean"), contains("std"))

### From the combined data set, creates a second, independent tidy data 
### Set with the average of each variable for each activity and each subject.
### Create the tidy data set
library(reshape2)
meltedDat <- melt(combDat_sel, id=c("subjects","activity"))
tidyDat <- dcast(meltedDat, subjects+activity ~ variable, mean)

Write tidy data to a file
write.table(tidyDat, file = "./tidyDat.txt", row.names = FALSE)


