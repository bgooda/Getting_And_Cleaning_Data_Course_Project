#Loading "dplyr" & "tidyr" packages.
#Use install.packages("dplyr"); install.packages("tidyr"); if not already installed.
library(dplyr); library(tidyr)
# The following script assumes the script file is located inside the project data directory.
# The path syntax used is for windows, if you wish to run the script on a linux/mac machine,
# Please modify the path and replace "\\" with "/".


# Reading Activity label file, converting it into a local data frame, and renaming the columns.
activity_labels <- read.table("activity_labels.txt")
activity_labels <- tbl_df(activity_labels)
names(activity_labels) <- c("Num","Activity")

#Reading the feature list, converting it into a local data frame, and renaming columns.
features <- read.table("features.txt")
features <- tbl_df(features)
names(features) <- c("Num","Feature")

#Reading Test data, converting it into local data frame.
testData <- read.table("test\\X_test.txt")
testData <- tbl_df(testData)

#Reading Training data, converting it into local data frame.
trainData <- read.table("train\\X_train.txt")
trainData <- tbl_df(trainData)

#Row Binding test and train data into one data frame.
mergedData <- bind_rows(testData,trainData)

#Renaming mergedData columns to representative feature names.
names(mergedData) <- features$Feature

#Reading subjects for test data. converting it into local data frame. Renaming column.
subjectTest <- read.table("test\\subject_test.txt")
subjectTest <- tbl_df(subjectTest)
names(subjectTest) <- "Subject"

#Reading subjects for train data. converting it into local data frame. Renaming column.
subjectTrain <- read.table("train\\subject_train.txt")
subjectTrain <- tbl_df(subjectTrain)
names(subjectTrain) <- "Subject"

#Row Binding of the subject data into one data frame
mergedSubjects <- bind_rows(subjectTest,subjectTrain)

#Column Binding of subjects to the mergedData.
mergedData <- bind_cols(mergedSubjects,mergedData)

#Reading activity test data, converting it into local data frame, renaming the column
activityTest <- read.table("test\\y_test.txt")
activityTest <- tbl_df(activityTest)
names(activityTest) <- "Activity"

#Reading activity train data, converting it into local data frame, renaming the column
activityTrain <- read.table("train\\y_train.txt")
activityTrain <- tbl_df(activityTrain)
names(activityTrain) <- "Activity"

#Row Binding of the activity data into one data frame
mergedActivities <- bind_rows(activityTest,activityTrain)

#Column Binding of activities to the mergedData. 
mergedData <- bind_cols(mergedActivities,mergedData)

#Replacing activity numbers with activity names in all data
mergedData$Activity[mergedData$Activity == 1] <- 'Walking'
mergedData$Activity[mergedData$Activity == 2] <- 'Walking_UPSTAIRS'
mergedData$Activity[mergedData$Activity == 3] <- 'Walking_DOWNSTAIRS'
mergedData$Activity[mergedData$Activity == 4] <- 'SITTING'
mergedData$Activity[mergedData$Activity == 5] <- 'STANDING'
mergedData$Activity[mergedData$Activity == 6] <- 'LAYING'

#Removing duplicate column names in data.
mergedData <- mergedData[ !duplicated(names(mergedData)) ]

#Subsetting Data to only include variables which are means or standard deviations.
mergedData <- mergedData %>% select(Subject, Activity,contains("mean()"), contains("std()"))

#Tidying Data!

#Melting all feature variables into two key and value variables, using tidyr::gather().
tidyData <- mergedData %>% gather("Feature", "Signal",3:68)

# I considered the "Feature" column to contain multiple variables, since it contains:
# "Feature Type", "Estimate Type" and "Direction" in some cases.
# I used tidyr::spread() to spread the "Feature" column  into 3 variables.
tidyData <- separate(tidyData, Feature, c("Singal Type","Estimate Type","Direction"))

# The above operation resulted in some empty strings in the "Direction" variable,
# Since not all features are specific to a direction.
# I decided to replace the empty strings with NAs for easier future data manipulation.
tidyData$Direction[tidyData$Direction == ""] <- NA

# Finally this is how I write the final tidy dataset, into a file named: "tidyData.txt"
write.table(tidyData, file = "tidyData.txt", row.names = FALSE, col.names = FALSE)

# Running the above script should produce the same dataset attached to the project submission.

