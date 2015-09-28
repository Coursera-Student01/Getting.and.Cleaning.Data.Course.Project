library(dplyr)
library(magrittr)

#Reading in a lookup table for Activities
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("Activity.ID", "Activity.Name"))

#Reading in a lookup table for Features
feature_labels <- read.table("./UCI HAR Dataset/features.txt", col.names = c("Feature.ID", "Feature.Name"))

#Reading raw data into workspace
  #Train data
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
  activities_train <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                              col.names = "Activity")
  measures_train <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                            col.names = feature_labels$Feature.Name)

  #Test data 
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
  activities_test <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                                col.names = "Activity")
  measures_test <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                              col.names = feature_labels$Feature.Name)
  
#Merging train & test datasets by rows
subject <- rbind(subject_train, subject_test)
activity <- rbind(activities_train, activities_test)
measures_raw <- rbind(measures_train, measures_test)

#Assigning descriptive names to activities
activity$Activity <- activity_labels$Activity.Name[
  match(
    activity$Activity, 
    activity_labels$Activity.ID
  )]

#Merging Subject, Activity and Measures data by columns
complete_dataset_raw <- cbind(subject, activity, measures_raw)

#Exctracting mean and standard deviation related variables from measures_raw
measures_mean <- measures_raw[,grep(".*mean\\()", feature_labels[,2], ignore.case = F)]
measures_std <- measures_raw[,grep(".*std\\()", feature_labels[,2], ignore.case = F)]
measures_tidy <- cbind(measures_mean, measures_std)

#Tidying feature names
names(measures_tidy) <- gsub("*.mean...", "Mean", names(measures_tidy))
names(measures_tidy) <- gsub("*.mean..", "Mean", names(measures_tidy))
names(measures_tidy) <- gsub("*.std...", "Std", names(measures_tidy))
names(measures_tidy) <- gsub("*.std..", "Std", names(measures_tidy))
names(measures_tidy) <- gsub("*BodyBody", "Body", names(measures_tidy))

#Cleaning workspace
rm(subject_train, 
   subject_test, 
   activities_train, 
   activities_test, 
   measures_train, 
   measures_test, 
   feature_labels, 
   activity_labels,
   measures_raw,
   measures_mean,
   measures_std)

#Merging subject, activity and measures into a single dataset
complete_dataset_tidy <- cbind(subject, activity, measures_tidy)
rm(subject, activity, measures_tidy)

#Making a tidy dataset
tidy_dataset <- complete_dataset_tidy %>% 
                                  group_by(Subject, Activity) %>% 
                                  summarise_each(funs(mean))

#Write run.data to file
tidy_dataset %>% write.table(file="tidy_dataset.txt", row.name=FALSE)
