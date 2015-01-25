## This is the script run_analysis.R for the Getting and Cleaning Data Course
## Project.
##
## This script does the following:
##    1) Merges the training and the test sets to create one data set.
##    2) Extracts only the measurements on the mean and standard deviation for 
##       each measurement. 
##    3) Uses descriptive activity names to name the activities in the data set
##    4) Appropriately labels the data set with descriptive variable names. 
##    5) From the data set in step 4, creates a second, independent tidy data 
##       set with the average of each variable for each activity and each 
##       subject.
## 

## Loading library dplyr
library(dplyr)

## Reading the Train files
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Reading the Test files
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## Appending the Subject and Activity columns to the Train set
train <- cbind(subject_train, y_train, X_train)

## Appending the Subject and Activity columns to the Test set
test <- cbind(subject_test, y_test, X_test)

## Appending the rows from the new extended Train and Test sets obtained in 
## the previous steps (so including the Subject and the Activity in the first 
## two columns and getting a full set)
full_set <- rbind(train, test)


## Loading the features file, that has two columns
features <- read.table("./UCI HAR Dataset/features.txt")

## Renaming the full_set names with "Subject", "Activity" and the names of the
## features in the second column of the table "features"
names(full_set) <- as.vector(c("subject", "activity", as.vector(features$V2)))


## Creating a logical vector for subsetting the full_set columns. 
## We select only the features containing mean() and std(), so searching "mean"
## and "std" lower case and getting rid of "meanFreq".
col_sel <- grepl("subject",names(full_set)) | 
           grepl("activity",names(full_set)) | 
           grepl("std",names(full_set)) |
           (grepl("mean",names(full_set)) & !grepl("meanFreq",names(full_set)))

## We get 68 Columns, one for "Subject", one for "Activity" and 66 for Features
## sum(col_sel)
## [1] 68

## Subsetting the full_set columns to get "activity", "subject" and only mean()
## and std() features
mean_std_set <- full_set[, col_sel]

## We get 10299 observations/rows and 68 variables/columns
## dim(mean_std_set)
## [1] 10299    68


## Appropriately labelling the data set with descriptive variable names.
## We have to correct some errors in the original "features.txt" file
## as for instance "BodyBody", that is repeating "Body" twice.
## Moreover, we have to get rid of the forbidden symbols as "-", "(", ")", what
## is done in the first "gsub" sentence
## We have selected camelCase naming standard.
x <- names(mean_std_set)

        x <- gsub("[[:punct:]]", "", x)
        x <- gsub("mean", "Mean", x)
        x <- gsub("std", "StandardDeviation", x)
        x <- gsub("BodyBody", "Body", x)
        x <- gsub("tBody", "timeBody", x)
        x <- gsub("tGravity", "timeGravity", x)
        x <- gsub("fBody", "frequencyBody", x)
        x <- gsub("Acc", "Acceleration", x)
        x <- gsub("Gyro", "Gyroscope", x)
        x <- gsub("Mag", "Magnitude", x)

names(mean_std_set) <- x


## Loading Activity Labels file to use the descriptive activity names in the 
## second column to name the activities in the current "mean_std_set" data set
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Merging to add the Activity names to the current data set as a new column
merged <- merge(mean_std_set, activity_labels,
                by.x="activity", by.y="V1", 
                all="TRUE")

## Replacing the "activity" column with the new column added with the activity 
## names
merged[,"activity"] <- merged[,"V2"]

## Subsetting columns to get rid of the last column added. Here we get our first
## tidy data set
tidy_1 <- merged[, 1:ncol(merged)-1]

## We get 10299 observations/rows and 68 variables/columns
## dim(tidy_1)
## [1] 10299    68


## Aggregating to get an independent tidy data set with the average of each 
## variable for each activity and each subject.
tidy_2 <- aggregate(tidy_1[,3:ncol(tidy_1)], 
                   list(activity = tidy_1$activity, subject = tidy_1$subject), 
                   mean)

## Adapting the variable names for this new tidy data set, because the variables 
## from column 3 to column 68 are now Averages. We are pasting "Average" at the 
### end of the name for those variable names.
qq <- names(tidy_2)
names(tidy_2) <- c(qq[1], qq[2], paste(qq[3:length(qq)],"Average", sep=""))

## Moreover, we also sort this data set by activity/subject.
## This is the final tidy data set to be submitted in the Course Project.
tidy_data_set <- arrange(tidy_2, activity, subject)

## We get 68 variables/columns and 180 observations/rows, as expected, because
## we have: (6 Activities) x (30 Subjects) = 180 Observations.
## We can see this with the dim function:
## dim(tidy_data_set)
## [1] 180  68


## Writting the table to the working directory
write.table(tidy_data_set, "./tidy_data_set.txt", row.name=FALSE)

## To load this file into R and easily view the data, you can use the following 
## commands:
## data <- read.table("./tidy_data_set.txt", header = TRUE) 
## View(data)
