##Getting and Cleaning Data Course Project


Welcome! This is my attempt at the Course Project. I am a newbie to R and all.
So keep that in mind if you find something done in a very crude way. 
I am still learning and advice on coding is always appreciated.

Anyway!


##Files related
*This readme markdown document: Instructions on how to acquire the data, packages used and references and hints used.

*The R script named run_analysis.R: contains all the code with commentary.

*The codebook markdown document: describes all the variables and data transformation.

*The new dataset in txt file.


##Getting the data.
You will have to manually download the data from this url:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Save it on a file directory named "data" inside your working directory. 
(i.e "yourworkingdirectory/data/UCIHARDataset.zip")

Alternatively you can run the following code in R to make sure everything is where it whould be.

>if(!file.exists("data")){
>      dir.create("data")
>      }
>
>fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20>HAR%20Dataset.zip"
>
>download.file(fileUrl, destfile= "./data/dataset.zip")

Unzip the file using your preferred software. 


##Installing required packages.

To run the script you will have to install the following packages if you haven't
>install.packages("plyr")
>install.packages("reshape2")
Installing the plyr package can take some time.
The loading into R is included in the script.


##Run the script.

Just run all the script and wait. 
You will find the new data in "./data/newUCIHARdataset.txt"

##How does it work?

The script is divided in the five steps required and filled with documentary.

During STEP 1 it reads all the necessary data text files,loads them into data frames, and combines them using cbind and rbind functions.

During STEP 2 it renames the columns of the dataset using the names contained in features.txt and two extra labels "activity" and "subject" not contained in the file. This is assigned as the column names of our dataset using the function colnames. Later, it subsets all variables whose names contain the words "mean()" or "std()" into a new dataset and then removes those which include "Freq" in the variable names. Finally it cbinds the new dataset with the previous "activity" and "subject" columns in the dataset.

During STEP 3 it reads the "activity_labels.txt", then it creates the object which contains the code for the activities and then it rewrite the dataset activity column using the names and match function.

During STEP 4 it uses the function gsup to replace all abbreviations in the variable names for better human readable ones and stores it in the object "varnames", then it assigns the object to the colnames of the dataset.

During STEP 5, it loads the packages of "plyr" and "reshape2". Then it reshapes the dataset using the function melt.  Melt will take all the columns except the ones we single out as id variables and put them in the same column. The resulting dataset now contains a single column for the variables and the  value. After that it runs the function "ddply" from "plyr" to automatically apply a calculation (in this case the mean) to all the subsets we're interested in. And assign it to a new dataset.
And finally it will run the function "write.table" to write our new dataset as a text file with the name "newUCIHARdataset.txt" on the following location "./data/newUCIHARdataset.txt"


##Reading the new file
If you want to read the new file, you can run the following code.

>x <- "./data/newUCIHARdataset.txt"
>
>newdataset <- read.table(x, header = TRUE)


##About the script.

This script was created using R version 3.0.3 (2014-03-06) -- "Warm Puppy"

I could have not finished this, without the help from various sources.

*Figuring out how to start the project: 
[David Hood at Coursera](https://class.coursera.org/getdata-007/forum/thread?thread_id=49)

*Getting only the columns with mean and std :
[StackOverflow](http://stackoverflow.com/questions/18587334/subset-data-to-contain-only-columns-whose-names-match-a-condition
)

*Getting rid of certain columns:
[StackOverflow](http://stackoverflow.com/questions/7072159/how-do-you-remove-columns-from-a-data-frame) [StackOverflow](http://stackoverflow.com/questions/4605206/drop-columns-r-data-frame)

*Hints to rename the activity labels:
[StackOverflow](http://stackoverflow.com/questions/10002536/how-do-i-replace-numeric-codes-with-value-labels-from-a-lookup-table)

*Getting help renaming the variable names:
[rfunction.com](http://rfunction.com/archives/2354)

*Use of dplyr and reshape2 to getting the tidy data for the last step
[r-bloggers](http://www.r-bloggers.com/using-r-quickly-calculating-summary-statistics-from-a-data-frame/)

And that is it. Many thanks to everyone at Coursera forums and StackOverflow.

I hope this makes sense to you reading this! 


-SevenWatch
