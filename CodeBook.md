 ## Project Description
This is a description of a solution to the course project of the course "Getting And Cleaning Data" 
offered by Johns Hopkins Bloomberg School of public health.


##Study design and data processing

###Collection of the raw data
- The data are signals recorded from an experiment measuring human activity recognition using smartphones.

- The experiment was conducted by:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
- The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


###Notes on the original (raw) data

####Information collected from the readme.txt file of the dataset.

**For each record of the original data set it is provided:**

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.

- Triaxial Angular velocity from the gyroscope. 

- A 561-feature vector with time and frequency domain variables.

- Its activity label.

- An identifier of the subject who carried out the experiment.

**The dataset includes the following files:**

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

**The following files are available for the train and test data. Their descriptions are equivalent.**

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

**Notes:**

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

**License:**

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
##Creating the tidy datafile

###Guide to create the tidy data file
1. Download the original data from: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
2. Extract the folder: "UCI HAR Dataset", and make sure your working directory is inside this folder.
3. Download the script file "run_analysis.R" which you can find in this repo.
4. Make sure you read the header comments of the file, about installing dependencies, or changing paths according to your operating system.
5. Using RStudio (preferred), or any R console, run the commands in the file "run_analysis.R".
6. After running the commands, you should find the final output dataset in your same working directory named "tidyData.txt"

###Cleaning of the data
The script reads the data, from different files, merges the training and test sets, as well as the subject and activity variables into one local data frame.
Then it removes the duplicated variables. Feature variables are then shorted to only those taken on mean or std. And it renames the variable and activity names into more meaningful names.
It then makes the data more tidy by applying the tidy data principles of ensuring there is only one variable per column, and one observation per row.
The script assumes that the feature consists of 2-3 variables, therefor it spreads the "Feature" column into 3 columns (Signal_Type, Estimate_Type, Direction)  [link to the readme document that describes the code in greater detail](https://github.com/bgooda/Getting_And_Cleaning_Data_Course_Project/blob/master/README.md)

##Description of the variables in the tidyData.txt file
- Dimensions of the dataset: 11880 observations, 6 variables.
- Data is grouped by Activity, Subject, and each of the variables.
- Average signal is calculated per each of the data groups.
- Variables present in the dataset: Activity, Subject, Signal_Type, Estimate_Type, Direction, Average_Signal.


###Variable #1: Activity
This variable describes the activity performed by the subject while signal is recorded, activities are:
Walking, Walking upstairs, Walking downstairs, Standing, Sitting, Laying.

Variable Information:

 - **Variable class:** Character
 - **Unique values/levels of the variable:** ("LAYING","SITTING","STANDING","Walking","Walking_DOWNSTAIRS","Walking_UPSTAIRS" )


###Variable #2: Subject
This variable describes the subject number (of 30 subjects conducting the experiment)

Variable Information:

 - **Variable class:** Integer
 - **Unique values/levels of the variable:** 1:30

###Variable #3: Signal_Type
This variable describes type of the recorded signal.

Variable Information:

 - **Variable class:** Character
 - **Unique values/levels of the variable:** ("fBodyAcc","fBodyAccJerk","fBodyAccMag","fBodyBodyAccJerkMag",
 - "fBodyBodyGyroJerkMag","fBodyBodyGyroMag","fBodyGyro","tBodyAcc","tBodyAccJerk","tBodyAccJerkMag",
   "tBodyAccMag","tBodyGyro","tBodyGyroJerk","tBodyGyroJerkMag","tBodyGyroMag","tGravityAcc","tGravityAccMag")

###Variable #4: Estimate_Type
This variable describes the estimate type of the signal: mean or std

Variable Information:

 - **Variable class:** Character
 - **Unique values/levels of the variable:** ("mean","std")

###Variable #5: Direction
This variable describes the direction of the signal: X, Y, Z. If signal direction is not applicable, it is recorded as a missing value.

Variable Information:

 - **Variable class:** Character
 - **Unique values/levels of the variable:** ("X","Y","Z",NA)

###Variable #6: Average_Signal
This variable describes the average signal per each variable.

Variable Information:

 - **Variable class:** numeric
