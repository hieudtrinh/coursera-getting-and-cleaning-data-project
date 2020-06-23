---
title: "CodeBook.md"
author: "Hieu Trinh"
date: "6/22/2020"
output:
  html_document: default
  pdf_document: default
---

# Code Book - Getting and Cleaning Data Project

This code book that describes the variables, the data, and the transformations to reproduce the tidy data as shown in output file, “tidydata.txt”

# Identifier variables

The first two columns in the tidydata.txt, subject and activity, are used as identifier.

* subject

    ID of the test subject (30 volunteers), integer type, ranges 1-30
    
* activity

    ID of activity, character string, with one of the following values
    - `WALKING`: subject was walking
	- `WALKING_UPSTAIRS`: subject was walking upstairs
	- `WALKING_DOWNSTAIRS`: subject was walking downstairs
	- `SITTING`: subject was sitting
	- `STANDING`: subject was standing
	- `LAYING`: subject was laying 
	
# Measurement variables
* timeBodyAccelerometerMeanX
* timeBodyAccelerometerMeanY
* timeBodyAccelerometerMeanZ
* timeBodyAccelerometerStdX
* timeBodyAccelerometerStdY
* timeBodyAccelerometerStdZ
* timeGravityAccelerometerMeanX
* timeGravityAccelerometerMeanY
* timeGravityAccelerometerMeanZ
* timeGravityAccelerometerStdX
* timeGravityAccelerometerStdY
* timeGravityAccelerometerStdZ
* timeBodyAccelerometerJerkMeanX
* timeBodyAccelerometerJerkMeanY
* timeBodyAccelerometerJerkMeanZ
* timeBodyAccelerometerJerkStdX
* timeBodyAccelerometerJerkStdY
* timeBodyAccelerometerJerkStdZ
* timeBodyGyroscopeMeanX
* timeBodyGyroscopeMeanY
* timeBodyGyroscopeMeanZ
* timeBodyGyroscopeStdX
* timeBodyGyroscopeStdY
* timeBodyGyroscopeStdZ
* timeBodyGyroscopeJerkMeanX
* timeBodyGyroscopeJerkMeanY
* timeBodyGyroscopeJerkMeanZ
* timeBodyGyroscopeJerkStdX
* timeBodyGyroscopeJerkStdY
* timeBodyGyroscopeJerkStdZ
* timeBodyAccelerometerMagnitudeMean
* timeBodyAccelerometerMagnitudeStd
* timeGravityAccelerometerMagnitudeMean
* timeGravityAccelerometerMagnitudeStd
* timeBodyAccelerometerJerkMagnitudeMean
* timeBodyAccelerometerJerkMagnitudeStd
* timeBodyGyroscopeMagnitudeMean
* timeBodyGyroscopeMagnitudeStd
* timeBodyGyroscopeJerkMagnitudeMean
* timeBodyGyroscopeJerkMagnitudeStd
* frequencyBodyAccelerometerMeanX
* frequencyBodyAccelerometerMeanY
* frequencyBodyAccelerometerMeanZ
* frequencyBodyAccelerometerStdX
* frequencyBodyAccelerometerStdY
* frequencyBodyAccelerometerStdZ
* frequencyBodyAccelerometerJerkMeanX
* frequencyBodyAccelerometerJerkMeanY
* frequencyBodyAccelerometerJerkMeanZ
* frequencyBodyAccelerometerJerkStdX
* frequencyBodyAccelerometerJerkStdY
* frequencyBodyAccelerometerJerkStdZ
* frequencyBodyGyroscopeMeanX
* frequencyBodyGyroscopeMeanY
* frequencyBodyGyroscopeMeanZ
* frequencyBodyGyroscopeStdX
* frequencyBodyGyroscopeStdY
* frequencyBodyGyroscopeStdZ
* frequencyBodyAccelerometerMagnitudeMean
* frequencyBodyAccelerometerMagnitudeStd
* frequencyBodyAccelerometerJerkMagnitudeMean
* frequencyBodyAccelerometerJerkMagnitudeStd
* frequencyBodyGyroscopeMagnitudeMean
* frequencyBodyGyroscopeMagnitudeStd
* frequencyBodyGyroscopeJerkMagnitudeMean
* frequencyBodyGyroscopeJerkMagnitudeStd

## Produce HTML and PDF output files
```
library("rmarkdown")
rmarkdown::render("README.md",output_format = "all")
```