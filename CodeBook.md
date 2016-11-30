### CodeBook


Data Source

Data description
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data download
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data transformation steps

1. Reading  in files train,test,feature, activity lables
2. Column names assignments
3. Merge data sets
4. Extract required measurements mean and standard deviation
5. Subset data set from merged data
6. Using descriptive activity names to name the activities in the data set
7.Creating a second, independent tidy data set with the average of each variable for each activity and each subject
8. Writing the second dataset to a text file


The data labels are as x_test,y_train,y_train,y_test,merging_train,merging_test merged_data,all_merged_data,second_Tidyset

Variables in the second_TidySet.txt

The identifiers are subjectId,activityId


