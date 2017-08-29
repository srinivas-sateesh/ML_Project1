rm(list=ls(all=TRUE))
mushroom<-read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/mushroom/agaricus-lepiota.data"))

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

# Remove incomplete data.
mushroom$veiltype = NULL
mushroom$stalkroot = NULL

library(ggplot2)
library(caret)
library(gridExtra)

set.seed(123) 

names(mushroom)
head(mushroom)

# Explore the data.
qp1 = qplot(capcolor, habitat, color = class, data = mushroom, geom = "jitter", main = "Mushroom data set - Cap color vs Habitat")
qp2 = qplot(capcolor, habitat, color = class, data = mushroom, geom = "jitter", facets = bruises ~ ., main = "Mushroom data set by Bruises - Cap color vs Habitat")
qp3 = qplot(odor, sporeprintcolor, color = class, data = mushroom, geom = "jitter", main = "Mushroom data set - Odor vs Spore Print Color")
qp4 = qplot(stalksurfacebelowring, stalkcolorabovering, color = class, data = mushroom, geom = "jitter", main = "Mushroom data set - Stalk Surface below Ring vs Stalk Color above Ring")

grid.arrange(qp1, qp2, qp3, qp4, ncol = 2, nrow = 2)

#Knn
library(class)
#Split data into train and test
sub<-sample(nrow(mushroom),floor(nrow(mushroom) * .7))
#training_split <-createDataPartition(y=mushroom$class,p=0.70,list=FALSE)
training_set <- mushroom[sub,]
testing_set <- mushroom[-sub,]
table(mushroom$class)
table(training_set$class)
table(testing_set$class)

traindatawithoutclass<-subset(training_set,select = -c(class))
testdatawithoutclass<-subset(testing_set,select = -c(class))
pred = knn(traindatawithoutclass,testdatawithoutclass,training_set$class,k=1) 
#print(model_fit)
#plot(model_fit)
#print(model_fit)
#plot(model_fit)
