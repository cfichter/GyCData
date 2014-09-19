---
title: "Code Book: Course Project Getting and Cleaning Data"
author: "Cristián Fichter"
date: "Thursday, September 18, 2014"
output: word_document
---
##This file describes the variables, the data, and any transformations or work that have been made to clean up the data.

###Data sources:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

·	The run_analysis.R script performs the following steps to clean the data:

1.	Merges the training and the test sets to create one data set.
  + a.	Read *X_train.txt*, *y_train.txt* and *subject_train.txt* from the *./data/train* folder and store them in **trainData**, **trainLabel** and **trainSubject** variables respectively.
  + b.	Read *X_test.txt*, *y_test.txt* and *subject_test.txt* from the *./data/test* folder and store them in **testData**, **testLabel** and **testsubject** variables respectively.
  + c.	Join **testData** to **trainData** to generate a 10299x561 data frame,  *joinData*; join **testLabel** to **trainLabel** to generate a 10299x1 data frame, *joinLabel*; join **testSubject** to **trainSubject** to generate a 10299x1 data frame, *joinSubject*.
2.	Extracts only the measurements on the mean and standard deviation for each measurement 
  + a.	Read the *features.txt* file from the *./data* folder and store the data in a variable called **features**. Only the measurements on the mean and standard deviation are extracted. This results in a 66 indices list. This list was applied on joinData to get a subset of 66 corresponding columns.
  + b.	Clean the column names of the subset. Remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.
3.	Uses descriptive activity names to name the activities in the data set.
  + a.	Read the *activity_labels.txt* file from the *./data* folder and store the data in a variable called **activity**.
  + b.	Clean the activity names in the second column of **activity**. Similar tasks to 2.b above were performed.
  + c.	Transform the values of joinLabel according to the activity data frame.
4.	Appropriately labels the data set with descriptive variable names. 
  + a.	Combine the joinSubject, joinLabel and joinData by column to get a new cleaned 10299x68 data frame, cleanedData. Properly name the first two columns, **subject** and **activity**. The **subject** column contains integers that range from 1 to 30 inclusive; the **activity** column contains 6 kinds of activity names; the last 66 columns contain normalized measurements.
  + b.	Write the cleanedData out to *data_full.txt* file in current working directory.
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  + a.	Create a second independent tidy data set with the average of each measurement for each activity and each subject. There are 30 unique subjects and 6 unique activities, which result in a 180 combinations subject-activity. Library **'dplyr'** is used in combination with **two for-loops** and **colMeans function** to get the tidyData data frame.
  + b.	Write the tidyData out to *tidy_data_means.txt* file in current working directory. 
