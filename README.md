# getting_cleaning_data
Project for the Getting and Cleaning data course.

## Check if the data directory exists.

if(!file.exists("data")){
  
  ## Create if the directory doesnt already exist
  dir.create("data")
}
## Change working directory to your working directory.
setwd("C://Users//Sony//Documents//data")

## Assign the download path to the fileUrl variable  
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## use download.file() function to download the file
download.file(fileUrl, destfile="data.zip")

## Assign the date to the downloaded file. 
date.Downloaded <- date()
date.Downloaded

## Unzip the file
unzip(zipfile="data.zip",exdir="dataDir")

## Manually verified that the zip file is extracted to my data directory dataDir.
## The zip is extracted to a folder called UCI HAR Dataset.
## Set the file path to UCI HAR Dataset.
path_dir <- file.path("C://Users//Sony//Documents//data//dataDir" , "UCI HAR Dataset")

## List the files that are present in the directory.
files<-list.files(path_dir, recursive=TRUE)
files

## Read data from the files into the variables.

## Read the Activity data
dataActivityTest  <- read.table(file.path(path_dir, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_dir, "train", "Y_train.txt"),header = FALSE)

## Read the Subject data
dataSubjectTrain <- read.table(file.path(path_dir, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_dir, "test" , "subject_test.txt"),header = FALSE)

## Read the Features data
dataFeaturesTest  <- read.table(file.path(path_dir, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_dir, "train", "X_train.txt"),header = FALSE)

## Look at the structure of the data in the variables.
str(dataActivityTest)
str(dataActivityTrain)
str(dataSubjectTrain)
str(dataSubjectTest)
str(dataFeaturesTest)
str(dataFeaturesTrain)

## Manually read the attached read me file.
## Merge the training and the test datasets.

dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

## Assign meaningful names to the variables.
names(dataSubject)<-c("Subject")
names(dataActivity)<- c("Activity")
dataFeaturesNames <- read.table(file.path(path_dir, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames

## Merge columns to get the data frame for all data.
dataCombined <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombined)

## Extracts only the measurements on the mean and standard deviation.
subdataFeaturesNames<-dataFeaturesNames[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames)]

## Data subset that has only the selected features.
selectedNames<-c(as.character(subdataFeaturesNames), "Subject", "Activity" )
Data<-subset(Data,select=selectedNames)

## Uses descriptive activity names to name the activities in the data set.

# Read activity names.
activityLabels <- read.table(file.path(path_dir, "activity_labels.txt"),header = FALSE)

head(Data$activity)

## Assign meaningful names.
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

## Create the final data set using plyr.
library(plyr);
Data2<-aggregate(. ~Subject + Activity, Data, mean)
Data2<-Data2[order(Data2$Subject,Data2$Activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
