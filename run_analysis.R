if(!file.exists("./data")){dir.create("./data")}
dtranX<- read.csv(text=sub(" ","",gsub("  "," ",readLines("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"))),sep=" ",head=FALSE)
dtestX<- read.csv(text=sub(" ","",gsub("  "," ",readLines("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"))),sep=" ",head=FALSE)
namesLabesls<-read.csv("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt",sep=" ",head=FALSE)
namesLabeslsTrain<-unlist(namesLabesls$V2)
namesLabeslsTest<-unlist(namesLabesls$V2)
# library(dplyr)
# namesUnList<-unlist(namesLabesls$V2)
# oldNames<- names(dtranX)
# for(i in 1:length(oldNames)){ 
#   dtranX<-raname(dtranX,namesUnList[i] = oldNames[i])
# }

##merging

dtranX$id<- 1:length(dtranX[[1]])
dtestX$id<- 1:length(dtestX[[1]])

mer<- merge(dtranX,dtestX,by.x = "id",by.y = "id",all=TRUE)
#means
meansNewDb<-colMeans(mer,na.rm = TRUE)
#standard deviation
calD<-vector("numeric")
for(i in 1:length(mer)){
  calD[i]<-sd(mer[[i]])
}

namesLabeslsTrain<-paste(namesLabeslsTrain,".Trainx")
namesLabeslsTest<-paste(namesLabeslsTest,".Testx")

namesForNewTable<-c(namesLabeslsTrain,namesLabeslsTest)


