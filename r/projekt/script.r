#- load packages
library(jsonlite)
library(tm)
library(data.table)
library(Matrix)
library(caret)
library(SnowballC)
library(xgboost)
library(Ckmeans.1d.dp)
library(randomForest)
library(class)

#- load data files and flatten
train <- fromJSON('~/Documents/R/projekt/train.json', flatten = TRUE)
test <- fromJSON('~/Documents/R/projekt/test.json', flatten = TRUE)

treatment<-function(fname){
fname$ingredients <- lapply(fname$ingredients, tolower) 
fname$ingredients <- lapply(fname$ingredients, function(x) gsub("-", "_", x)) 
fname$ingredients <- lapply(fname$ingredients, function(x) gsub("[^a-z0-9_ ]", "", x))
}
treatment(train)
treatment(test)

MyCorpus <- Corpus(VectorSource(train$ingredients))
MyCorpus2 <- Corpus(VectorSource(test$ingredients))
MyCorpus <- tm_map(MyCorpus, stemDocument, lazy=TRUE) 
MyCorpus2 <- tm_map(MyCorpus2, stemDocument, lazy=TRUE)
ingredientsDTM <- DocumentTermMatrix(MyCorpus) 
ingredientsDTM2 <- DocumentTermMatrix(MyCorpus2)
sparse <- removeSparseTerms(ingredientsDTM, 0.98) 
sparse2 <- removeSparseTerms(ingredientsDTM2, 0.98) 
ingredientsDTM <- as.data.frame(as.matrix(sparse)) 
ingredientsDTM2 <- as.data.frame(as.matrix(sparse2))

trainColumns<-names(ingredientsDTM) 
testColumns<-names(ingredientsDTM2)

intersect<-intersect(trainColumns,testColumns)
ingredientsDTM<- ingredientsDTM[,c(intersect)] 
ingredientsDTM2<- ingredientsDTM2[,c(intersect)] 
ingredientsDTM$cuisine <- as.factor(train$cuisine)
names(ingredientsDTM) <- gsub("-", "", names(ingredientsDTM)) 
names(ingredientsDTM2) <- gsub("-", "", names(ingredientsDTM2))

forestmodel <- randomForest(cuisine ~., data=ingredientsDTM, importance=TRUE, ntree=50) 
forestPredict<-predict(forestmodel, newdata = ingredientsDTM2, type = "class")
submission <- data.frame(id = test$id, cuisine = forestPredict)
write.csv(submission, "randomForest.csv", quote = FALSE, row.names = FALSE)

bayesModel <- naiveBayes(cuisine ~ ., data = ingredientsDTM)
bayesPredict <- predict(bayesModel, ingredientsDTM2[-162])
bayesSubmission <- data.frame(id = test$id, cuisine = bayesPredict)
write.csv(bayesSubmission, "~/Documents/R/projekt/naiveBayes.csv", quote = FALSE, row.names = FALSE)

knnPred <- knn(train = ingredientsDTM, test = ingredientsDTM2, cl = ingredientsDTM2[2], k=3)


