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

##### Load required libraries
Load the require libraries: data.table, dplyr, and reshape2)```

##### Read in Raw Data
Read in test and train data sets, features column labels, and activity descriptions using read.table() and assign them to new data frames.


##### Combine the Test and Training data into one data set.
 1. Use the cbind() command to add the subjects and activity columns to the test datasets.
 2. Use the cbind() command to add the subjects and activity columns to the train datasets.
 3. Use the rbind() command to combine the test and train datasets.

The result of the combined data set is a table of 10299 observations of 563 varialbe.  This includes 561 measurement variables plus the subject and activityNum columns.


##### Appropriately Label The Data Set
Appropriately label the data set with descriptive variable names. Clean up the variable names to remove invalid characters.  User the gsub() command to search and replace characters.  Use the make.names() command to ensure that variable names are all syntactically valid and unique.
 1. Apply variable names from features.txt file and add names for activity and subjects columns. 
 2. Clean up column names by removing invalid characters: parenthesis, commas
 3. Replace dash "-" characters with underscrore "_"
 4. Replace "t" with more descriptive "time"
 5. Replace "f" with more descriptive "frequency"
 6. Replace "Acc" with more descriptive "Accelerometer"
 7. Replace "Mag" with more descriptive "Magnitude"

The following table is a sample of the original column names on the left and the new cleaned up columns names on the right.
```
           Original_Names                Transformed_Names
              activityNum                      activityNum
                 subjects                         subjects
        tBodyAcc-mean()-X     timeBodyAccelerometer_mean_X
        tBodyAcc-mean()-Y     timeBodyAccelerometer_mean_Y
        tBodyAcc-mean()-Z     timeBodyAccelerometer_mean_Z
         tBodyAcc-std()-X      timeBodyAccelerometer_std_X
         tBodyAcc-std()-Y      timeBodyAccelerometer_std_Y
         tBodyAcc-std()-Z      timeBodyAccelerometer_std_Z
         tBodyAcc-mad()-X      timeBodyAccelerometer_mad_X
         tBodyAcc-mad()-Y      timeBodyAccelerometer_mad_Y
         tBodyAcc-mad()-Z      timeBodyAccelerometer_mad_Z
         tBodyAcc-max()-X      timeBodyAccelerometer_max_X
         tBodyAcc-max()-Y      timeBodyAccelerometer_max_Y
         tBodyAcc-max()-Z      timeBodyAccelerometer_max_Z
         tBodyAcc-min()-X      timeBodyAccelerometer_min_X
         tBodyAcc-min()-Y      timeBodyAccelerometer_min_Y
         tBodyAcc-min()-Z      timeBodyAccelerometer_min_Z
           tBodyAcc-sma()        timeBodyAccelerometer_sma
      tBodyAcc-energy()-X   timeBodyAccelerometer_energy_X
      tBodyAcc-energy()-Y   timeBodyAccelerometer_energy_Y
      tBodyAcc-energy()-Z   timeBodyAccelerometer_energy_Z
         tBodyAcc-iqr()-X      timeBodyAccelerometer_iqr_X
         tBodyAcc-iqr()-Y      timeBodyAccelerometer_iqr_Y
         tBodyAcc-iqr()-Z      timeBodyAccelerometer_iqr_Z
     tBodyAcc-entropy()-X  timeBodyAccelerometer_entropy_X
     tBodyAcc-entropy()-Y  timeBodyAccelerometer_entropy_Y
     tBodyAcc-entropy()-Z  timeBodyAccelerometer_entropy_Z
   tBodyAcc-arCoeff()-X,1 timeBodyAccelerometer_arCoeff_X1
   tBodyAcc-arCoeff()-X,2 timeBodyAccelerometer_arCoeff_X2
   tBodyAcc-arCoeff()-X,3 timeBodyAccelerometer_arCoeff_X3
```

##### Use Descriptive Activity In The data Set.
Replace activity numbers with activity names from activity_labels.txt in combined data set.  Use the merge() command to add a column with descriptive activity names matching the activityNum id.  Use this command after the data has been combine into a single data set as it can alter the sort order.

##### Extract only the measurements on the mean and standard deviation for each measurement.
User dplyr select() command to select subjects, and activity columns, and columns with names that contain "mean" and "std" in the name.

##### Create a Second, Independent Tidy Data
From the combined data set, create a second, independent tidy data. Set with the average of each variable for each activity and each subject.  Use the melt() and dcast() commands from the reshape2 library.
 1. Use the melt() command to create a long skinny data set of observations based on the subjects and activities ids.
 2. Use the dcast() command to create a tidy data set with the mean of each variable for each activity and subject.

Melted Data output is a table of 885714 observations of 4 variables.  A view of the first 20 rows is provided below.
```
   subjects activity                     variable     value
          7  WALKING timeBodyAccelerometer_mean_X 0.2693013
         21  WALKING timeBodyAccelerometer_mean_X 0.2623422
          7  WALKING timeBodyAccelerometer_mean_X 0.2383207
          7  WALKING timeBodyAccelerometer_mean_X 0.2447143
         18  WALKING timeBodyAccelerometer_mean_X 0.2490386
          7  WALKING timeBodyAccelerometer_mean_X 0.2046162
          7  WALKING timeBodyAccelerometer_mean_X 0.3191731
          7  WALKING timeBodyAccelerometer_mean_X 0.3637475
         11  WALKING timeBodyAccelerometer_mean_X 0.2708811
         21  WALKING timeBodyAccelerometer_mean_X 0.2951976
         20  WALKING timeBodyAccelerometer_mean_X 0.2519410
          7  WALKING timeBodyAccelerometer_mean_X 0.3592946
         22  WALKING timeBodyAccelerometer_mean_X 0.2405527
         20  WALKING timeBodyAccelerometer_mean_X 0.2576862
         26  WALKING timeBodyAccelerometer_mean_X 0.3369741
         26  WALKING timeBodyAccelerometer_mean_X 0.2462884
         11  WALKING timeBodyAccelerometer_mean_X 0.3237327
         22  WALKING timeBodyAccelerometer_mean_X 0.2804753
         11  WALKING timeBodyAccelerometer_mean_X 0.2590250
         26  WALKING timeBodyAccelerometer_mean_X 0.2237301
```

##### Write tidy data to a file
The tidy data file, tidyDat.txt, has been save at the root level of this repository and has been submitted to the Coursera Getting and Cleaning Data Course Project.

## Tidy Data Output
### Description of the resulting analytical data set:

The end result of the Course Project is a tidy data set containing 180 observations of 88 variables and saved in a text file named tidyDat.txt.  The example below shows the first three columns and the first ten rows of the final data.
The table contains the mean value of every measured variable for each unique combination of subject and activity.
```
   subjects           activity timeBodyAccelerometer_mean_X 
          1             LAYING                    0.2215982
          1            SITTING                    0.2612376
          1           STANDING                    0.2789176
          1            WALKING                    0.2773308
          1 WALKING_DOWNSTAIRS                    0.2891883
          1   WALKING_UPSTAIRS                    0.2554617
          2             LAYING                    0.2813734
          2            SITTING                    0.2770874
          2           STANDING                    0.2779115
          2            WALKING                    0.2764266
```

The data set includes 88 columns containing subject ID numbers, activity names, and the calculated mean value of each of the selected measurement variables for each unique combination of subject and activity.  The column names and secriptions for the tidy data set are provbided below:
```
                                        ColumnNames                    Description
1                                          subjects           =  Subject ID Number
2                                          activity   =  Descriptive Activity Name
3                      timeBodyAccelerometer_mean_X   =  Mean value of measurement
4                      timeBodyAccelerometer_mean_Y   =  Mean value of measurement
5                      timeBodyAccelerometer_mean_Z   =  Mean value of measurement
6                   timeGravityAccelerometer_mean_X   =  Mean value of measurement
7                   timeGravityAccelerometer_mean_Y   =  Mean value of measurement
8                   timeGravityAccelerometer_mean_Z   =  Mean value of measurement
9                  timeBodyAccelerometerJerk_mean_X   =  Mean value of measurement
10                 timeBodyAccelerometerJerk_mean_Y   =  Mean value of measurement
11                 timeBodyAccelerometerJerk_mean_Z   =  Mean value of measurement
12                              timeBodyGyro_mean_X   =  Mean value of measurement
13                              timeBodyGyro_mean_Y   =  Mean value of measurement
14                              timeBodyGyro_mean_Z   =  Mean value of measurement
15                          timeBodyGyroJerk_mean_X   =  Mean value of measurement
16                          timeBodyGyroJerk_mean_Y   =  Mean value of measurement
17                          timeBodyGyroJerk_mean_Z   =  Mean value of measurement
18              timeBodyAccelerometerMagnitude_mean   =  Mean value of measurement
19           timeGravityAccelerometerMagnitude_mean   =  Mean value of measurement
20          timeBodyAccelerometerJerkMagnitude_mean   =  Mean value of measurement
21                       timeBodyGyroMagnitude_mean   =  Mean value of measurement
22                   timeBodyGyroJerkMagnitude_mean   =  Mean value of measurement
23                frequencyBodyAccelerometer_mean_X   =  Mean value of measurement
24                frequencyBodyAccelerometer_mean_Y   =  Mean value of measurement
25                frequencyBodyAccelerometer_mean_Z   =  Mean value of measurement
26            frequencyBodyAccelerometer_meanFreq_X   =  Mean value of measurement
27            frequencyBodyAccelerometer_meanFreq_Y   =  Mean value of measurement
28            frequencyBodyAccelerometer_meanFreq_Z   =  Mean value of measurement
29            frequencyBodyAccelerometerJerk_mean_X   =  Mean value of measurement
30            frequencyBodyAccelerometerJerk_mean_Y   =  Mean value of measurement
31            frequencyBodyAccelerometerJerk_mean_Z   =  Mean value of measurement
32        frequencyBodyAccelerometerJerk_meanFreq_X   =  Mean value of measurement
33        frequencyBodyAccelerometerJerk_meanFreq_Y   =  Mean value of measurement
34        frequencyBodyAccelerometerJerk_meanFreq_Z   =  Mean value of measurement
35                         frequencyBodyGyro_mean_X   =  Mean value of measurement
36                         frequencyBodyGyro_mean_Y   =  Mean value of measurement
37                         frequencyBodyGyro_mean_Z   =  Mean value of measurement
38                     frequencyBodyGyro_meanFreq_X   =  Mean value of measurement
39                     frequencyBodyGyro_meanFreq_Y   =  Mean value of measurement
40                     frequencyBodyGyro_meanFreq_Z   =  Mean value of measurement
41         frequencyBodyAccelerometerMagnitude_mean   =  Mean value of measurement
42     frequencyBodyAccelerometerMagnitude_meanFreq   =  Mean value of measurement
43     frequencyBodyAccelerometerJerkMagnitude_mean   =  Mean value of measurement
44 frequencyBodyAccelerometerJerkMagnitude_meanFreq   =  Mean value of measurement
45                  frequencyBodyGyroMagnitude_mean   =  Mean value of measurement
46              frequencyBodyGyroMagnitude_meanFreq   =  Mean value of measurement
47              frequencyBodyGyroJerkMagnitude_mean   =  Mean value of measurement
48          frequencyBodyGyroJerkMagnitude_meanFreq   =  Mean value of measurement
49            angletimeBodyAccelerometerMeangravity   =  Mean value of measurement
50    angletimeBodyAccelerometerJerkMeangravityMean   =  Mean value of measurement
51                 angletimeBodyGyroMeangravityMean   =  Mean value of measurement
52             angletimeBodyGyroJerkMeangravityMean   =  Mean value of measurement
53                                angleXgravityMean   =  Mean value of measurement
54                                angleYgravityMean   =  Mean value of measurement
55                                angleZgravityMean   =  Mean value of measurement
56                      timeBodyAccelerometer_std_X   =  Mean value of measurement
57                      timeBodyAccelerometer_std_Y   =  Mean value of measurement
58                      timeBodyAccelerometer_std_Z   =  Mean value of measurement
59                   timeGravityAccelerometer_std_X   =  Mean value of measurement
60                   timeGravityAccelerometer_std_Y   =  Mean value of measurement
61                   timeGravityAccelerometer_std_Z   =  Mean value of measurement
62                  timeBodyAccelerometerJerk_std_X   =  Mean value of measurement
63                  timeBodyAccelerometerJerk_std_Y   =  Mean value of measurement
64                  timeBodyAccelerometerJerk_std_Z   =  Mean value of measurement
65                               timeBodyGyro_std_X   =  Mean value of measurement
66                               timeBodyGyro_std_Y   =  Mean value of measurement
67                               timeBodyGyro_std_Z   =  Mean value of measurement
68                           timeBodyGyroJerk_std_X   =  Mean value of measurement
69                           timeBodyGyroJerk_std_Y   =  Mean value of measurement
70                           timeBodyGyroJerk_std_Z   =  Mean value of measurement
71               timeBodyAccelerometerMagnitude_std   =  Mean value of measurement
72            timeGravityAccelerometerMagnitude_std   =  Mean value of measurement
73           timeBodyAccelerometerJerkMagnitude_std   =  Mean value of measurement
74                        timeBodyGyroMagnitude_std   =  Mean value of measurement
75                    timeBodyGyroJerkMagnitude_std   =  Mean value of measurement
76                 frequencyBodyAccelerometer_std_X   =  Mean value of measurement
77                 frequencyBodyAccelerometer_std_Y   =  Mean value of measurement
78                 frequencyBodyAccelerometer_std_Z   =  Mean value of measurement
79             frequencyBodyAccelerometerJerk_std_X   =  Mean value of measurement
80             frequencyBodyAccelerometerJerk_std_Y   =  Mean value of measurement
81             frequencyBodyAccelerometerJerk_std_Z   =  Mean value of measurement
82                          frequencyBodyGyro_std_X   =  Mean value of measurement
83                          frequencyBodyGyro_std_Y   =  Mean value of measurement
84                          frequencyBodyGyro_std_Z   =  Mean value of measurement
85          frequencyBodyAccelerometerMagnitude_std   =  Mean value of measurement
86      frequencyBodyAccelerometerJerkMagnitude_std   =  Mean value of measurement
87                   frequencyBodyGyroMagnitude_std   =  Mean value of measurement
88               frequencyBodyGyroJerkMagnitude_std   =  Mean value of measurement
```



