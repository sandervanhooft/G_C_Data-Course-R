Getting and Cleaning Data - Project CodeBook
========================================================

The run_analysis.R script is used to create a tidy dataset out of the UCI HAR Dataset, which was obtained from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) (more information can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)).

The script imports and merges all relevant data from the UCI HAR dataset, including test and train data, activities and subjects. The activities are relabeled for easy human interpretation. The columns are relabeled using the features data set. This way, it was easy to subset the total dataset by name, in order to only contain mean and std columns, plus the activity and subject columns.

The result is exported into the file 'read.csv', containing the following columns:


```r
x <- read.csv("tidy_data.csv")
colnames(x)
```

```
##  [1] "X"                           "activity"                   
##  [3] "subject"                     "TimeBodyAccMeanX"           
##  [5] "TimeBodyAccMeanY"            "TimeBodyAccMeanZ"           
##  [7] "TimeBodyAccStdX"             "TimeBodyAccStdY"            
##  [9] "TimeBodyAccStdZ"             "TimeGravityAccMeanX"        
## [11] "TimeGravityAccMeanY"         "TimeGravityAccMeanZ"        
## [13] "TimeGravityAccStdX"          "TimeGravityAccStdY"         
## [15] "TimeGravityAccStdZ"          "TimeBodyAccJerkMeanX"       
## [17] "TimeBodyAccJerkMeanY"        "TimeBodyAccJerkMeanZ"       
## [19] "TimeBodyAccJerkStdX"         "TimeBodyAccJerkStdY"        
## [21] "TimeBodyAccJerkStdZ"         "TimeBodyGyroMeanX"          
## [23] "TimeBodyGyroMeanY"           "TimeBodyGyroMeanZ"          
## [25] "TimeBodyGyroStdX"            "TimeBodyGyroStdY"           
## [27] "TimeBodyGyroStdZ"            "TimeBodyGyroJerkMeanX"      
## [29] "TimeBodyGyroJerkMeanY"       "TimeBodyGyroJerkMeanZ"      
## [31] "TimeBodyGyroJerkStdX"        "TimeBodyGyroJerkStdY"       
## [33] "TimeBodyGyroJerkStdZ"        "TimeBodyAccMagMean"         
## [35] "TimeBodyAccMagStd"           "TimeGravityAccMagMean"      
## [37] "TimeGravityAccMagStd"        "TimeBodyAccJerkMagMean"     
## [39] "TimeBodyAccJerkMagStd"       "TimeBodyGyroMagMean"        
## [41] "TimeBodyGyroMagStd"          "TimeBodyGyroJerkMagMean"    
## [43] "TimeBodyGyroJerkMagStd"      "FreqBodyAccMeanX"           
## [45] "FreqBodyAccMeanY"            "FreqBodyAccMeanZ"           
## [47] "FreqBodyAccStdX"             "FreqBodyAccStdY"            
## [49] "FreqBodyAccStdZ"             "FreqBodyAccJerkMeanX"       
## [51] "FreqBodyAccJerkMeanY"        "FreqBodyAccJerkMeanZ"       
## [53] "FreqBodyAccJerkStdX"         "FreqBodyAccJerkStdY"        
## [55] "FreqBodyAccJerkStdZ"         "FreqBodyGyroMeanX"          
## [57] "FreqBodyGyroMeanY"           "FreqBodyGyroMeanZ"          
## [59] "FreqBodyGyroStdX"            "FreqBodyGyroStdY"           
## [61] "FreqBodyGyroStdZ"            "FreqBodyAccMagMean"         
## [63] "FreqBodyAccMagStd"           "FreqBodyBodyAccJerkMagMean" 
## [65] "FreqBodyBodyAccJerkMagStd"   "FreqBodyBodyGyroMagMean"    
## [67] "FreqBodyBodyGyroMagStd"      "FreqBodyBodyGyroJerkMagMean"
## [69] "FreqBodyBodyGyroJerkMagStd"
```

As described by the dataset's providers, it covers 30 subjects:

```r
subjects <- unique(x$subject)
print(length(subjects))
```

```
## [1] 30
```

```r
print(subjects)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
## [24] 24 25 26 27 28 29 30
```

The activities are:

```r
print(unique(x$activity))
```

```
## [1] LAYING             SITTING            STANDING          
## [4] WALKING            WALKING_DOWNSTAIRS WALKING_UPSTAIRS  
## 6 Levels: LAYING SITTING STANDING WALKING ... WALKING_UPSTAIRS
```

