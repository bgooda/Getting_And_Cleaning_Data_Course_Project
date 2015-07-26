#Getting and Cleaning Data Course Project

##Introduction
This readme file, explains how to read the output data, run the script "run_analysis.R" to reproduce the data.
And how the script works.

##Reading output data
If you have downloaded the output tidy data file ("tidyData.txt") of the script, and you want to read it directly, use the following commands.
```{r}
library(dplyr)
tidyData <- read.table("tidtData.txt") %>% tbl_df
names(tidyData) <- c("Activity","Subject","Signal_Type","Estimate_Type","Direction","Average_Signal")
```
##Running the script
1. Download the original data from: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
2. Extract the folder: "UCI HAR Dataset", and make sure your working directory is inside this folder.
3. Download the script file "run_analysis.R" which you can find in this repo.
4. Make sure you read the header comments of the file, about installing dependencies, or changing paths according to your operating system.
5. Using RStudio (preferred), or any R console, run the commands in the file "run_analysis.R".
6. After running the commands, you should find the final output dataset in your same working directory named "tidyData.txt"

##How the script works!
1. It reads Activity label file ("activity_labels.txt"), converting it into a local data frame, and renaming the columns.
2. It reads the feature list ("features.txt"), converting it into a local data frame, and renaming columns.
3. It reads the Test data ("test\\X_test.txt"), converting it into local data frame.
4. It reads the Training data ("train\\X_train.txt"), converting it into local data frame.
5. Row Binding test and train data into one data frame (mergedData).
6. Renaming mergedData columns to representative feature names, from ("features.txt").
7. Reading subjects for test data ("test\\subject_test.txt"). converting it into local data frame. Renaming column to "Subject".
8. Reading subjects for train data ("train\\subject_train.txt"). converting it into local data frame. Renaming column to "Subject".
9. Row Binding of the subject data into one data frame.
10. Column Binding of subjects to the mergedData.
11. Reading activity test data ("test\\y_test.txt"), converting it into local data frame, renaming the column to "Activity".
12. Reading activity train data ("train\\y_train.txt"), converting it into local data frame, renaming the column to "Activity".
13. Row Binding of the activity data into one data frame.
14. Column Binding of activities to the mergedData.
15. Replacing activity numbers with activity names in mergedData. (ex. 1: WALKING, 6: LAYING, etc.).
16. Removing duplicate column names in mergedData.
17. Subsetting Data to only include variables which are means or standard deviations.
18. Melting all feature variables into two key and value variables ("Feature","Signal"), using tidyr::gather().
19. I considered the "Feature" column to contain multiple variables, since it contains: "Feature Type", "Estimate Type, "Direction".
20. Used tidyr::spread() to spread the "Feature" column  into 3 variables ("Signal_Type","Estimate_Type","Direction").
21. The above operation resulted in some empty strings in the "Direction" variable, Since not all features are specific to a direction.
22. Replacing the empty strings with NAs for easier future data manipulation.
23. group the data by Activity, Subject and each variable (Signal_Type, Estimate_Type and Direction).
24. Applying the dply::summarize() function to the grouped dataset, by calling the mean on the "Signal" variable. Naming the average variable "Average_Signal".
25. Final tidy data set is called "tidyDataFinal".
26. Writing the final tidy dataset, into a file named: "tidyData.txt".
