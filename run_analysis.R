# [Done] You should create one R script called run_analysis.R that does the following. 
# [Done] Merges the training and the test sets to create one data set.
# [Done] Extracts only the measurements on the mean and standard deviation for each measurement. 
# [Done] Uses descriptive activity names to name the activities in the data set
# [Done] Appropriately labels the data set with descriptive activity names. 
# [Done] Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Set working directory to this file's directory
scriptdir <- dirname(sys.frame(1)$ofile)
setwd(scriptdir)

library(data.table, quietly=TRUE) # For fread()
library(reshape2, quietly=TRUE)

get.features.data <- function() {
  message("Importing features")
  features <- "UCI HAR Dataset/features.txt"
  features <- fread(features)
  features$V2
}

get.activity.labels.data <- function() {
  message("Importing activities")
  activity.labels <- "UCI HAR Dataset/activity_labels.txt"
  activity.labels <- fread(activity.labels)
  activity.labels$V2
}

get.activity.label <- function(activities, n) {
  activities[n]
}

get.y.test.data <- function() {
  message("Importing y test data")
  y.test <- "UCI HAR Dataset/test/y_test.txt"
  y.test <- fread(y.test)
  setnames(y.test, "V1", "activity")
  y.test
}

get.x.test.data <- function(features) {
  message("Importing x test data")
  x.test <- "UCI HAR Dataset/test/X_test.txt"
  x.test <- read.table(x.test, col.names=features)
}

get.y.train.data <- function() {
  message("Importing y train data")
  y.train <- "UCI HAR Dataset/train/y_train.txt"
  y.train <- fread(y.train)
  setnames(y.train, "V1", "activity")
  y.train
}

get.x.train.data <- function(features) {
  message("Importing x train data")
  x.train <- "UCI HAR Dataset/train/X_train.txt"
  x.train <- read.table(x.train, col.names=features)
}

get.subject.test.data <- function() {
  message("Importing subject test data")
  subject.test <- "UCI HAR Dataset/test/subject_test.txt"
  subject.test <- read.table(subject.test)
  setnames(subject.test, "V1", "subject")
}

get.subject.train.data <- function() {
  message("Importing subject train data")
  subject.train <- "UCI HAR Dataset/train/subject_train.txt"
  subject.train <- read.table(subject.train)
  setnames(subject.train, "V1", "subject")
}

get.test.data <- function(features) {
  message("Importing test data:")
  x.test <- get.x.test.data(features)
  y.test <- get.y.test.data()
  subject.test <- get.subject.test.data()
  df <- cbind(x.test, y.test, subject.test)
  message("Importing test data: DONE")
  df
}

get.train.data <- function(features) {
  message("Importing train data:")
  x.train <- get.x.train.data(features)
  y.train <- get.y.train.data()
  subject.train <- get.subject.train.data()
  df <- cbind(x.train, y.train, subject.train)
  message("Importing train data: DONE")
  df
}

subset.relevant.columns <- function(df) {
  message("Subsetting relevant columns")
  columns <- colnames(df)
  
  # meanFreq columns should be removed (makes it easier to search for 'mean' columns)
  grep.exclude <- grep("meanFreq", columns)
  columns <- columns[-grep.exclude]
  
  # columns mean, std, activity and subject should be kept
  grep.search <- grep("mean|std|activity|subject", columns)
  columns <- columns[grep.search]
  
  df <- df[, columns]
}

clean.up.column.names <- function(df) {
  message("Cleaning up column names")
  x <- colnames(df)
  x <- gsub("\\.mean", "Mean", x)
  x <- gsub("\\.std", "Std", x)
  x <- gsub("\\.", "", x)
  x <- gsub("^t", "Time", x)
  x <- gsub("^f", "Freq", x)
  setnames(df,colnames(df),x)
  df
}

get.tidy.data.frame <- function() {
  message("Building tidy data frame")
  activities <- get.activity.labels.data()
  features <- get.features.data()
  
  test <- get.test.data(features)
  train <- get.train.data(features)
  
  df <- rbind(test, train) # Merge test and train data frames
  
  df$activity <- factor(activities[df$activity]) # Convert categorical activity labels into factors

  df <- subset.relevant.columns(df) # Select only relevant columns
  df <- clean.up.column.names(df)
  message("Building tidy data frame: DONE")
  df
}

# Creates a tidy data set with the average of each variable for each activity and each subject
get.tidy.averages <- function(x) {
  x <- melt(x, id=c("activity", "subject"),varnames=colnames(x)[-c("activity", "subject")])
  dcast(x, activity + subject ~ variable, mean )
}


########## Running the script ##########

x <- get.tidy.data.frame()
y <- get.tidy.averages(x)

# Save it to tidy.data.csv
path <- file.path(getwd(), "tidy_data.csv")
write.csv(y, path, quote=FALSE)
rm(path)
