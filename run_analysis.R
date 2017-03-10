
## Read activity labels
actlabels <- read.table("./getcleandata-assignment/UCI HAR Dataset/activity_labels.txt")

## Read col names
colNames <- read.table("./getcleandata-assignment/UCI HAR Dataset/features.txt")


## Read data from the Test folder
test_x <- read.table("./getcleandata-assignment/UCI HAR Dataset/test/X_test.txt",col.names = as.character(colNames[,2]))
test_y <- read.table("./getcleandata-assignment/UCI HAR Dataset/test/y_test.txt",col.names = c("actvity_id"))
test_subject <- read.table("./getcleandata-assignment/UCI HAR Dataset/test/subject_test.txt",col.names = c("subject_id"))
master_test <- cbind(test_subject,test_y,test_x)
## Read data from the Train folder
train_x <- read.table("./getcleandata-assignment/UCI HAR Dataset/train/X_train.txt",col.names = as.character(colNames[,2]))
train_y <- read.table("./getcleandata-assignment/UCI HAR Dataset/train/y_train.txt",col.names = c("actvity_id"))
train_subject <- read.table("./getcleandata-assignment/UCI HAR Dataset/train/subject_train.txt",col.names = c("subject_id"))
master_train <- cbind(train_subject,train_y,train_x)

## Merging everything to create 1 data set
onedataset <- rbind(master_test,master_train)

subcol <- grep(".*mean.*|.*std.*|actvity_id|subject_id",colnames(onedataset))

subset <-onedataset[,subcol]

### merging with the activity id

subsetAct <- merge(subset, actlabels,by.x='actvity_id',by.y = "V1",all.x=TRUE)

#### Rearranging data by activity and subject
dfByActSub <- aggregate(. ~subject_id + actvity_id, subsetAct, mean)
dfByActSub <- dfByActSub[order(dfByActSub$subject_id, dfByActSub$actvity_id),]

write.table(dfByActSub, "SubjectActivityByTidySet.txt", row.name=FALSE,col.names = FALSE)


