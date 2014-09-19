##Greetings there! This is a R script called run_analysis
##Written by SevenWatch
##First lets download the file.
##We create our data folder. 

##This checks to see if the folder data exists. If it doesnt then it will create it.
if(!file.exists("data")){
      dir.create("data")
}

##Now we can download it from the provided url into our folder
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile= "./data/dataset.zip")

##Now I feel like recording when I downloaded the file.
dateDownloaded <-date()
dateDownloaded
## "Mon Sep 15 18:30:50 2014" This is our date.



##Checking the requirements. I should code keeping in mind the files are ready in
##the working directory.
##Ok, now...since this assumes the data is already there, I will unzip it with Winrar.
##Extract files directly into our data folder. 
##We obtained a folder named UCI HAR Dataset. Do not rename the folder!



##Lets remember our prompts
##You should create one R script called run_analysis.R that does the following. 
## 1 Merges the training and the test sets to create one data set.
## 2 Extracts only the measurements on the mean and standard deviation for
##   each measurement. 
## 3 Uses descriptive activity names to name the activities in the data set
## 4 Appropriately labels the data set with descriptive variable names. 
## 5 From the data set in step 4, creates a second, independent tidy data set 
##   with the average of each variable for each activity and each subject.

##Well, I am at a loss. Anyway, a glance at the forums gives us this:
## https://class.coursera.org/getdata-007/forum/thread?thread_id=49 
## Thanks David Hood.

##STEP1
##Let's check our dimensions to see how to fit this data into one.
## This is like tetris.
##We start by reading all the different files and assigning them to objects
x <- "./data/UCI HAR Dataset/test/X_test.txt"
xtest <- read.table(x)

x <- "./data/UCI HAR Dataset/test/y_test.txt"
ytest <- read.table(x)

x <- "./data/UCI HAR Dataset/test/subject_test.txt"
stest <- read.table(x)

x <- "./data/UCI HAR Dataset/train/X_train.txt"
xtrain <- read.table(x)

x <- "./data/UCI HAR Dataset/train/y_train.txt"
ytrain <- read.table(x)

x <- "./data/UCI HAR Dataset/train/subject_train.txt"
strain <- read.table(x)


dim(xtest)
##[1] 2947  561
dim(ytest)
##[1] 2947    1
dim(stest)
##[1] 2947    1
dim(xtrain)
##[1] 7352  561
dim(ytrain)
##[1] 7352    1
dim(strain)
##[1] 7352    1

##According to our results. We will cbind xtest and ytest and stest
##We will also cbind xtrain ytrain and strain
##And then we will rbind the test and train sets.

datatest <- cbind(xtest, ytest, stest)
datatrain <- cbind(xtrain, ytrain, strain)
dataset <- rbind(datatest, datatrain)
## We got the last columns added named as V1. That can be troublesome.
colnames(dataset) <- c(1:563)
##Now it is better.



##STEP 2
##Ok. According to step 2. We need the data of means and standard deviations.
##We need to name our columns and we can do that with the features.txt.
x <- "./data/UCI HAR Dataset/features.txt" 
labels <- read.table(x) #we read the file
labels <- labels[, 2] ##here are the labels for the data variables
##BUT We have added two columns one with activity type and one with subject id
##We have to add them to our label list
labels <- c(as.character(labels), "activity", "subject")
##Now we pass the complete list as our new column names.
colnames(dataset) <- labels #we rename the columns.
##Now we have to examine the file features_info.txt to descipher which 
##columns we want to subset.I choose only variables with "mean()" and "std()"
##on their names. As for me these ones are reporting mean and standard deviation of
##the measured variables. 
##Going to StackOverflow
##http://stackoverflow.com/questions/18587334/subset-data-to-contain-only-columns-whose-names-match-a-condition

dataset2 <- dataset[ , grepl("mean()|std()" , names( dataset ) ) ]
colnames(dataset2)
##Looks likw we have some meanFreq intruders in our columns.
##Another helpful hints from stackoverflow
##http://stackoverflow.com/questions/7072159/how-do-you-remove-columns-from-a-data-frame
##http://stackoverflow.com/questions/4605206/drop-columns-r-data-frame
toremove <- dataset2[ , grepl("Freq", names(dataset2) ) ]
toremove <- colnames(toremove)
dataset2 <- dataset2[, !(colnames(dataset2) %in% toremove)]
morecol <- dataset[, c("activity", "subject")]
dataset <- cbind(dataset2, morecol)



##STEP 3
##According to step 3 I should rename the activity column values in the data set.
##we have numbers, we want a descriptive human readable value.
##Reading the activity_labels.txt 
##We have numbers and a name according to the number. Cool.
## Using the help from StackOverflow
## http://stackoverflow.com/questions/10002536/how-do-i-replace-numeric-codes-with-value-labels-from-a-lookup-table
##Okay, from the previous steps I know our column is named "activity"

##Now on the UCI HAR Dataset folder there is txt file named activity labels.
##We will load it and read it as a table.

x <- "./data/UCI HAR Dataset/activity_labels.txt"
activitylabels <- read.table(x)
##Here are the labels; 
activitylabels[, 2]
activity.code <- c(WALKING=1, WALKING_UPSTAIRS=2, WALKING_DOWNSTAIRS=3, 
                   SITTING=4,  STANDING=5, LAYING=6) 

dataset$activity <- names(activity.code)[match(dataset$activity, activity.code)]
##And that is it. No problem with orders since it matches each value with the 
##new one.


##STEP 4
## Appropriately labels the data set with descriptive variable names.
##What does this mean? It means all variable names (column names) 
##should be descriptive and human readable.
##as readable as this subject can be... 

colnames(dataset)
##Ugh.
##Okay, let's read features_info.txt for good measure.
##What I get with my poor knowledge is...
##t is for time
##Acc is for Acceleration
##Gyro is for Gyroscope
##Mag is for Magnitude 
##f is for FastFourierTransform
##Jerk is for the jerk signal
## XYZ are the axis.
##We have patterns. If there was only a way to replace...Oh
##http://rfunction.com/archives/2354
##Replace the first occurrence of a pattern with sub or 
##replace all occurrences with gsub.
varnames <- colnames(dataset)
varnames <- gsub("tBody", "TimeBody", varnames)
varnames <- gsub("fBody", "FastFourierBody", varnames)
varnames <- gsub("Acc", "Acceleration", varnames)
varnames <- gsub("Gyro", "Gyroscope", varnames)
varnames <- sub("activity", "ActivityLabel", varnames)
varnames <- gsub("subject", "subjectID", varnames)
varnames <- gsub("BodyBody", "Body", varnames)
varnames <- gsub("tGravity", "TimeGravity", varnames)
varnames <- gsub("Jerk", "JerkSignal", varnames)
varnames <- gsub("Mag", "Magnitude", varnames)

colnames(dataset) <- varnames
##summary(dataset)
##str(dataset)


## STEP 5 
##From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.
##http://stackoverflow.com/questions/3505701/r-grouping-functions-sapply-vs-lapply-vs-apply-vs-tapply-vs-by-vs-aggrega
##Aditional info
##Please upload the tidy data set created in step 5 of the instructions. 
##Please upload your data set as a txt file created with write.table() 
##using row.name=FALSE (do not cut and paste a dataset directly into the 
##text box, as this may cause errors saving your submission).
##http://www.r-bloggers.com/using-r-quickly-calculating-summary-statistics-from-a-data-frame/
##install.packages("plyr")
##install.packages("reshape")
library(plyr)
library(reshape2)

##We reshape the data so each measured variable turns into a row.
melted <- melt(dataset, id.vars=c("ActivityLabel", "subjectID"))

##If you check the data you will see that our columns are now in the rows
##as single obs and their calculated mean is next to them.
melted2 <- ddply(melted, c("ActivityLabel", "subjectID", "variable"), summarise,
      mean = mean(value))

##Now we have to write the table. Don't forget row.names=FALSE

write.table(melted2, file= "./data/newUCIHARdataset.txt", row.names=FALSE)
##WE ARE DONE. The file is located in the data folder with the original one.

##For Testing Purposes only
x <- "./data/newUCIHARdataset.txt"
test <- read.table(x, header = TRUE)
