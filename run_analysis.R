## convenience function for download files
downloadF <- function(fromUrl, fileName, directory = "data", force = FALSE) {
    if (!file.exists(directory)) {dir.create(directory)}
    
    pathName <- paste(directory, fileName, sep = "/")
    if (!file.exists(pathName) | force == TRUE) {
        download.file(fromUrl, destfile = pathName, method = "curl", extra='-L')
    } 
    print(date())
    pathName
}

## Getting data main()
library("dplyr")

################################################################################
# Download and unpackage raw data set into the "data" folder
################################################################################
fromUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "Dataset.zip"
dataDir <- "data"
filePath <- downloadF(fromUrl, fileName, directory = dataDir)

## Unpacking Zip file
unzip(filePath, exdir = dataDir)

## Find the unzip dataset directory
datasetDir <- list.dirs(dataDir, recursive = FALSE)

## list all files from the Dataset.zip
files <- list.files(datasetDir, recursive = TRUE)

################################################################################
# read subject, activity and feature datasets for test group
################################################################################
subjectTestDF <- read.table(file.path(datasetDir, "test/subject_test.txt"),
                             header = FALSE)
activityTestDF <- read.table(file.path(datasetDir, "test/y_test.txt" ), 
                             header = FALSE)
featuresTestDF <- read.table(file.path(datasetDir, "test/X_test.txt" ), 
                             header = FALSE)

################################################################################
# read subject, activity and feature datasets for traning group
################################################################################
subjectTrainDF <- read.table(file.path(datasetDir, "train/subject_train.txt"), 
                              header = FALSE)
activityTrainDF <- read.table(file.path(datasetDir, "train/y_train.txt"), 
                              header = FALSE)
featuresTrainDF <- read.table(file.path(datasetDir, "train/X_train.txt"), 
                              header = FALSE)

################################################################################
# merge by-row subjectTestDF and activityTrainDF and repeat the same process
# remaining two group of datasets
################################################################################
subjectDF <- rbind(subjectTestDF, subjectTrainDF)
activityDF <- rbind(activityTestDF, activityTrainDF)
featuresDF<- rbind(featuresTestDF, featuresTrainDF)

################################################################################
# read activity labels and replace activity ID with appropriate labels
################################################################################
activityLabels <- read.table(
    file.path(datasetDir,  "activity_labels.txt"), header = FALSE)

activityDF$V1 <- factor(activityDF$V1, 
                        levels = activityLabels$V1, 
                        labels = activityLabels$V2)

################################################################################
# Merge subjectDF, activityDF and featuresDF to form a datasetDF.
# The datasetDF is expected to have 1+1+561 = 563 variables
################################################################################
datasetDF <- subjectDF %>% 
    cbind(activityDF) %>%
    cbind(featuresDF)

# read in the feature names and verify that is should have 561 names, each
# for a columns in the featuresDF data set.
################################################################################
# Read in the feature names and verify that is should have 561 names.
# Create datasetDFNames for all variables in datasetDF.
################################################################################
featureNames <- read.table(file.path(datasetDir, "features.txt"),head=FALSE)

datasetDFNames = c("subject", "activity", featureNames[,2])

# Update column names
names(datasetDF) <- datasetDFNames


################################################################################
# Select only variable related to mean and standard deviation and create
# the final tidy data set.
################################################################################
selectedVariableNames <- 
    datasetDFNames[grep("mean\\(\\)|std\\(\\)|subject|activity", datasetDFNames)]

# select only interested variables
tidyDataSet <- subset(datasetDF, select = selectedVariableNames)
rm(datasetDF)
# str(tidyDataSet)

################################################################################
# This section is to clean up the variable names
################################################################################
tidyVariableNames <- names(tidyDataSet)
tidyVariableNames <- gsub("^t", "time", tidyVariableNames)
tidyVariableNames <- gsub("^f", "frequency", tidyVariableNames)
tidyVariableNames <- gsub("Acc", "Accelerometer", tidyVariableNames)
tidyVariableNames <- gsub("Gyro", "Gyroscope", tidyVariableNames)
tidyVariableNames <- gsub("Mag", "Magnitude", tidyVariableNames)
tidyVariableNames <- gsub("BodyBody", "Body", tidyVariableNames)
tidyVariableNames <- gsub("-mean", "Mean", tidyVariableNames)
tidyVariableNames <- gsub("-std", "Std", tidyVariableNames)
tidyVariableNames <- gsub("[-()]", "", tidyVariableNames)
# update names
names(tidyDataSet) <- tidyVariableNames

################################################################################
# From the tidyDataSet, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
################################################################################
# group by subject and activity and summarise using mean
# NOTE:
# 1) .groups = "keep" Same grouping structure as .data, 
#              i.e. c("subject", "activity")
################################################################################
tidyDataSet2 <- tidyDataSet %>% 
    group_by(subject, activity) %>%
    dplyr::summarise(across(.cols = everything(), mean), .groups = "keep")

# output to file "tidy_data.txt"
write.table(tidyDataSet2, "tidy_data.txt", row.names = FALSE, quote = FALSE)

print("Completed: write tidy data set to ./tidy_data.txt file")

# To test:
# source("run_analysis.R")

# To generate README.html and README.pdf
# library("rmarkdown")
# rmarkdown::render("README.md",output_format = "all")
