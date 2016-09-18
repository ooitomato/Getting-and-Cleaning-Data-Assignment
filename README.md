# Getting-and-Cleaning-Data-Assignment
Submission for Getting and Cleaning Data

This is the final submission for Getting and Cleaning Data Assignment.
The R script file by the name of run_Analaysis.R is the script file for the assignment. The codeBook.MD is the file providing details of the data fileds in the tidyData.txt.

The run_Analysis.R will do the following:-

1. Download the data from data source at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the downloaded zip file
3. Read activity info (labels & features) and load it to memory
4. Extract mean and standard deviation from the data
5. Then read actual training data and test data
6. Merge the actual training and test data and proper labels to it
7. and then finally create a new file with data that is already being tidy up from the merge file
