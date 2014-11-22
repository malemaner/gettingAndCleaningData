# Getting and Cleaning Data

## Instruction.

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Instructions to get Files.
1. Download the data source . You'll have a ```UCI HAR Dataset``` .
2. Put ```run_analysis.R``` in the parent folder in```UCI HAR Dataset```, then set it as your WD using ```setwd()```.
3. Run ```source("run_analysis.R")```, then it will generate a new file ```tiny_data.txt``` in your working directory.

## Dependencies

It depends on ```reshape2``` and ```data.table```.

##Extra Info.
This repository contains R code that downloads and does some preprocessing on Human
Activity Recognition data set. The full description and the data can be found
[here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

See `CodeBook.md` for details.
