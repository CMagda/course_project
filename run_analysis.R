
library(dplyr)
library(tidyr)
library(reshape2)


### 1) Merges the training and the test sets to create one data set.
y_test<-data.frame(read.table(paste(direcotry,"\\test\\y_test.txt",sep="")))
x_test<-data.frame(read.table(paste(direcotry,"\\test\\x_test.txt",sep="")))
subj_test<-data.frame(read.table(paste(direcotry,"\\test\\subject_test.txt",sep="")))

test<-cbind(subj_test,y_test,x_test)


y_train<-data.frame(read.table(paste(direcotry,"\\train\\y_train.txt",sep="")))
x_train<-data.frame(read.table(paste(direcotry,"\\train\\x_train.txt",sep="")))
subj_train<-data.frame(read.table(paste(direcotry,"\\train\\subject_train.txt",sep="")))

train<-cbind(subj_train,y_train,x_train)

final<-rbind(test,train)

a <- c("user_id","activity_id")
b <-as.character(read.table(paste(direcotry,"\\features.txt",sep=""))[,2])
name<-c(a,b)

colnames(final)<-name

## 2) Extracts only the measurements on the mean and standard deviation for each measurement.

selectedMean <- as.vector(grep("mean", name))
selectedStd<-as.vector(grep("std",name))
selected<-c(1,2,selectedMean,selectedStd)

final_mean_std<-final[selected]


## 3) Uses descriptive activity names to name the activities in the data set
codebook<-data.frame(read.table(paste(direcotry,"\\activity_labels.txt",sep="")))
colnames(codebook)<-c("activity_id","activity")


data<-merge(final_mean_std,codebook,by.x="activity_id",by.y="activity_id",all=TRUE)


## 4) Appropriately labels the data set with descriptive variable names.

tolower(names(data))

dataT<-gather(data,features,mean,3:81)


## 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


data_set <- aggregate(mean ~ user_id +activity_id +  activity + features, data = dataT, mean)
write.table(data_set,file=paste(direcotry,"\\data_set.txt",sep=""),row.names=FALSE)


