# Codebook for the course project of "Getting and Cleaning Data
This codebook explains the original variables of the course project and the data transformation process in "run_analysis.R".  

# Data source
The data source of this project is here:  
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>  

The above zip file contains the following key files:
* activity_lables.txt
* subject_test.txt
* x_test.txt
* y_test.txt
* subject_train.txt
* x_train.txt
* y_train.txt  

Below is the files explain the background of the data, the structure, and the feature of the variables.
* feature_info.txt
* feature.txt
* README.txt

# Variables
There are 561 different variables in the data. 
The features of the variables come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.  

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag
  
The main variables that were estimated from these signals are:  

* mean(): Mean value
* std(): Standard deviation

On top of the above variables, there are more than 10 variabes that are eliminated through the analysis. 
The complete list of variables of each feature vector is available in 'features.txt'  

# Data transformation
### Getting and collecting data
Set the working enviroment in my computer and then getting data from the data source.
The original data is in zip file so need to be unzipped.  

After saving the data in the appropriate directory, the data in the following files are collected. 
Since there are two different groups of the data i.e. "test" and "train", the same collection process is applied to both group.  

### Combining and naming data
Each group contains three data sets: "Subject", "Activity" and "Feature". Firstly, the test and train data is combined in each data set.  

Then, the header name of each data is populated. The subject data is given the header of "Subject" and the activity data is given "Activity" as the header name.
For the feature data, the lable for its header is populated using the label data in the file "features.txt".  

Finally, the three data set is combined to make it a single data table.

### Selecting and modifying data 
According to the instruction, only "std" and "mean" variable are selected in the data table. Also, the number representing "Activity" is replaced with descriptive label such as "WALKING", "STANDING" etc.  
Then data is grouped and ordered. 

### Producing tidy data in txt format
The resulted data is saved in txt format with the name "tidydata.txt".









