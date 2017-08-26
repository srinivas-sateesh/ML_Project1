rm(list=ls(all=TRUE))
mushroom<-read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/mushroom/agaricus-lepiota.data"))

1:ncol(mushroom)
colnames(mushroom) <- sapply(1:ncol(mushroom) , function(x) paste0("col",x))

mushroom$col2
colnames(mushroom)[1]<- "class"
colnames(mushroom)[2]<-"capshape"
colnames(mushroom)[3]<-"capcolor"
colnames(mushroom)[4]<-"bruises"
colnames(mushroom)[5]<-"odor"
colnames(mushroom)[6]<-"gillattachment"
colnames(mushroom)[7]<-"gillspacing"
colnames(mushroom)[8]<-"gillsize"
colnames(mushroom)[9]<-"gillcolor"
colnames(mushroom)[10]<-"stalkshape"

colnames(mushroom)[11]<-"stalkroot"
colnames(mushroom)[12]<-"stalksurfaceabovering"
colnames(mushroom)[13]<-"stalksurfacebelowring"
colnames(mushroom)[14]<-"stalkcolorabovering"
colnames(mushroom)[15]<-"stalkcolorbelowring"
colnames(mushroom)[16]<-"veiltype"
colnames(mushroom)[17]<-"veilcolor"
colnames(mushroom)[18]<-"ringnumber"
colnames(mushroom)[19]<-"ringtype"
colnames(mushroom)[20]<-"sporeprintcolor"
colnames(mushroom)[21]<-"population"
colnames(mushroom)[22]<-"habitat"

mushroom$class = as.character(mushroom$class) 
mushroom$class[mushroom$class == "e"] = "edible"
mushroom$class[mushroom$class == "p"] = "poisonous"
mushroom$class = as.factor(mushroom$class)

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