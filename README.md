# Data-cleaning-tidy-data-creation-s-project

title: tidy data preparation based on "Human Activity Recognition Using Smartphones Dataset (Version 1.0)"

Introduction
=============
The "Human Activity Recognition Using Smartphones Dataset" experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Instruction list (what does the run_analysis.R script):
======================================================
Step 1. Opening and reading raw data
available at the following URL(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

It includes 7 files containing datasets to collect, work with and clean into a tidy dataset:
(1) subject_test.txt and (2) subject_train.txt (variable ID volunteers); 
(3) Y_test.txt and (4) Y_train.txt (variable activities); 
(5) features.txt (names of the 561 variables "features" found in X_test or X_train files); 
(6) X_test.txt and (7) X_train.txt (561 variables "features" in fixed width format). 
To read the latter X_files, create two empty fixed width format using the rear package (allow to specify/guess column positions based on position of empty columns using fwf_empty().

Step 2. create two dataframes merging either the three training or test datasets together :
Using the run version 3.1.2. of R,
(1st) create 2 dataframes of two columns including both ID volunteers and activities variables, for each training (7352 observations) and test (2947 observations) sets; (2nd) add the corresponding X_data columns (561) to the previously created dataframes (resulting in 563 columns).

Step 3. Rename the 563 variables (columns) according to their content (ID, activities and 561 features).

Step 4. Merge the training and test sets to create one data set (10299 observations).

Step 5. Select the variables to be included in the tidy data set. 
Extract the variables to be included in the output tidy data set by subsetting the resulting dataframe: 66 of the 561 features, corresponding to those calculating the mean and standard deviation for each measurement estimated from the accelerometer and gyroscope 3-axial raw signals, were kept.

Step 6. Edit variables using descriptive activity names to name the 6 numbered activities in the dataset (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). 

Step 7. Appropriately label the data set with descriptive variable names using regular expressions, but still keeping them short as much as possible (avoiding numeric and non-alphabetic characters).

Step 8. Generate one tidy data set using the dplyr package (grouping_by and chaining), that summarizes the data, grouped by ID testers and activities, displaying the average of each of the 66 variables (mean and standard deviation variables) for each activity and each ID Volunteer (displayed in two additional columns). Each variable is in one labeled column (68 columns). The average of each different observations of that variable (grouped by ID testers and activities) is in a different row (30*6 rows).

Step 9. Save the tidy data set as a text file (created with write.table())

Further steps: 

To read and look at the tidy data set in R, use the following code:
data <- read.table("tidydata.txt", header = TRUE)

the URL to find the tidydata.txt file is the following: 
https://s3.amazonaws.com/coursera-uploads/user-0f6f7189bd259b901c471b21/973500/asst-3/4fc355c0e9ed11e4a78d8ffdc6ca319c.txt

Content of the repository:
============================
-code for performing the analysis: run_analysis.r file

-CodeBook.md that describes the variables, the data and the design of the "original" experiment ("Human Activity Recognition Using Smartphones Dataset (Version 1.0)")

-this README.md file that describe how the script works.

This repository does not incude the output tidy data set (uploaded on the Coursera website).
