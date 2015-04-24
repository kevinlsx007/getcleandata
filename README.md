# Getting and Cleaning Data Course Project
This repository contains the run_analysis.R scripts getting and cleaning Samsung data to generate the required tidy data and the code book describing the variables.

The run_analysis.R code includes the scripts for downloading the Samsung data as .zip file from internet as well. After downloading, it unzips to get the "UCI HAR Dataset" folder containing the data sets.

The second step of the code is to read all the necessary .txt files into R using read.table() function.
Here, features data will contain 561 variable names of the measurements; actlabels data connect activity names (walking, standing, etc.) to numbers (1:6). It is needed to name activities descriptively as required by the project.

The train folder and test folder each contains 3 .txt files corresbonding to subject (1 to 30), activity labels (1 to 6), and measurements data.

After reading 8 .txt files, the code will combine the corresponding data from training and test using rbind() function (Step 1):
For subject, the code renames the column name as "subject";
For activity, after rbinding the data from training and test, the code firstly merges it with actlabels data so that each number (1 to 6) of activity label can be matched with activity name (Note: set sort=FALSE to keep the original order of the activity label). After this, the code changes the activity names to lower cases without space and convert to factors (Step 3). At last, the code renames the column name as "activity".
For measure, the code sets the column names using the features data (Step 4) (Note: it is a good idea to check the dimensions of each data frame to get the guidance of how all of the files are connected.)

To subtract only the measurements on the mean and standard deviation (Step 2), the code uses grepl() function.

After all these steps, the code uses the cbind() function to form a tidy data containing subject, activity names, and mean and standard deviation of each measurement.

Finnaly, to generate the tidy data required in Step 5, the codes uses dpply() function from plyr package and uses the write.table() function to export it as a .txt file.
