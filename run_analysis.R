##For a description of what does the script do check codeBook.md
setwd("C:/Users/mario/Desktop/coursera/gettingAndCleaningData")

if (!require("data.table")) {
    install.packages("data.table")
}

if (!require("reshape2")) {
    install.packages("reshape2")
}

require("data.table")
require("reshape2")


fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl, destfile = "Dataset.zip")

unzip("Dataset.zip")

actLabl <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

colNam <- read.table("./UCI HAR Dataset/features.txt")[,2]

extFeat <- grepl("mean|std", colNam)

XTest <- read.table("./UCI HAR Dataset/test/X_test.txt")

yTest  <- read.table("./UCI HAR Dataset/test/y_test.txt")

subTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(XTest) = "features"

XTest = XTest[,extFeat]

yTest[,2] = actLabl[yTest[,1]]

names(yTest) = c("ActID", "ActLabel")

names(subTest) = "subject"

testDT <- cbind(as.data.table(subTest), yTest, XTest)

xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")

yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

subTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(xTrain) <- "features"

xTrain = xTrain[,extFeat]

yTrain[,2] = actLabl[yTrain[,1]]

names(yTrain) = c("ActID", "ActLabel")

names(subTrain) = "subject"

trData <- cbind(as.data.table(subTrain), yTrain, xTrain)

data = rbind(testDT, trData)

idLabels   = c("subject", "ActID", "ActLabel")

dataLabels = setdiff(colnames(data), idLabels)

meltData      = melt(data, id = idLabels, measure.vars = dataLabels)

tidyData   = dcast(meltData, subject + ActLabel ~ variable, mean)

write.table(tidyData, file = "./tidy_data.txt", row.name=FALSE,sep="\t")






