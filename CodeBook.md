Getting and Cleaning Data: Course Project
========================================================

The process
--------------------------------------------------------
0. Read the data into R:
  * For performance reasons, fread() has been used where possible without issues.
  * As a practical alternative, read.table() has been used where using fread() resulted in warnings/problems (and performance was not a big issue)
1. Merge the training and the test sets to create one data set:
  1. y.train (activity) is added as column to x.train using cbind(). This combination is called train and appropriately uses features.txt plus "activity" for its column names.
  2. y.test (activity) is added as column to x.test using cbind(). This combination is called test and appropriately uses features.txt plus "activity" for its column names.
  3. the total data set is merged by using rbind() on train and test.
2. Extract only the measurements on the mean and standard deviation for each measurement:
  * The columns are filtered using grep() on the column names of the total dataset. The activity column is added to the resulting columns.
3. Use descriptive activity names to name the activities in the data set:
  * The activity of each row is named using the activity_labels.txt file.
4. Appropriately label the data set with descriptive activity names:
  * See the merging procedure above.
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject:
  * [[To do.]]