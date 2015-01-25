# Code Book for the Course Project

This is the Code Book that describes the variables, the data and any transformations or work performed to clean up the data within the "Getting and Cleaning Data" Course Project. 


## Index  

- Introduction  
- Original Data: Variables description  
- Transformations of the data to get tidy data sets  
- Final tidy data sets: Variables description  


## Introduction

As described in the Course Project Assignment, one of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained, that is the following URL:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original data for the Course Project can be downloaded in a zip file called "getdata-projectfiles-UCI HAR Dataset.zip" from the following URL:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## Original Data: Variables description

Inside the downloaded zip file "getdata-projectfiles-UCI HAR Dataset.zip" there are two files where the original data files, their variables and their structure are explained:  

1. README.txt  
2. features_info.txt  

We think it is not worth reproducing here just the same information and get a larger Code Book, but we strongly recommend you to read these two files and navigate through the original data files to understand this original data set. This is a basic background for the following sections in this Code Book.

Moreover, We need to reference the work and the authors of this study, referencing their publication [1]:

        [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.


## Transformations of the data to get tidy data sets


#### Loading Training and Test data

First of all, we load the Training set files into R:   

- **X_train**: 7352 observations of 561 variables, the Features.   
- **y_train**: 7352 observations of 1 variable, the Activity.   
- **subject_train**: 7352 observations of 1 variable, the Subject.   

Secondly, we load the Test set files into R:  

- **X_test**: 2947 observations of 561 variables, the Features.  
- **y_test**: 2947 observations of 1 variable, the Activity.  
- **subject_test**: 2947 observations of 1 variable, the Subject.  


#### Appending the Training and the Test sets to get a full set

We append the Subject Training Column **subject_train** and the Activity Training Column **y_train** to the Features Training set **X_train**, obtaining a unique Training data set called **train**.

We do the same for the Test set: We append the Subject Test Column **subject_test** and the Activity Test Column **y_test** to the Features Test set **X_test**, obtaining a unique Test data set called **test**.

These new **train** and **test** data sets have the Subject, Activity and the 561 Features as columns.

- **train**: 7352 observations of 563 variables
- **test**: 2947 observations of 563 variables

*Remark*: We are not adding the data available in the "Inertial Signals" folders to these new data sets because it is original data direclty measured from the smartphone, that has been used to compute the 561 features we have already considered in the data sets.  
Moreover, later on in this Project, we are requested to extract only the measurements on the mean and standard deviation for each measurement, and these columns/variables are contained in the 561 Features already considered.  

Now we append the rows from **train** to the rows of **test** and we get a full unique set called **full_set**, with the following dimensions:

- **full_set**: 10299 observations of 563 variables

#### Extracting only the measurements on the mean and standard deviation for each measurement.

We load the features names into R and we use them to initially label the the **full_set** variables, together with "subject" and "activity" for the Subject and Activity columns.

Once we have named the **full_set** variables, we use that to extract only the measurements on the mean and standard deviation for each measurement.

To get this, we create a logical vector for subsetting the **full_set** columns. We select and extract the Variables "subject" and "activity", together with the features containing "mean()" and "std()", so searching "mean" and "std" lower case and getting rid of "meanFreq".

*Remark*: There are more features having the word "mean" or "Mean" in the list of 561 features as, for instance:  

- The ones containing the word "meanFreq", that means "Weighted average of the frequency components to obtain a mean frequency".  
- The ones used in combination with the "angle() Variable", for instance: angle(tBodyAccMean,gravity), angle(tBodyAccJerkMean),gravityMean), angle(tBodyGyroMean,gravityMean), angle(tBodyGyroJerkMean,gravityMean), angle(X,gravityMean), angle(Y,gravityMean), angle(Z,gravityMean).  

As it seems these are not means of direct measurements from the Smartphone, we are excluding them from the selection.

Applying this, we get the data set **mean_std_set** with:  

- 68 variables/columns (2 columns for "subject" and "activity" and 66 columns for the mean and standard deviation features)  
- 10299 observations  


#### Labelling the data with descriptive variable names.

We are following *camelCase* standard for naming the Variables because they are very long names, but trying to get them as much meaningful as possible.

To get good descriptive variable names, we have to do several changes in the variable names of the data set **mean_std_set**. These changes are the following:  

- We have to get rid of the forbidden symbols as "-", "(", ")", so we are replacing them by "".  
- We have to correct some errors in the original "features.txt" file as for instance "BodyBody", that is repeating "Body" twice, so we are replacing "BodyBody" by "Body"  
- We are replacing "mean" by "Mean"  
- We are replacing "std" by "StandardDeviation"  
- We are replacing "tBody" by "timeBody"  
- We are replacing "tGravity" by "timeGravity"  
- We are replacing "fBody" by "frequencyBody"  
- We are replacing "Acc" by "Acceleration"  
- We are replacing "Gyro" by "Gyroscope"  
- We are replacing "Mag" by "Magnitude"  

Once applied this, we have the data set **mean_std_set** with descriptive names following *camelCase* standard.


#### Using descriptive activity names to name the activities in the data set

First of all, we load the Activity Labels file into R, that relates every Activity ID with the corresponding Activity Name. This data set is called **activity_labels**

Then we merge our data set **mean_std_set** with the Activity Labels data set **activity_labels**. This is done matching both files by the Activity ID, that is the current "activity" coluimn in **mean_std_set** and the first column in **activity_labels**.

Then we get a new dataset called **merged**, with an extra column at the end with the correspondent Activity Name, having:  

- 69 columns  
- 10299 observations  

We use this last column added to replace the "activity" column, getting that informed with the Activity Names, instead of the Activity ID. These Activity Names are fully descriptive by themselves, so we don't consider any further manipulation.

Once we have done this, we have the Activity Names in two columns of the data set **merged**, so we need to extract the first 68 columns, getting rid of the last one, and we get the data set **tidy_1**.

This is an important step, as the data set **tidy_1** is the first tidy data set that we get in the process, because it has:  

- 10299 rows, each one for one observation.  
- 68 columns, each one for one variable.  
- Descriptive Variable Names  
- Descriptive Activity Names


#### Aggregating to get an independent tidy data set with the average of each variable for each activity and each subject.

Now we get an independent tidy data set called **tidy_data_set** from the previous data set **tidy_1**, with the average of each variable/feature for each activity and each subject.

So, the data set **tidy_data_set** has:  

- 180 observations, as we have (6 Activities) x (30 Subjects) = (180 Observations)  
- 68 variables

As the variables are "Averages" now, we slightly modify the column names for the last 66 columns in the **tidy_data_set**, just adding "Average" at the end of each column name.

Moreover, we sort the data set **tidy_data_set** by activity/subject, to have a more comprehensive reading of the data set.

Finally, applying all of this, the data set **tidy_data_set** is the tidy data set requested in the 5th step of the Course Project, because it has:  

- 180 rows, each one for one observation.  
- 68 columns, each one for one variable.  
- Descriptive Variable Names  
- Descriptive Activity Names  
- Sorted by activity/subject  

In order to submit this tidy data set in the Course Project, we write the data set into the file "tidy_data_set.txt", what is created in your working directory (please also read the "README.md" file in the Repository).

To load this file into R and easily view the data, you can use the following commands:  

        data <- read.table("./tidy_data_set.txt", header = TRUE)  
        View(data)

## Final tidy data sets: Variables description

In this section, we are going to describe the Variables for the tidy data sets obtained:  

- **tidy_1** data set  
- **tidy_data_set** data set

*REMARK 1*  
To do this in a proper "smart" way, just to remark that the variables in **tidy_data_set** are averages for each activity and each subject of the variables in the **tidy_1** data set.

For instance, if we have a variable (feature) of **tidy_1** named "xxxXYyyyZzzz", the corresponding variable in the **tidy_data_set** will be named "xxxXYyyyZzzzAverage"

So, if we have the description for the variable "xxxXYyyyZzzz" in the **tidy_1** data set, the description for "xxxXYyyyZzzzAverage" in the **tidy_data_set** will be "The Average of the variable xxxXYyyyZzzz in the data set **tidy_1** for each activity and each subject", where we can apply the description of "xxxXYyyyZzzz" to complete the sentence.

Once said this, we are going to only describe the Variables for the tidy data set **tidy_1**, because the ones for **tidy_data_set** can be obtained as explained above.

*REMARK 2*  
As stated by the Authors of the study, the Features are normalized and bounded within [-1,1], so they are unitless. This applies to all the columns in our tidy data sets out of the columns "activity" and "subject".

The Variables in our tidy data set **tidy_1** are:

 1. "activity"  
                - Description: Activity performed by the Subject  
                - Values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING  
                
 2. "subject"  
                - Description: Subject that performs the Activity  
                - Values: Integers from 1 to 30  
 
 3. "timeBodyAccelerationMeanX"  
                - Description: Time Body Acceleration - Mean - X axis  
                - Values: Numeric Values  
                
 4. "timeBodyAccelerationMeanY"  
                - Description: Time Body Acceleration - Mean - Y axis  
                - Values: Numeric Values  
 
 5. "timeBodyAccelerationMeanZ"              
                - Description: Time Body Acceleration - Mean - Z axis  
                - Values: Numeric Values  
                
 6. "timeBodyAccelerationStandardDeviationX"  
                - Description: Time Body Acceleration - Standard Deviation - X axis  
                - Values: Numeric Values  
                
 7. "timeBodyAccelerationStandardDeviationY"              
                - Description: Time Body Acceleration - Standard Deviation - Y axis  
                - Values: Numeric Values  
                
 8. "timeBodyAccelerationStandardDeviationZ"                 
                - Description: Time Body Acceleration - Standard Deviation - Z axis  
                - Values: Numeric Values  
                
 9. "timeGravityAccelerationMeanX"                      
                - Description: Time Gravity Acceleration - Mean - X axis  
                - Values: Numeric Values  
                
10. "timeGravityAccelerationMeanY"                           
                - Description: Time Gravity Acceleration - Mean - Y axis  
                - Values: Numeric Values  
                
11. "timeGravityAccelerationMeanZ"                           
                - Description: Time Gravity Acceleration - Mean - Z axis  
                - Values: Numeric Values  
                
12. "timeGravityAccelerationStandardDeviationX"      
                - Description: Time Gravity Acceleration - Standard Deviation - X axis  
                - Values: Numeric Values  
                
13. "timeGravityAccelerationStandardDeviationY"      
                - Description: Time Gravity Acceleration - Standard Deviation - Y axis  
                - Values: Numeric Values  
                
14. "timeGravityAccelerationStandardDeviationZ"           
                - Description: Time Gravity Acceleration - Standard Deviation - Z axis  
                - Values: Numeric Values  
                
15. "timeBodyAccelerationJerkMeanX"      
                - Description: Time Body Acceleration Jerk - Mean - X axis  
                - Values: Numeric Values  
                
16. "timeBodyAccelerationJerkMeanY"      
                - Description: Time Body Acceleration Jerk - Mean - Y axis  
                - Values: Numeric Values  
                
17. "timeBodyAccelerationJerkMeanZ"      
                - Description: Time Body Acceleration Jerk - Mean - Z axis  
                - Values: Numeric Values  
                
18. "timeBodyAccelerationJerkStandardDeviationX"             
                - Description: Time Body Acceleration Jerk - Standard Deviation - X axis  
                - Values: Numeric Values  
                
19. "timeBodyAccelerationJerkStandardDeviationY"             
                - Description: Time Body Acceleration Jerk - Standard Deviation - Y axis  
                - Values: Numeric Values  
                
20. "timeBodyAccelerationJerkStandardDeviationZ"        
                - Description: Time Body Acceleration Jerk - Standard Deviation - Z axis  
                - Values: Numeric Values  
                
21. "timeBodyGyroscopeMeanX"             
                - Description: Time Body Gyroscope - Mean - X axis  
                - Values: Numeric Values  
                
22. "timeBodyGyroscopeMeanY"             
                - Description: Time Body Gyroscope - Mean - Y axis  
                - Values: Numeric Values  
                
23. "timeBodyGyroscopeMeanZ"             
                - Description: Time Body Gyroscope - Mean - Z axis  
                - Values: Numeric Values  
                
24. "timeBodyGyroscopeStandardDeviationX"  
                - Description: Time Body Gyroscope - Standard Deviation - X axis  
                - Values: Numeric Values  
                
25. "timeBodyGyroscopeStandardDeviationY"  
                - Description: Time Body Gyroscope - Standard Deviation - Y axis  
                - Values: Numeric Values  
                
26. "timeBodyGyroscopeStandardDeviationZ"  
                - Description: Time Body Gyroscope - Standard Deviation - Z axis  
                - Values: Numeric Values  
                
27. "timeBodyGyroscopeJerkMeanX"         
                - Description: Time Body Gyroscope Jerk - Mean - X axis  
                - Values: Numeric Values  
                
28. "timeBodyGyroscopeJerkMeanY"               
                - Description: Time Body Gyroscope Jerk - Mean - Y axis  
                - Values: Numeric Values  
                
29. "timeBodyGyroscopeJerkMeanZ"         
                - Description: Time Body Gyroscope Jerk - Mean - Z axis  
                - Values: Numeric Values  
                
30. "timeBodyGyroscopeJerkStandardDeviationX"           
                - Description: Time Body Gyroscope Jerk - Standard Deviation - X axis  
                - Values: Numeric Values  
                
31. "timeBodyGyroscopeJerkStandardDeviationY"                
                - Description: Time Body Gyroscope Jerk - Standard Deviation - Y axis  
                - Values: Numeric Values  
                
32. "timeBodyGyroscopeJerkStandardDeviationZ"                
                - Description: Time Body Gyroscope Jerk - Standard Deviation - Z axis  
                - Values: Numeric Values  
                
33. "timeBodyAccelerationMagnitudeMean"                      
                - Description: Time Body Acceleration Magnitude - Mean   
                - Values: Numeric Values  
                
34. "timeBodyAccelerationMagnitudeStandardDeviation"         
                - Description: Time Body Acceleration Magnitude - Standard Deviation   
                - Values: Numeric Values  
                
35. "timeGravityAccelerationMagnitudeMean"                   
                - Description: Time Gravity Acceleration Magnitude - Mean  
                - Values: Numeric Values  
                
36. "timeGravityAccelerationMagnitudeStandardDeviation"      
                - Description: Time Gravity Acceleration Magnitude - Standard Deviation  
                - Values: Numeric Values  
                
37. "timeBodyAccelerationJerkMagnitudeMean"                  
                - Description: Time Body Acceleration Jerk Magnitude - Mean  
                - Values: Numeric Values  
                
38. "timeBodyAccelerationJerkMagnitudeStandardDeviation"     
                - Description: Time Body Acceleration Jerk Magnitude - Standard Deviation   
                - Values: Numeric Values  
                
39. "timeBodyGyroscopeMagnitudeMean"     
                - Description: Time Body Gyroscope Magnitude - Mean  
                - Values: Numeric Values  
                
40. "timeBodyGyroscopeMagnitudeStandardDeviation"           
                - Description: Time Body Gyroscope Magnitude - Standard Deviation   
                - Values: Numeric Values  
                
41. "timeBodyGyroscopeJerkMagnitudeMean"                     
                - Description: Time Body Gyroscope Jerk Magnitude - Mean  
                - Values: Numeric Values  
                
42. "timeBodyGyroscopeJerkMagnitudeStandardDeviation"        
                - Description: Time Body Gyroscope Jerk Magnitude - Standard Deviation   
                - Values: Numeric Values  
                
43. "frequencyBodyAccelerationMeanX"                         
                - Description: Frequency Body Acceleration - Mean - X axis  
                - Values: Numeric Values  
                
44. "frequencyBodyAccelerationMeanY"                         
                - Description: Frequency Body Acceleration - Mean - Y axis  
                - Values: Numeric Values  
                
45. "frequencyBodyAccelerationMeanZ"                         
                - Description: Frequency Body Acceleration - Mean - Z axis  
                - Values: Numeric Values  
                
46. "frequencyBodyAccelerationStandardDeviationX"            
                - Description: Frequency Body Acceleration - Standard Deviation - X axis   
                - Values: Numeric Values  
                
47. "frequencyBodyAccelerationStandardDeviationY"            
                - Description: Frequency Body Acceleration - Standard Deviation - Y axis     
                - Values: Numeric Values  
                
48. "frequencyBodyAccelerationStandardDeviationZ"            
                - Description: Frequency Body Acceleration - Standard Deviation - Z axis     
                - Values: Numeric Values  
                
49. "frequencyBodyAccelerationJerkMeanX"                     
                - Description: Frequency Body Acceleration Jerk - Mean - X axis  
                - Values: Numeric Values  
                
50. "frequencyBodyAccelerationJerkMeanY"                     
                - Description: Frequency Body Acceleration Jerk - Mean - Y axis  
                - Values: Numeric Values  
                
51. "frequencyBodyAccelerationJerkMeanZ"                     
                - Description: Frequency Body Acceleration Jerk - Mean - Z axis  
                - Values: Numeric Values  
                
52. "frequencyBodyAccelerationJerkStandardDeviationX"        
                - Description: Frequency Body Acceleration Jerk - Standard Deviation - X axis  
                - Values: Numeric Values  
                
53. "frequencyBodyAccelerationJerkStandardDeviationY"        
                - Description: Frequency Body Acceleration Jerk - Standard Deviation - Y axis  
                - Values: Numeric Values  
                
54. "frequencyBodyAccelerationJerkStandardDeviationZ"        
                - Description: Frequency Body Acceleration Jerk - Standard Deviation - Z axis  
                - Values: Numeric Values  
                
55. "frequencyBodyGyroscopeMeanX"                     
                - Description: Frequency Body Gyroscope - Mean - X axis  
                - Values: Numeric Values  
                
56. "frequencyBodyGyroscopeMeanY"        
                - Description: Frequency Body Gyroscope - Mean - Y axis  
                - Values: Numeric Values  
                
57. "frequencyBodyGyroscopeMeanZ"        
                - Description: Frequency Body Gyroscope - Mean - Z axis  
                - Values: Numeric Values  
                
58. "frequencyBodyGyroscopeStandardDeviationX"               
                - Description: Frequency Body Gyroscope - Standard Deviation - X axis  
                - Values: Numeric Values  
                
59. "frequencyBodyGyroscopeStandardDeviationY"               
                - Description: Frequency Body Gyroscope - Standard Deviation - Y axis  
                - Values: Numeric Values  
                
60. "frequencyBodyGyroscopeStandardDeviationZ"               
                - Description: Frequency Body Gyroscope - Standard Deviation - Z axis    
                - Values: Numeric Values  
                
61. "frequencyBodyAccelerationMagnitudeMean"              
                - Description: Frequency Body Acceleration Magnitude - Mean   
                - Values: Numeric Values  
                
62. "frequencyBodyAccelerationMagnitudeStandardDeviation"    
                - Description: Frequency Body Acceleration Magnitude - Standard Deviation  
                - Values: Numeric Values  
                
63. "frequencyBodyAccelerationJerkMagnitudeMean"             
                - Description: Frequency Body Acceleration Jerk Magnitude - Mean  
                - Values: Numeric Values  
                
64. "frequencyBodyAccelerationJerkMagnitudeStandardDeviation"  
                - Description: Frequency Body Acceleration Jerk Magnitude - Standard Deviation  
                - Values: Numeric Values  
                
65. "frequencyBodyGyroscopeMagnitudeMean"                    
                - Description: Frequency Body Gyroscope Magnitude - Mean  
                - Values: Numeric Values  
                
66. "frequencyBodyGyroscopeMagnitudeStandardDeviation"       
                - Description: Frequency Body Gyroscope Magnitude - Standard Deviation  
                - Values: Numeric Values  
                
67. "frequencyBodyGyroscopeJerkMagnitudeMean"                
                - Description: Frequency Body Gyroscope Jerk Magnitude - Mean  
                - Values: Numeric Values  
                
68. "frequencyBodyGyroscopeJerkMagnitudeStandardDeviation"   
                - Description: Frequency Body Gyroscope Jerk Magnitude - Standard Deviation  
                - Values: Numeric Values  
