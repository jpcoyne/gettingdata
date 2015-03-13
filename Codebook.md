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

	


