#Download files from the internet (to Windows)
temp_file <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(temp_file, destfile = "./Documents/R/quiz2", mode = "wb")

# open and read the 7 input "raw" datasets to collect, work with and clean into a tidy dataset 
ID_test <-read.csv("./subject_test.txt", header = FALSE)
ID_train <-read.csv("./subject_train.txt", header = FALSE)
activity_test <-read.csv("./Y_test.txt",header = FALSE)
activity_train <-read.csv("./Y_train.txt",header = FALSE)

install.packages("readr")
library(readr)
feature <-read_lines("./features.txt")
Xtest<-fwf_empty("./X_test.txt")
Xtrain<-fwf_empty("./X_train.txt")
Xtest<-read_fwf("./X_test.txt",col_position = Xtest)
Xtrain<-read_fwf("./X_train.txt",col_position = Xtrain)

#merge data sets together and rename columns
dfID_act_test <- cbind(ID_test,activity_test)
dfID_act_train <-cbind(ID_train,activity_train)
dftrain<-cbind(dfID_act_train,Xtrain)
dftest<-cbind(dfID_act_test,Xtest)
c<-c("IDvolunteers","activities",feature)
names(dftrain) <-c
names(dftest) <-c
mergedDataset <-merge(dftrain,dftest,by.x = names(dftrain),by.y = names(dftest),all =TRUE)

#index and subset only the measurements containing the mean and standard deviation calculation within "features.txt"
columnsIndex <-grepl("IDvolunteers|activities|mean\\(\\)|std\\(\\)",c)
subsetDataset <-mergedDataset[,columnsIndex]

#using descriptive activity names to name the activities in the dataset
subsetDataset$activities <- gsub("1","walking",subsetDataset$activities,)
subsetDataset$activities <- gsub("2","walkingup",subsetDataset$activities,)
subsetDataset$activities <- gsub("3","walkingdown",subsetDataset$activities,)
subsetDataset$activities <- gsub("4","sitting",subsetDataset$activities,)
subsetDataset$activities <- gsub("5","standing",subsetDataset$activities,)
subsetDataset$activities <- gsub("6","laying",subsetDataset$activities,)

#appropriately labels the data set with descriptive variable names
x <- gsub("[0-9]+ ","",names(subsetDataset))
y <- gsub("mean\\(\\)-*","mean",x)
y <- gsub("std\\(\\)-*","sd",y)
y <- gsub("Acc","Acceleration",y)
y <- gsub("Gyro","Gyroscope",y)
y <- gsub("^tBody","",y)
y <- gsub("^t","",y)
z <- gsub("^fBody","f",y)
z <- gsub("^fBody","ff",z)
z <- gsub("Mag","Magnitude",z)
names(subsetDataset) <- z

#create tidy data using the dplyr package 
# grouping by variables IDvolunteers and activities, then chaining with summarize(mean) of the other 66 variables
library(dplyr)
tidyDataset <- subsetDataset %>% group_by(IDvolunteers,activities) %>% summarise_each(funs(mean))

#Save the tidy data set as a text file (created with write.table())
write.table(tidyDataset,file ="tidydata.txt",quote = FALSE)