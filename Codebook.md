# Codebook
## Coursera Getting and Cleaning Data Course Project
The Coursera Getting and Cleaning Data Course Project uses data from the UCI Center for Machine Learning and Intelligent Systems.  The Human Activity Recognition Using Smartphones Data Set contains data collected from smart phones from 30 volunteers performing six different activities.
The raw data, as well as a more complete description of the source data is available at the following URL:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

The ./Dataset directory on this repository contains a complete copy of the data set and supporting files.

##### The following data files were used for this course project.
1.	features.txt: contains a list of the 561 variable names
2.	activity_labels.txt: This table contains a list of activity ids and the descriptive activity name.
3.	train/X_train.txt: This table contains the measurement data for the training experiment.  It contains the measured values for 561 variables.  It does not include column headings/variable names.  It does not contain subject or activity id values.
4.	train/y_train.txt: This table contains the list of activity ids for each observation in the training data set X_train.txt.
5.	train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
6.	test/X_test.txt': This table contains the measurement data for the test experiment.  It contains the measured values for 561 variables.  It does not include column headings/variable names.  It does not contain subject or activity id values.
7.	test/y_test.txt': This table contains the list of activity ids for each observation in the test data set X_test.txt.
8.	train/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Objective
The objective of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. We are required to: 
 You should create one R script called run_analysis.R that does the following. 

1.	Create one R script called run_analysis.R that does the following:
2.	Merges the training and the test sets to create one data set.
3.	Extracts only the measurements on the mean and standard deviation for each measurement. 
4.	Uses descriptive activity names to name the activities in the data set
5.	Appropriately labels the data set with descriptive variable names. 
6.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

	
## Approach:
### Create one R script called run_analysis.R
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




