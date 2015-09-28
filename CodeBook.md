# Codebook for Getting and Cleaning Data Course Project 

### Original Data

A database was built from the recordings of 30 volunteers within an age bracket of 19-48 years performing activities of daily living (walking, walking upstairs, walking downstairs, sitting, standing, laying) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, research team captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. For detailed description of the original dataset, please visit ["Data Set Information"](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). [Source.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

### Data manipulation sequence

Data manipulation carried out by the script is performed in a following sequence:

1. Activity labels are read into the workspace with descriptive  column names `"Activity.ID"` and `"Activity.Name"`.
2. Feature labels are read into the workspace with descriptive column names `"Feature.ID"`, `"Feature.Name"`.
3. `train` and `test` data is read into the workspace with descriptive column names (`"Subject"`, `"Activity"`). `x` table data is read into the workspace with labels from `"Feature.Name"` column of `feature_labels` table.
4. `Subject`, `Activity` and `Features` components (feature measurements are put within `measures_raw` data frame for further processing)  of `test` and `train` partitions are merged by rows.
6. Descriptive activity names are assigned to activity data.
7. `Subject`, `Activity` and `Features` components are merged into complete data set (`complete_dataset_raw`) by columns.
8. `Mean` and `Standard Deviation` columns are extracted from `Features` component and combined within `measures_tidy` data frame. 
9. A data set, which contains only `Mean` and `Standard Deviation` related variables is assembled by merging `Subject`, `Activity` with an output from previous step.
10. An independent tidy data set with the average of each variable for each activity and each subject is created and written into `tidy_dataset.txt`.

### Variables
"Subject" 

An identifier of the subject who carried out the experiment. IDs range from 1 to 30.

"Activity"

Activity labels are: 
      
      `WALKING`
      `WALKING_UPSTAIRS` 
      `WALKING_DOWNSTAIRS`
      `SITTING`
      `STANDING`
      `LAYING` 

In a frame outlined within assignment only `Mean` and `Standard Deviation` related variables were used to estimate averages of variables of the feature vector for each pattern. Please make note, that '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

      `tBodyAccXYZ`
      `tGravityAccXYZ`
      `tBodyAccJerkXYZ`
      `tBodyGyroXYZ`
      `tBodyGyroJerkXYZ`
      `tBodyAccMag`
      `tGravityAccMag`
      `tBodyAccJerkMag`
      `tBodyGyroMag`
      `tBodyGyroJerkMag`
      `fBodyAcc-XYZ`
      `fBodyAccJerk-XYZ`
      `fBodyGyro-XYZ`
      `fBodyAccMag`
      `fBodyAccJerkMag`
      `fBodyGyroMag`
      `fBodyGyroJerkMag`

### Tidy data set

Tidy data set contains the average of all feature standard deviation and mean values of the raw dataset. 
Original variable names were modified as follows:

 1. Variables, which contained `-mean` and `-std` now contain `Mean` and `Std` accordingly.
 2. Parenthesis and dots were removed from variable names.
 3. `BodyBody` was replaced with `Body`.
 
In manipulation step 6 descriptive activity names are assigned to activities IDs of the data set, as it is required in part 3 of the assignment.

