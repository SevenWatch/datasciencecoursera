##Greetings there! This is a R script called run_analysis
##It has been written by SevenWatch.

##Please read the ReadMe file and the codebook before running the code.
##You will have to download the file and read it according to the instructions.

##I will warn you again. I am a noob in R. I am sure I have done things in a 
##crude manner...And you probably have a more elegant and faster solution.
##Be gentle. You are welcome to share ways to improve my code~

##For a more blabberish filled script check Testing.R 

##STEP 1
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

##According to the dimensions. We will cbind xtest and ytest and stest
##We will also cbind xtrain ytrain and strain
##And then we will rbind the test and train sets.

datatest <- cbind(xtest, ytest, stest)
datatrain <- cbind(xtrain, ytrain, strain)
dataset <- rbind(datatest, datatrain)


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
##Now we have to examine the file features_info.txt to decipher which 
##columns we want to subset.I choose only variables with "mean()" and "std()"
##on their names. As for me these ones are reporting mean and standard deviation of
##the measured variables. 


dataset2 <- dataset[ , grepl("mean()|std()" , names( dataset ) ) ]
colnames(dataset2)
##Looks likw we have some meanFreq intruders in our columns.

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

## STEP 5 
##From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.
##Aditional info
##Please upload the tidy data set created in step 5 of the instructions. 
##Please upload your data set as a txt file created with write.table() 
##using row.name=FALSE (do not cut and paste a dataset directly into the 
##text box, as this may cause errors saving your submission).
##install.packages("plyr")
##install.packages("reshape")
library(plyr)
library(reshape2)

##We reshape the data so each measured variable turns into a row.
melted <- melt(dataset, id.vars=c("ActivityLabel", "subjectID"))

##If you check the data you will see that our columns are now in the rows
##as single observations and their calculated mean is next to them AND
##they are separated by activity and subject.
##The new format follows the one observation per row.
melted2 <- ddply(melted, c("ActivityLabel", "subjectID", "variable"), summarise,
                 mean = mean(value))

##Now we have to write the table. Don't forget row.names=FALSE

write.table(melted2, file= "./data/newUCIHARdataset.txt", row.names=FALSE)
##WE ARE DONE. The file is located in the data folder with the original one.
