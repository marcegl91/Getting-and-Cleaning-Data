Getting-and-Cleaning-Data
=========================

Course project of Getting and Cleaning Data
-------------------------------------------

Usage: source("run_analysis.R")

There is only a script file: "run_analysis.R".
Script requirements: dplyr package.

Output: tidy data set according the following instructions:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This script does the following actions:

1. Check if files exists, if not download them.
2. Check if unzipped folder exists, if not unzip the file.
3. Set correct decimal precision to not lose information.
4. Set a colClasses variable  which is going to be used to read the data files. This variable defines the datatype of every column in the data files.
5. Append the correct values of subject and activity for each measurement, according data files and original Codebook.
6. Merge the test data with the training data.
7. Applies descriptive names to all columns in the data frame.
8. Filter only columns with the criteria to be a mean or a standard deviation. meanFreq are not included because, according original Codebook, it is "Weighted average of the frequency components to obtain a mean frequency", which is not what the project's instructions were asking for.
9. Applies descriptive names to all activities.
10. Summarise every column by subject and by activity.
11. Returns the summarised data.