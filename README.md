# Getting and Cleaning Data Course Project
This repository contains the run_analysis.R scripts to get and clean Samsung data to generate the required tidy data and the code book describing the variables.

The run_analysis.R code firstly downloads the Samsung data as .zip file and unzip to get the data sets.

The second step of the code is to read all the necessary .txt files into R using read.table() function.
Here, features data will contain 561 variable names of the measurements; actlabels data connect activity names (walking, standing, etc.) to numbers (1:6). It will be used to name activities descriptively as required by the project.

The train folder and test folder each contains 3 .txt files corresbonding to subject (1 t0 30), activity labels (1 to 6), and measurements data.

After reading 8 .txt files, the code will combine the subject data from 
