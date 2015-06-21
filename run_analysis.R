## Check if the data directory exists.

if(!file.exists("data")){
  
  ## Create if the directory doesnt already exist
  dir.create("data")
}
## Change working directory. Replace with your working directory.

setwd("C://Users//Sony//Documents//data")

## Assign the download path to the fileUrl variable  

fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## use download.file() function to download the file
download.file(fileUrl, destfile="data.zip")

## Assign the date to the downloaded file. 
date.Downloaded <- date()
date.Downloaded

## Unzip the file
unzip(zipfile="data.zip",exdir="./data")

## Manually verified the folder name. What is a better way to perform this step from within the R script.

## Unzipped files are in UCI HAR Dataset. Get the list of the files.

path_dir <- file.path("./data" , "UCI HAR Dataset")
files <- list.files(path_dir, recursive=TRUE)
files

## Read data from the files into the variables
dataActivityTest  <- read.table(file.path("UCI HAR Dataset", "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path("UCI HAR Dataset", "train", "Y_train.txt"),header = FALSE)

dataSubjectTrain <- read.table(file.path(path_dir, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_dir, "test" , "subject_test.txt"),header = FALSE)

dataFeaturesTest  <- read.table(file.path(path_dir, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_dir, "train", "X_train.txt"),header = FALSE)
