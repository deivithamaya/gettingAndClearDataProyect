# Because I did not know the format for joining the tables, I decided 
# to join them using merge and ending up with a table of 7352 rows x 1122 columns.

#I create the folder to save the data
if(!file.exists("./data")){dir.create("./data")}
library(dplyr)
library(data.table)

#I read the training and testing files
dtranX<- read.csv(text=sub(" ","",gsub("  "," ",readLines("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"))),sep=" ",head=FALSE)
dtestX<- read.csv(text=sub(" ","",gsub("  "," ",readLines("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"))),sep=" ",head=FALSE)

#I read the labels
namesLabesls<-read.csv("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt",sep=" ",head=FALSE)
namesLabeslsTrain<-unlist(namesLabesls$V2)
namesLabeslsTest<-unlist(namesLabesls$V2)

#I add a column called id to each table in order to join them with merge
dtranX$id<- 1:length(dtranX[[1]])
dtestX$id<- 1:length(dtestX[[1]])

#I merge the tables
mer<- merge(dtranX,dtestX,by.x = "id",by.y = "id",all=TRUE)

#I eliminate the id column so as not to obtain metrics on this column
mer$id<-NULL

#I get the mean of each variable
meansNewDb<-colMeans(mer,na.rm = TRUE)

#obtain the standard deviation of each variable
calD<-vector("numeric")
for(i in 1:length(mer)){
  calD[i]<-sd(mer[[i]],na.rm = TRUE)
}

#I edit the tags for training and testing
namesLabeslsTrain<-paste(namesLabeslsTrain,".Trainx")
namesLabeslsTest<-paste(namesLabeslsTest,".Testx")

#join the labels into a single vector
namesForNewTable<-c(namesLabeslsTrain,namesLabeslsTest)

#I create a matrix from the 2 vectors with metrics
nM<- rbind(meansNewDb,calD)

#I add the names of the rows and columns
dimnames(nM)<-list(c("Means","standard deviation"),unlist(namesForNewTable))

#I transform the matrix into a table
final_Table<-as.data.table(nM)

#I check the result
View(final_Table)

#finally exported the table to a .csv file
write.table(final_Table,file="./final_table.csv",sep=" ",row.names = TRUE,col.names = TRUE)

###Please to read the file use the following command
##table<- read.csv("./final_table.csv",sep=" ",head=TRUE,row.names =c("Means","standard deviation"))
##remove rownames column
##table$row.names=NULL


