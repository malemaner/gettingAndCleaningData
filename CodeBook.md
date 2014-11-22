# CodeBook

This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

## The data source

* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

#### The dataset includes the following files:

* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

### Variables

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

### Work/Transformations

#### Load test and training sets and the activities

The data set has been stored in the `UCI HAR Dataset/` directory.

The CDN url provided by the instructor is used instead of the original location, to offload the traffic to the UCI server.

The `unzip` function is used to extract the zip file in this directory.

```
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl, destfile = "Dataset.zip")

unzip("Dataset.zip")
```

`read.table` is used to load the data to R environment for the data, the activities and the subject of both test and training datasets.

```
colNam <- read.table("./UCI HAR Dataset/features.txt")[,2]
XTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
yTest  <- read.table("./UCI HAR Dataset/test/y_test.txt")
subTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

```


#### Descriptive activity names to name the activities in the data set

The class labels linked with their activity names are loaded from the `activity_labels.txt` file. 
```

actLabl <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

names(XTest) = "features"
names(yTest) = c("ActID", "ActLabel")
names(subTest) = "subject"
names(xTrain) <- "features"
names(yTrain) = c("ActID", "ActLabel")
names(subTrain) = "subject"
data = rbind(testDT, trData)
idLabels   = c("subject", "ActID", "ActLabel")
dataLabels = setdiff(colnames(data), idLabels)
```

#### Extract  the mean and standard deviation .
```
extFeat <- grepl("mean|std", colNam)
XTest = XTest[,extFeat]
xTrain = xTrain[,extFeat]
```
###Finaly the desired result, a `tidy` data table is created with the average of each measurement per activity/subject combination. The new dataset is saved in `tidy_file` file.

```
meltData      = melt(data, id = idLabels, measure.vars = dataLabels)

tidyData   = dcast(meltData, subject + ActLabel ~ variable, mean)

write.table(tidyData, file = "./tidy_data.txt", row.name=FALSE,sep="\t")
```