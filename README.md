# Getting and Cleaning Data Course Project  


This is the Repository for the "Getting and Cleaning Data"" Course Project, within the "Data Science Specialization" from the Johns Hopkins University.


## Repository Contents

You will find the following files in the Repository:  

1. This "README.md" file, that explains the repository contents and explains how all of the scripts work and how they are connected.

2. The script "run_analysis.R", that is the R Script used to transform the data and to get the final tidy data set requested in the 5th step of the Course Project.

3. The "CodeBook.md" file, that is the Code Book that describes the variables, the data, and any transformations or work performed to clean up the data.

4. The "tidy_data_set.txt" file, that is the final tidy data set requested in the 5th step of the Course Project.


## Instructions to run the Script

1. Download the data for the Project from this URL:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Place the downloaded zip file "getdata-projectfiles-UCI HAR Dataset.zip" in your working directory.

3. Place the script "run_analysis.R" in your working directory too.

4. Unzip the file "getdata-projectfiles-UCI HAR Dataset.zip" inside your working directory, so you get the folder "UCI HAR Dataset" placed in your working directory. This folder "UCI HAR Dataset" should contain all the original data with the original structure.

5. Once the previous four steps are completed, you can run the script "run_analysis.R" in your working directory to transform the data and to get the final tidy data set requested in the 5th step of the Course Project. The output file will be automatically created in your working directory, called "tidy_data_set.txt".

6. To load this "tidy_data_set.txt" file into R and easily view the data, you can use the following commands:  

        data <- read.table("./tidy_data_set.txt", header = TRUE)  
        View(data)

