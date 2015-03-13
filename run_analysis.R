require(data.table)
require(dplyr)

## The R script called run_analysis.R does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation 
##    for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data 
## 6. set with the average of each variable for each activity and each subject.

##---------------------------------------------------------------------------##
## 0. The script assumes that dataset has been downloaded to the working directory
##    and unzipped into a subdirectory named Dataset.
##    First load all data into R
##---------------------------------------------------------------------------##

## Read in test and train data sets using read.table
tstDat <- read.table("./Dataset/test/X_test.txt", header = FALSE)
tstDatAct <- read.table("./Dataset/test/y_test.txt", header = FALSE)
tstDatSub <- read.table("./Dataset/test/subject_test.txt", header = FALSE)
trnDat <- read.table("./Dataset/train/X_train.txt", header = FALSE)
trnDatAct <- read.table("./Dataset/train/y_train.txt", header = FALSE)
trnDatSub <- read.table("./Dataset/train/subject_train.txt", header = FALSE)

## Read in features.txt file containing index of file names
features <- read.table("./Dataset/features.txt", header = FALSE)

## Read in activity_labels.txt file containing index if descriptive activity names
activities <- read.table("./Dataset/activity_labels.txt", header = FALSE)

##---------------------------------------------------------------------------##
## 3. Uses descriptive activity names to name the activities in the data set
##    Replace activity numbers with activity names from activity_labels.txt 
##---------------------------------------------------------------------------##
trnDatAct <- merge(trnDatAct, activities)
trnDatAct <- select(trnDatAct, -V1)
tstDatAct <- merge(tstDatAct, activities)
tstDatAct <- select(tstDatAct, -V1)

##---------------------------------------------------------------------------##
## 1. Merge Test and Training data into one data set.
##    Add the subject and activity columns to the test and train datasets
##    Combine the test and train datasets
##---------------------------------------------------------------------------##
tstDatComb <- cbind(tstDatSub, tstDatAct, tstDat)
trnDatComb <- cbind(trnDatSub, trnDatAct, trnDat)
combDat <- rbind(tstDatComb, trnDatComb)


##---------------------------------------------------------------------------##
## 4. Appropriately labels the data set with descriptive variable names
##    Apply variable names from features.txt file and add names for
##    Activity and Subject columns 
##    Clean up column names by removing invalid charaters parenthesis, commas, etc.
##---------------------------------------------------------------------------##
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


##---------------------------------------------------------------------------##
## 2. Extracts only the measurements on the mean and standard deviation 
##    for each measurement.
##    Convert to tbl_df
##    User dplyr select command to select mean, std, Subjects, Activity columns
##---------------------------------------------------------------------------##
combDat_tbl <- tbl_df(combDat)
combDat_sel <- select(combDat_tbl, subjects, activity, contains("mean"), contains("std"))

##---------------------------------------------------------------------------##
## 5. From the data set in step 4, creates a second, independent tidy data 
## 6. set with the average of each variable for each activity and each subject.
##---------------------------------------------------------------------------##
##### create the tidy data set
library(reshape2)
meltedDat <- melt(combDat_sel, id=c("subjects","activity"))
tidyDat <- dcast(meltedDat, subjects+activity ~ variable, mean)

## Write tidy data to a file

write.table(tidyDat, file = "./tidyDat.txt", row.names = FALSE)
