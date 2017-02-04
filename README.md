### Introduction

This repository is part of the "Peer-graded Assignment: Getting and Cleaning Data Course Project". It contains:

1.  README.md - this file
2.  run_analysis.R - the script to execute the assignement tasks from 1-5
3.  tidy_data.txt - output tidy data frame
4.  codebook.txt - code book with variables in tidy_data.txt

### Code details

This script is used to load Smartphones Dataset and generate tidy data - 'tidy_data.txt' file.
Here are the original data used for the project as provided by assignement:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It is assumed that the zip file is extracted and saved to a local folder like 'UCI HAR Dataset' (including 'test' and 'train' subfolders).
The 'path' variable can be used to identify this folder. If the 'path' is not defined, the script
assumes the path is the working directory where the Samsung data is available. The script loads necessary files and 
executes data manipulation steps from 1-5. The tasks are commented on the script.


### References
From Course instructions
"A full description of the original data is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"

