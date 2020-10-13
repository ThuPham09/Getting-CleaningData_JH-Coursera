### CodeBook for the run_analysis.R script

# The run_analysis.R script processed: download dataset, perform all 5 requirements in the Getting and Cleaning Data Course Project.

## I _ Download and Read all datasets

Download - The data is downloaded in a zipped file format using the URL provided by the project, unzipped to the folder named UCI HAR Dataset.
Read all data: use the read.table function in the "reader" package. Data was named as their txt file names.
There are 6 datasets read in:
* activity_labels : 'data.frame':	6 obs. of  2 variables. List of all features.
* features: 'data.frame':	561 obs. of  2 variables. Links the class labels with their activity name.
* subject_test: 'data.frame':	2947 obs. of  1 variable. 
* X_test: 'data.frame':	2947 obs. of  561 variables. Test set. 
* y_test: 'data.frame':	2947 obs. of  1 variable.  Test labels.
* subject_train: 'data.frame':	7352 obs. of  1 variable. Each row identifies the subject who performed the activity for each window sample.
* X_train: 'data.frame':	7352 obs. of  561 variables. Training set. 
* y_train: 'data.frame':	7352 obs. of  1 variable. Training labels.


## II _ Project Assigement

# 1. Merges the training and the test sets to create one data set.

It is stated in the readme.txt: "The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data".  Therefore, these dataset will be boundagain by row.

* test.data: 'data.frame':	2947 obs. of  563 variables. This is data combined by collumn from 3 test datasets (X_test, y_test, subject_test).
* train.data: 'data.frame':	7352 obs. of  563 variables. This is data combined by collumn from 3 train datasets (X_train,y_train, subject_train).
* merged_data: 'data.frame':	10299 obs. of  563 variables. This is data combined by row from test datasets and train datasets.


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

The function select() was used along with contain() to extract only variable names contained "means" and "sd".
The extracted data named ectracted.data.
The data is 'data.frame', contained	10299 obs. of  88 variables.


# 3. Uses descriptive activity names to name the activities in the data set

ectracted.data: 'data.frame':	10299 obs. of  88 variables
ectracted.data$labels was changed from int (int  5 5 5 5 5 5 5 5 5 5 ...) to string (chr  "STANDING" "STANDING" "STANDING" "STANDING")

# 4. Appropriately labels the data set with descriptive variable names.

It is stated in the feature.info.txt:  
* The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
* These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
* Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
* Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
* Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

See the unique variable nammes by the unique() function.
Change 
"^t" to "Time", 
"^f" to "Frequency",  
"Acc" to "Accelerometer", 
"Gyro" to "Gyroscope, 
"BodyBody" to "Body", 
"Mag" to "Magnitude",
"BodyBody" to "Body",
"tBody" to "TimeBody"
".mean" to "_Mean"
".std" to "_StandardDeviation"
".freq" to "_Frequency"
"angle" to "Angle"
"gravity" to "Gravity"
"-" to "_" 
And check the colnames() function again to see the work done.

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Since we need to see the average of each variable for each activity and each subject, then using group_by() function for the ectracted.data for the 2 variables "activity" and "subject" will be appropridate.
Use summarise_all() function to sumarise for all variable in the dataset, with the function mean().
tidy.data is finally prepared with 180 observations and 88 variables. 



