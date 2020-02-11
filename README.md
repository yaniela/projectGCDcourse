---
output:
  html_document: default
  pdf_document: default
---
**Objetive**

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.

**Collection of the raw data**
The data was collected from  the Human Activity Recognition Using Smartphones Dataset Version 1.0. This dataset was obtained from the course website, and represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

**Creating the tidy datafile**

The script run_analysis.R is to performing the analysis of the dataset.

**Guide to create the tidy data file**

*Step#1  Merges the training and the test sets to create one data set.*

Using the read.table function, the .txt files with the same dimensions are loaded (X_test.txt/X_train.txt, y_test.txt/y_train.txt and subject_test.txt/subject_train.txt).

Then for each test/train pair, ensure that the datasets have the same column name, using the function colnames.

Finally, with the rbind or cbind functions, join the subsets. 


*Step#2   Extracts only the measurements on the mean and standard deviation for each measurement.*

Using the features.txt file, a vector is created with the positions of the column names that contain the words "mean" and "std". This vector is used to select the associated columns in the dataframe created in the previous step.
    
*Step#3 Uses descriptive activity names to name the activities in the data set*

First a vector is created with the names of the activities, then, through a for cycle, the rows of the activity column are traversed by exchanging the numbers for the text.

Keep in mind that the values of the rows are characters, so it is necessary to convert them to numbers

*Step#4 Appropriately labels the data set with descriptive variable names.*

Using the sub function, the characters "() -" and "-" are replaced by the character "." in the names of the corresponding columns

*Step#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.*

With the dcast function of the reshape2 library, the variables are grouped and the average of each one is calculated


