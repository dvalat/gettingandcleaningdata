COURSERA - Getting and Cleaning Data - Course Project
=====================================================

Introduction
------------
This repository is part of the course "Getting and Cleaning data" and it contains files for the Course Project.

Description of the raw data
---------------------------

Test set:
- File "x_test.txt": contains the features un-labeled. 
- File "y_test.txt": contains the activity labels.
- File "subject_test.txt" : contains the test subjects.
Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Training set:
- File "x_train.txt": contains the features un-labeled. 
- File "y_train.txt": contains the activity labels.
- File "subject_train.txt" : contains the train subjects.
Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Description of the script and the tidy dataset
----------------------------------------------
The aim of the Course Project was to create a script "run_analysis.R" which merge the test and training sets together.
Once the testing and training data sets are merged, labels are added and some variables are selected: the only ones which are used to calculate the mean and the standard deviation.
The last step of the script is to create a "tidy data set" which contains the mean of all the columns per test subject and per activity.
The "tidy data set" is written into the file "tidy_data_set.txt" (a tab-delimited file) which is stored into this repository.

Test the following Course Project
---------------------------------

1. The UCI HAR Dataset (file: "getdata-projectfiles-UCI HAR Dataset.zip") must be extracted into a folder called "UCI HAR Dataset".
2. Put the file "run_analysis.R" in the parent folder of "UCI HAR Dataset" folder, then set your R working directory using setwd() function in RStudio.
3. Source the file "run_analysis.R", it will generate the tidy data set file "tiny_data_set.txt" in your working directory

Description of the Code Book
----------------------------
The Code Book is defined in the file "CodeBook.md" which explains the transformations performed but also the results data and variables.
