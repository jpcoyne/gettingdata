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

## Files and Descriptions
Files in this repository include:

1. README.md - https://github.com/jpcoyne/gettingdata/blob/master/README.md
   - This file contains a description of the course project and all of the supporting files.
2. Codebook.md - https://github.com/jpcoyne/gettingdata/blob/master/Codebook.md
   - The Codebook document contains a list of the source data, documentation of all of the steps performed to maniplualate and transform the data, and a description of the resulting tidy data output.
3. run_analysis.R - https://github.com/jpcoyne/gettingdata/blob/master/run_analysis.R
   - R script that contains all of the source code for this project.
4. ./Dataset - https://github.com/jpcoyne/gettingdata/tree/master/Dataset
   - Directory containing a complete copy of the Human Activity Recognition Using Smartphones Data Set from the UCI Center for Machine Learning and Intelligent Systems.
5. tidyDat.txt - https://github.com/jpcoyne/gettingdata/blob/master/tidyDat.txt
   - The tidyDat.txt files is the tidy data output from this project.  It is the end result of processing the source data through the run_analysis.R script.


## Tidy Data Principles

The principles of Tidy Data introduced in this course include:

1. Each variable should be contained in single column
2. Each observation should be represented in its own row
3. There should be one table for each "kind" of variable
4. If the data set contains multiple tables, they should include an id column that allows them to be linked
See the Lecutre on The Components of Tidy Data by Jeffery Leek - https://class.coursera.org/getdata-012/lecture/7
and Data Sharing from Jeffery Leek  - https://github.com/jtleek/datasharing

Recommended reading:  Tidy Data by Hadley Wickham from the Journal of Statisical Software
http://www.jstatsoft.org/v59/i10/paper
