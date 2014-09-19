---
title: "Course Project Getting and Cleaning Data"
author: "Cristián Fichter"
date: "Thursday, September 18, 2014"
output: word_document
---
##This file describes the content of GyCData repository.

###Data sources:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

- *run_analysis.R* file contains the R script for performing the following steps to clean the data:

  + 1.	Merges the training and the test sets to create one data set.
  + 2.	Extracts only the measurements on the mean and standard deviation for each measurement 
  + 3.	Uses descriptive activity names to name the activities in the data set.
  + 4.	Appropriately labels the data set with descriptive variable names. 
  + 5.	Creates a second independent tidy data set from the data set in step 4, with the average   of each variable for each activity and each subject.

- *data_full.txt* is an intermediate cleaned and full file (steps 1-4 run_analysis.R).

- *tidy_data_means.txt* is the project final file (step 5 run_analysis.R).

- *Code Book.md* describes the variables, the data, and any transformations or work that have been performed to clean up the data.
