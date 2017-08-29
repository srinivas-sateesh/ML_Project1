rm(list=ls(all=TRUE))

sample <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/mushroom/agaricus-lepiota.data"))

1:ncol(sample)


colnames(sample)[1]<- "target"
colnames(sample)[2]<-"capshape"
colnames(sample)[3]<-"capsurface"
colnames(sample)[4]<-"capcolor"
colnames(sample)[5]<-"bruises"
colnames(sample)[6]<-"odor"
colnames(sample)[7]<-"gillattachment"
colnames(sample)[8]<-"gillspacing"
colnames(sample)[9]<-"gillsize"
colnames(sample)[10]<-"gillcolor"
colnames(sample)[11]<-"stalkshape"

colnames(sample)[12]<-"stalkroot"
colnames(sample)[13]<-"stalksurfaceabovering"
colnames(sample)[14]<-"stalksurfacebelowring"
colnames(sample)[15]<-"stalkcolorabovering"
colnames(sample)[16]<-"stalkcolorbelowring"
colnames(sample)[17]<-"veiltype"
colnames(sample)[18]<-"veilcolor"
colnames(sample)[19]<-"ringnumber"
colnames(sample)[20]<-"ringtype"
colnames(sample)[21]<-"sporeprintcolor"
colnames(sample)[22]<-"population"
colnames(sample)[23]<-"habitat"


library(randomForest)
RFModel <- randomForest(sample$target~.,data = sample,ntree =100)
summary(RFModel)
Important_Var <- RFModel$importance
Important_Var <- as.data.frame(Important_Var)
Important_Var$Col_Names <- rownames(Important_Var)
Important_Var_Order <- Important_Var[order(Important_Var$MeanDecreaseGini,decreasing = T),]
sample_Final <- subset(sample,select = Important_Var_Order$Col_Names[1:10]) 
sample_Final$Target <- sample$target




