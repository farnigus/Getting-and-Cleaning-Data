setwd("c:/users/Eugene/Desktop/datasciencecoursera/Getting and Cleaning Data")
library(dplyr)
## File names

train_x_file<-paste0(getwd(), "/UCI HAR Dataset/train/X_train.txt")
train_y_file<-paste0(getwd(), "/UCI HAR Dataset/train/Y_train.txt")
train_subject_file<-paste0(getwd(), "/UCI HAR Dataset/train/subject_train.txt")

test_x_file<-paste0(getwd(), "/UCI HAR Dataset/test/X_test.txt")
test_y_file<-paste0(getwd(), "/UCI HAR Dataset/test/y_test.txt")
test_subject_file<-paste0(getwd(), "/UCI HAR Dataset/test/subject_test.txt")

activity_labels_file <- paste0(getwd(), "/UCI HAR Dataset/activity_labels.txt")
features_file <- paste0(getwd(), "/UCI HAR Dataset/features.txt")


## Read files
train_x<-read.table(train_x_file)
train_y<-read.table(train_y_file)
train_subject<-read.table(train_subject_file)

test_x<-read.table(test_x_file)
test_y<-read.table(test_y_file)
test_subject<-read.table(test_subject_file)

activity_labels<- read.table(activity_labels_file)
features <- read.table(features_file)

## Step 1: combine test and training data. 
x <- rbind(train_x, test_x)
y <- rbind(train_y, test_y)
subject <- rbind (train_subject, test_subject)

## Step 4: Label variables. Doing it out of order. Annoying that
## some variable names are repeated, which will cause problems,
## so only label variables will end up caring about
## Unfortunately, assignment isn't really clear as to what defines "mean"

keep<-grep("mean()|std()",features[[2]] );
labels<-grep("mean()|std()", features[[2]], value=TRUE)
names(x)[keep]<-labels

## Step 2: keep only variables with mean() and std(). 

data<-select(x, keep)

##Step 3: Add subject and activity. Merge last to avoid re-ordering problems

names(subject)<-"subject"
data<-cbind(subject,data)
data<-cbind(y,data)
data<-merge(data, activity_labels, by = "V1")
data<- rename(data,activity=V2);
data<- select(data, -V1)

##Step 5: find average and tidy the data
data<-group_by(data, activity, subject)
tidy<-summarise_each(data, funs(mean))
write.table(tidy, "tidy.txt", row.names=FALSE)
