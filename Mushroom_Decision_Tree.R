rm(list=ls(all=TRUE))
mushroom <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/mushroom/agaricus-lepiota.data"))
#str(mushroom)
set.seed(1234)
1:ncol(mushroom)
colnames(mushroom) <- sapply(1:ncol(mushroom) , function(x) paste0("col",x))

mushroom$col2
colnames(mushroom)[1]<- "class"
colnames(mushroom)[2]<-"capshape"
colnames(mushroom)[3]<-"capsurface"
colnames(mushroom)[4]<-"capcolor"
colnames(mushroom)[5]<-"bruises"
colnames(mushroom)[6]<-"odor"
colnames(mushroom)[7]<-"gillattachment"
colnames(mushroom)[8]<-"gillspacing"
colnames(mushroom)[9]<-"gillsize"
colnames(mushroom)[10]<-"gillcolor"
colnames(mushroom)[11]<-"stalkshape"

colnames(mushroom)[12]<-"stalkroot"
colnames(mushroom)[13]<-"stalksurfaceabovering"
colnames(mushroom)[14]<-"stalksurfacebelowring"
colnames(mushroom)[15]<-"stalkcolorabovering"
colnames(mushroom)[16]<-"stalkcolorbelowring"
colnames(mushroom)[17]<-"veiltype"
colnames(mushroom)[18]<-"veilcolor"
colnames(mushroom)[19]<-"ringnumber"
colnames(mushroom)[20]<-"ringtype"
colnames(mushroom)[21]<-"sporeprintcolor"
colnames(mushroom)[22]<-"population"
colnames(mushroom)[23]<-"habitat"

mushroom$class = as.character(mushroom$class) 
mushroom$class[mushroom$class == "e"] = "edible"
mushroom$class[mushroom$class == "p"] = "poisonous"
mushroom$class = as.factor(mushroom$class)


ind<-sample(2,nrow(mushroom),replace=TRUE,prob=c(0.7,0.3))
train.data<-mushroom[ind==1,]
test.data<-mushroom[ind==2,]
library(party)
myFormula <- class ~ capshape+capsurface+capcolor+bruises+odor+gillattachment+gillspacing+gillsize+gillcolor+stalkshape+stalkroot+stalksurfaceabovering+ stalksurfacebelowring+stalkcolorabovering+stalkcolorbelowring+veiltype+veilcolor+ringnumber+ringtype+sporeprintcolor+population+habitat
#Binary tree
mushroom_ctree<-ctree(myFormula,data=train.data)
#check how prediction has worked
table(predict(mushroom_ctree),train.data$class)
print(mushroom_ctree)

#Display the decision tree
plot(mushroom_ctree)
plot(mushroom_ctree,type="simple")

#Apply Decision tree on test data

testPred <- predict(mushroom_ctree,newdata=test.data)
finalPrediction<-table(testPred,test.data$class)
print(finalPrediction)