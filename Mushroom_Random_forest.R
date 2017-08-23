rm(list=ls(all=TRUE))
sample <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/mushroom/agaricus-lepiota.data"))
##col_names <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/mushroom/agaricus-lepiota.names"))
1:ncol(sample)
colnames(sample) <- sapply(1:ncol(sample) , function(x) paste0("col",x))
 
sample$col2
colnames(sample)[1]<- "target"
 
table(sample$target,sample$col2)
 
 

library(randomForest)
RFModel <- randomForest(sample$target~.,data = sample,ntree =100)
Important_Var <- RFModel$importance
Important_Var <- as.data.frame(Important_Var)
Important_Var$Col_Names <- rownames(Important_Var)
Important_Var_Order <- Important_Var[order(Important_Var$MeanDecreaseGini,decreasing = T),]
sample_Final <- subset(sample,select = Important_Var_Order$Col_Names[1:10]) 
sample_Final$Target <- sample$target




