# Getting-and-Cleaning-Data-Course-Project

<h2>Intro</h2>
This repo conatins the files needed to perform the analysis for the Smartphone data. The data is used from the link
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
The zip file will contain data about the test and train sets. The data is contained in 6 files which are in txt format. They are 
under the UCI HAR Dataset folder.

<h2>R Script and info</h2>
The r file in the repo to perform the data cleaning is called run_analysis.R. This file contains the R scipt that will get adn clean data and merge to get info that is required. The five steps that it performs are:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

<h2>Run the file</h2>
The run_analysis.R is a script that contains one master function called analysisRun(). If you would like to run the scripts you can run the R file in rstudio and then independantly call the analysisRun() function in the rstudio console. This will retreive all the info that you need and save it in your working directory. The tidy.txt file will be save in your directory as well. This is the seperate independent data set that we needed to ake.

<h2>Codebook.md</h2>
The Codebook.md contains the variables, the data that was performed to clean up the data and is in tidy.txt
