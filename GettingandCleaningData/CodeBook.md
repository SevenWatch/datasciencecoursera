##Getting and Cleaning Data Course Project
##CodeBook

Welcome! This is my attempt at the Course Project. I am a newbie to R and all.
So keep that in mind if you find something done in a very crude way. 
I am still learning and advice on coding is always appreciated.

Anyway!


##Files related
*The readme markdown document: Instructions on how to acquire the data, packages used and references and hints used.

*The R script named run_analysis.R: contains all the code with commentary.

*This codebook markdown document: describes all the variables and data transformation.

*The new dataset in txt file.


##Getting the data.Describing the original data.
The data was obtained from the UCI HAR dataset folder containing the text files 
x_test.txt: containing all the measured variables (features) values for the test

y_test.txt containing all the activity ids for the test dataset values

subject_test.txt containing all the ids for the subjects in the test dataset

x_train.txt  containing all the measured variables values for the train

y_train.txt containing all the activity ids for the train dataset values

subject_train.txt  containing all the ids for the subjects in the test dataset

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals TimeAcceleration-XYZ and TimeGyroscope-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (TimeBodyAcceleration-XYZ and TimeGravityAcceleration-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (TimeBodyAccelerationJerkSignal-XYZ and TimeBodyGyroscopeJerkSignal-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (TimeBodyAccelerationMagnitude, TimeGravityAccelerationMagnitude, TimeBodyAccelerationJerkSignalMagnitude, TimeBodyGyroscopeMagnitude, TimeBodyGyroscopeJerkSignalMagnitude). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing FastFourierBodyAcceleration-XYZ, FastFourierBodyAccelerationJerkSignal-XYZ, FastFourierBodyGyroscope-XYZ, FastFourierBodyAccelerationJerkSignalMagnitude, FastFourierBodyGyroscopeMagnitude, FastFourierBodyGyroscopeJerkSignalMagnitude. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

TimeBodyAcceleration-XYZ
TimeGravityAcceleration-XYZ
TimeBodyAccelerationJerkSignal-XYZ
TimeBodyGyroscope-XYZ
TimeBodyGyroscopeJerkSignal-XYZ
TimeBodyAccelerationMagnitude
TimeGravityAccelerationMagnitude
TimeBodyAccelerationJerkSignalMagnitude
TimeBodyGyroscopeMagnitude
TimeBodyGyroscopeJerkSignalMagnitude
FastFourierBodyAcceleration-XYZ
FastFourierBodyAccelerationJerkSignal-XYZ
FastFourierBodyGyroscope-XYZ
FastFourierBodyAccelerationMagnitude
FastFourierBodyAccelerationJerkSignalMagnitude
FastFourierBodyGyroscopeMagnitude
FastFourierBodyGyroscopeJerkSignalMagnitude

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
TimeBodyAccelerationMean
TimeBodyAccelerationJerkSignalMean
TimeBodyGyroscopeMean
TimeBodyGyroscopeJerkSignalMean

*Taken and updated from the original features_info.txt in the data folder.

  
##Data Transformation

The different text file tables were combined according to their dimensions. Then the column names were named using the features.txt and two extra labels "activity" and "subject". Then subsetted the columns containing the word "mean()" and "std()" in their names, dropped the columns containing the word "Freq" and all other column variables. Combined the "activity" and "subject" column to the new data frame.

The "activity" column values were replaced from code numbers to descriptive values using the "activity_labels.txt"

Then all columns names were reassigned to complete as possible variable names.
From this data set a new independent tidy data set was created with the average of each variable for each activity and each subject.

##Variables (Features) in the new tidy data set variable column
(Levels From melted2$variable)

 [1] "TimeBodyAcceleration-mean()-X"                        
 [2] "TimeBodyAcceleration-mean()-Y"                        
 [3] "TimeBodyAcceleration-mean()-Z"                        
 [4] "TimeBodyAcceleration-std()-X"                         
 [5] "TimeBodyAcceleration-std()-Y"                         
 [6] "TimeBodyAcceleration-std()-Z"                         
 [7] "TimeGravityAcceleration-mean()-X"                     
 [8] "TimeGravityAcceleration-mean()-Y"                     
 [9] "TimeGravityAcceleration-mean()-Z"                     
[10] "TimeGravityAcceleration-std()-X"                      
[11] "TimeGravityAcceleration-std()-Y"                      
[12] "TimeGravityAcceleration-std()-Z"                      
[13] "TimeBodyAccelerationJerkSignal-mean()-X"              
[14] "TimeBodyAccelerationJerkSignal-mean()-Y"              
[15] "TimeBodyAccelerationJerkSignal-mean()-Z"              
[16] "TimeBodyAccelerationJerkSignal-std()-X"               
[17] "TimeBodyAccelerationJerkSignal-std()-Y"               
[18] "TimeBodyAccelerationJerkSignal-std()-Z"               
[19] "TimeBodyGyroscope-mean()-X"                           
[20] "TimeBodyGyroscope-mean()-Y"                           
[21] "TimeBodyGyroscope-mean()-Z"                           
[22] "TimeBodyGyroscope-std()-X"                            
[23] "TimeBodyGyroscope-std()-Y"                            
[24] "TimeBodyGyroscope-std()-Z"                            
[25] "TimeBodyGyroscopeJerkSignal-mean()-X"                 
[26] "TimeBodyGyroscopeJerkSignal-mean()-Y"                 
[27] "TimeBodyGyroscopeJerkSignal-mean()-Z"                 
[28] "TimeBodyGyroscopeJerkSignal-std()-X"                  
[29] "TimeBodyGyroscopeJerkSignal-std()-Y"                  
[30] "TimeBodyGyroscopeJerkSignal-std()-Z"                  
[31] "TimeBodyAccelerationMagnitude-mean()"                 
[32] "TimeBodyAccelerationMagnitude-std()"                  
[33] "TimeGravityAccelerationMagnitude-mean()"              
[34] "TimeGravityAccelerationMagnitude-std()"               
[35] "TimeBodyAccelerationJerkSignalMagnitude-mean()"       
[36] "TimeBodyAccelerationJerkSignalMagnitude-std()"        
[37] "TimeBodyGyroscopeMagnitude-mean()"                    
[38] "TimeBodyGyroscopeMagnitude-std()"                     
[39] "TimeBodyGyroscopeJerkSignalMagnitude-mean()"          
[40] "TimeBodyGyroscopeJerkSignalMagnitude-std()"           
[41] "FastFourierBodyAcceleration-mean()-X"                 
[42] "FastFourierBodyAcceleration-mean()-Y"                 
[43] "FastFourierBodyAcceleration-mean()-Z"                 
[44] "FastFourierBodyAcceleration-std()-X"                  
[45] "FastFourierBodyAcceleration-std()-Y"                  
[46] "FastFourierBodyAcceleration-std()-Z"                  
[47] "FastFourierBodyAccelerationJerkSignal-mean()-X"       
[48] "FastFourierBodyAccelerationJerkSignal-mean()-Y"       
[49] "FastFourierBodyAccelerationJerkSignal-mean()-Z"       
[50] "FastFourierBodyAccelerationJerkSignal-std()-X"        
[51] "FastFourierBodyAccelerationJerkSignal-std()-Y"        
[52] "FastFourierBodyAccelerationJerkSignal-std()-Z"        
[53] "FastFourierBodyGyroscope-mean()-X"                    
[54] "FastFourierBodyGyroscope-mean()-Y"                    
[55] "FastFourierBodyGyroscope-mean()-Z"                    
[56] "FastFourierBodyGyroscope-std()-X"                     
[57] "FastFourierBodyGyroscope-std()-Y"                     
[58] "FastFourierBodyGyroscope-std()-Z"                     
[59] "FastFourierBodyAccelerationMagnitude-mean()"          
[60] "FastFourierBodyAccelerationMagnitude-std()"           
[61] "FastFourierBodyAccelerationJerkSignalMagnitude-mean()"
[62] "FastFourierBodyAccelerationJerkSignalMagnitude-std()" 
[63] "FastFourierBodyGyroscopeMagnitude-mean()"             
[64] "FastFourierBodyGyroscopeMagnitude-std()"              
[65] "FastFourierBodyGyroscopeJerkSignalMagnitude-mean()"   
[66] "FastFourierBodyGyroscopeJerkSignalMagnitude-std()" 


##Units
Clarification: I did not forget to add the units. I just have no idea what the units are. I will attempt to understand and say that all variables starting with "Time" have time units (seconds?) and "FastFourier" ones have frequency units 
(Hz).

##New file
And finally the script writes the new dataset as a text file with the name "newUCIHARdataset.txt" on the following location "./data/newUCIHARdataset.txt"


And that is it. Many thanks to everyone at Coursera forums and StackOverflow.

I hope this makes sense to you reading this! 


-SevenWatch
