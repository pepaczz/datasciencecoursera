# Readme file for run_analysis.R

## General description and functionality

The script creates and run a function which generates dfTidy object. This object contains resulting tidy dataset according to instructions taken from the Course project of Coursera's Getting and Cleaning Data:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The function requires the working directory to contain the folder 'UCI HAR Dataset' whith the same structure as the raw data.

## Code description

### MERGING DATASETS (TASK 1)

The code first loads and merges Xtrain, ytrain and subjecttrain tables from the data. The tables are then merged using cbind.
The same is performed for Xtest, ytest and subjecttest tables.

The observations are merged together using rbind into dataframe "df"

### MEAN AND STD (TASK 2)

Variable names are uploaded from file UCI HAR Dataset/features.txt 
Only variable names containing string "mean" or "std" (not case sensitive) are preserved.
Based on the information in the course discussion forum (https://class.coursera.org/getdata-015/forum/thread?thread_id=26) all enties with "mean" in the name are included, not only those tith "mean()" in the latter part of the label.   
Redundant columns are dropped from the dataframe df.

### DESCRIPTIVE ACTIVITY NAMES (TASK 3)

Activity names are uploaded from table "UCI HAR Dataset/activity_labels.txt" and substituted for original activity numbers in the dataset.

### VARIABLE NAMES (TASK 4)

Selected variable labels are obtained from the original vector of labels provided in the raw dataset. 
Invalid characters are replaced by valid characters. 
Resulting vector of names is assigned to the dataframe df.

### CREATE RESULTING TIDY DATA SET (TASK 5)

Resulting tidy dataset si created from the df dataframe using the function aggregate.
Mean is calculated for each variable and for each activity - subject pair. 