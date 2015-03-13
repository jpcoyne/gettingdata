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


## Create one R script called run_analysis.R
### Approach:
##### Read in Raw Data
Read in test and train data sets, features column labels, and activity descriptions using read.table() and assign them to new data frames.

```R
 tstDat <- read.table("./Dataset/test/X_test.txt", header = FALSE)
 tstDatAct <- read.table("./Dataset/test/y_test.txt", header = FALSE)
 tstDatSub <- read.table("./Dataset/test/subject_test.txt", header = FALSE)
 trnDat <- read.table("./Dataset/train/X_train.txt", header = FALSE)
 trnDatAct <- read.table("./Dataset/train/y_train.txt", header = FALSE)
 trnDatSub <- read.table("./Dataset/train/subject_train.txt", header = FALSE)
 features <- read.table("./Dataset/features.txt", header = FALSE)
 activities <- read.table("./Dataset/activity_labels.txt", header = FALSE)
```

##### Use Descriptive Activity In The data Set.
Replace activity numbers with activity names from activity_labels.txt in both the test and train activity tables.  Use the merge() command to add a column with descriptive activity names matching the activity id.  Use the select() command to activity id column, leaving only the descriptive activity label.

```R
 trnDatAct <- merge(trnDatAct, activities)
 trnDatAct <- select(trnDatAct, -V1)
 tstDatAct <- merge(tstDatAct, activities)
 tstDatAct <- select(tstDatAct, -V1)
```
##### Merge Test and Training data into one data set.
 1. Use the cbind() command to add the subjects and activity columns to the test datasets.
 2. Use the cbind() command to add the subjects and activity columns to the train datasets.
 3. Use the rbind() command to combine the test and train datasets.

```R
 tstDatComb <- cbind(tstDatSub, tstDatAct, tstDat)
 trnDatComb <- cbind(trnDatSub, trnDatAct, trnDat)
 combDat <- rbind(tstDatComb, trnDatComb)
```

##### Appropriately Label The Data Set
Appropriately label the data set with descriptive variable names. Clean up the variable names to remove invalid characters.  User the gsub() command to search and replace characters.  Use the make.names() command to ensure that variable names are all syntactically valid and unique.
 1. Apply variable names from features.txt file and add names for activity and subjects columns. 
 2. Clean up column names by removing invalid characters: parenthesis, commas
 3. Replace dash "-" characters with underscrore "_"
 4. Replace "t" with more descriptive "time"
 5. Replace "f" with more descriptive "frequency"
 6. Replace "Acc" with more descriptive "Accelerometer"
 7. Replace "Mag" with more descriptive "Magnitude"
 
```R
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
```

##### Extracts only the measurements on the mean and standard deviation for each measurement.
User dplyr select() command to select subjects, and activity columns, and columns with names that contain "mean" and "std" in the name.
```R
 combDat_tbl <- tbl_df(combDat)
 combDat_sel <- select(combDat_tbl, subjects, activity, contains("mean"), contains("std"))
 ```

##### Create a Second, Independent Tidy Data
From the combined data set, create a second, independent tidy data. Set with the average of each variable for each activity and each subject.  Use the melt() and dcast() commands from the reshape2 library.
 1. Use the melt() command to create a long skinny data set of observations based on the subjects and activities ids.
 2. Use the dcast() command to create a tidy data set with the mean of each variable for each activity and subject.

```R
 library(reshape2)
 meltedDat <- melt(combDat_sel, id=c("subjects","activity"))
 tidyDat <- dcast(meltedDat, subjects+activity ~ variable, mean)
```

##### Write tidy data to a file
```R
 write.table(tidyDat, file = "./tidyDat.txt", row.names = FALSE)
```


