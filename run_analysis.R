# Run analysis
# 
# by Rodrigo Parizotto
# 2017-02-04
#
# This script is used to load Smartphones Dataset and generate tidy data
# A full description is available at the site where the data was obtained:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Here are the data for the project:
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 

# path to 'UCI HAR Dataset' folder containg train data, test data and other files
path <- 'c:/poc/R_project/quiz_cleaning_week4/UCI HAR Dataset/'
setwd(path)

# load activities and features
activity_labels_df <- read.table('activity_labels.txt', header = FALSE, sep=" ", col.names = c("Label.ID", "Label.Name"))
features_df <- read.table('features.txt', header = FALSE, sep = " ", col.names = c("Feature.ID", "Feature.Name") )

library(dplyr)

# load train data frame
setwd(path)  
setwd('./train/')
train_df <- read.table('X_train.txt', header = FALSE, col.names = features_df$Feature.Name )
subject_train_df <- read.table('subject_train.txt', col.names = c("Subject.ID"))
y_train_df <- read.table('y_train.txt', col.names = c("Label.ID"))
# bind columns
train_df <- bind_cols(subject_train_df, y_train_df, train_df)
train_df <- train_df %>% mutate(Execution.Type = 'train')


# load test data frame
setwd(path)
setwd('./test/')
test_df <- read.table('X_test.txt', header = FALSE, col.names = features_df$Feature.Name )
subject_test_df <- read.table('subject_test.txt', col.names = c("Subject.ID"))
y_test_df <- read.table('y_test.txt', col.names = c("Label.ID"))

# bind columns
test_df <- bind_cols(subject_test_df, y_test_df, test_df)
test_df <- test_df %>% mutate(Execution.Type = 'test')

# tasks from Course Project

# 1. Merges the training and the test sets to create one data set.
# combine data frames
combined_df <- bind_rows(train_df, test_df )


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

mean_and_std_df <- combined_df %>% select(Subject.ID, Label.ID, Execution.Type, matches("mean"),  matches("std") ) 
#names(mean_and_std_df) #debug names

# 3. Uses descriptive activity names to name the activities in the data set

join_df <- merge(activity_labels_df, mean_and_std_df ) %>% select(-Label.ID) %>% rename(Activity = Label.Name)



# 4. Appropriately labels the data set with descriptive variable names.
n <- names(join_df)
n <- gsub("\\.\\.\\.", ".", n)
n <- gsub("\\.\\.$", "", n)
n <- gsub("\\.$", "", n)
n <- gsub("^t", "Time.", n)
n <- gsub("^f", "Frequency.", n)

names(join_df) <- n

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

dfr <- join_df %>% group_by(Activity, Subject.ID) %>% summarise_each(vars = -Execution.Type, funs = funs(GroupMean ="mean"))

# export data
setwd(path)
write.csv(dfr, file='tidy_data.csv')
