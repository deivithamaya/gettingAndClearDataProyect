if(!file.exists("./data")){dir.create("./data")}
dtx<- read.csv(text=sub(" ","",gsub("  "," ",readLines("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"))),sep=" ",head=FALSE)
dty<-
head(dtx)


