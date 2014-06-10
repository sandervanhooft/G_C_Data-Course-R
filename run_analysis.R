# [Done] You should create one R script called run_analysis.R that does the following. 
# [Done] Merges the training and the test sets to create one data set.
# [ToDo] Extracts only the measurements on the mean and standard deviation for each measurement. 
# [Done] Uses descriptive activity names to name the activities in the data set
# [Done] Appropriately labels the data set with descriptive activity names. 
# [ToDo] Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

library(data.table)

get.features.data <- function() {
  features <- "UCI HAR Dataset/features.txt"
  features <- fread(features)
  features$V2
}

get.activity.labels.data <- function() {
  activity.labels <- "UCI HAR Dataset/activity_labels.txt"
  activity.labels <- fread(activity.labels)
  activity.labels$V2
}

get.activity.label <- function(n) {
  if(!exists("activities"))
    activities <- get.activity.labels.data()
  activities[n]
}

get.y.test.data <- function() {
  y.test <- "UCI HAR Dataset/test/y_test.txt"
  y.test <- fread(y.test)
  setnames(y.test, "V1", "activity")
  y.test
}

get.x.test.data <- function(features) {
  x.test <- "UCI HAR Dataset/test/X_test.txt"
  x.test <- read.table(x.test, col.names=features)
}

get.y.train.data <- function() {
  y.train <- "UCI HAR Dataset/train/y_train.txt"
  y.train <- fread(y.train)
  setnames(y.train, "V1", "activity")
  y.train
}

get.x.train.data <- function(features) {
  x.train <- "UCI HAR Dataset/train/X_train.txt"
  x.train <- read.table(x.train, col.names=features)
}

subset.relevant.columns <- function(df) {
  columns <- colnames(df)
  grep.search <- grep("mean|std", columns)
  grep.exclude <- grep("meanFreq", columns)
  columns <- grep.search[! grep.search %in% grep.exclude]
  df <- df[, columns]
}

get.tidy.data.frame <- function() {
  activities <- get.activity.labels.data()
  features <- get.features.data()
  y.test <- get.y.test.data()
  x.test <- get.x.test.data(features)
  y.train <- get.y.train.data()
  x.train <- get.x.train.data(features)
  test <- cbind(x.test, y.test)
  train <- cbind(x.train, y.train)
  
  rm(y.test, x.test, x.train, y.train) # Cleaning up some memory in between
  
  df <- rbind(test, train) # Merge test and train data frames
  
  rm(test, train) # Cleaning up some memory in between
  
  df$activity <- factor(get.activity.label(df$activity)) # Convert categorical activity labels into factors
  
  df <- subset.relevant.columns(df) # Select only mean() and std() columns
}


########## Testing ##########

testdf <- get.tidy.data.frame()
View(head(testdf))