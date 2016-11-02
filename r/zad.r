## zad 5

install.packages("ggvis")
install.packages("gmodels")
install.packages('e1071', dependencies = TRUE)
install.packages('party')

library(ggvis)
library(gmodels)
library(class)
library(e1071)
library(party)

diabetes <- read.csv("~/Documents/R/diabetes.csv",header = TRUE);

names(diabetes) <- c("pregnant.times", "glucose.concentr", "blood.pressure", "skin.thickness", "insulin", "mass.index", "pedigree.func", "age", "class")

set.seed(1234)
ind <- sample(2, nrow(diabetes), replace=TRUE, prob=c(0.67, 0.33))
diabetes.training <- diabetes[ind==1, 1:8]
diabetes.test <- diabetes[ind==2, 1:8]
diabetes.trainLabels <- diabetes[ind==1, 9]
diabetes.testLabels <- diabetes[ind==2, 9]

diab_pred_knn1 <- knn(train = diabetes.training, test = diabetes.test, cl = diabetes.trainLabels, k=1)
CrossTable(x = diabetes.testLabels, y = diab_pred_knn1, prop.chisq=FALSE)
plot(diab_pred_knn1)

diab_pred_knn3 <- knn(train = diabetes.training, test = diabetes.test, cl = diabetes.trainLabels, k=3)
CrossTable(x = diabetes.testLabels, y = diab_pred_knn3, prop.chisq=FALSE)
plot(diab_pred_knn3)

diab_pred_knn5 <- knn(train = diabetes.training, test = diabetes.test, cl = diabetes.trainLabels, k=5)
CrossTable(x = diabetes.testLabels, y = diab_pred_knn5, prop.chisq=FALSE)
plot(diab_pred_knn5)

diab_pred_knn11 <- knn(train = diabetes.training, test = diabetes.test, cl = diabetes.trainLabels, k=11)
CrossTable(x = diabetes.testLabels, y = diab_pred_knn11, prop.chisq=FALSE)
plot(diab_pred_knn11)

m_dia <- naiveBayes(class ~ ., data = diabetes)

## alternatively:
m_dia <- naiveBayes(diabetes[,-9], diabetes[,9])
table(predict(m_dia, diabetes[,-9]), diabetes[,9])

diabetes.test <- diabetes[ind==2, 1:8]
ind_dia <- sample(2, nrow(diabetes), replace=TRUE, prob=c(0.67, 0.33))

diabetes.training <- diabetes[ind==1, 1:9]
m2_dia <- naiveBayes(class ~ ., data = diabetes.training)
table(predict(m2_dia, diabetes.training[,-9]), diabetes.training[,9])

diabetes.test <- diabetes[ind==2, 1:9]
m3_dia <- naiveBayes(class ~ ., data = diabetes.test)
table(predict(m3_dia, diabetes.test[,-9]), diabetes.test[,9])

diabetes_ctree <- ctree(class ~ pregnant.times + glucose.concentr + blood.pressure + skin.thickness + insulin + mass.index + pedigree.func + age, data=diabetes)
print(diabetes_ctree)
plot(diabetes_ctree)

install.packages('RWeka')
library(RWeka)

diabetes_j48 <- J48(class ~ ., data = diabetes)
diabetes_j48

diabetes_j482 <- J48(class ~ ., data = diab_pred_knn1)

eval_j48 <- evaluate_Weka_classifier(diabetes_j48, numFolds = 10, complexity = FALSE, 
    seed = 1, class = TRUE)

eval_j48 <- evaluate_Weka_classifier(diab_pred_knn1, numFolds = 10, complexity = FALSE, 
    seed = 1, class = TRUE)

##  zad 6

#a
adult <- read.csv("~/Documents/R/adult.dat",header=FALSE,na.strings ="?")

# ILE JEST NA W KAZDEJ KOLUMNIE
for( i in seq(15)){ 
  print(summary(is.na(adult[,i])))}

nrow(adult) #ilosc wierszy oryginalnie
adult.delete <- na.omit(adult)
(ilosc_po_skasowaniu <- nrow(adult)-nrow(adult.delete))

#b
adult.mean <- adult
kolumny_liczbowe = c(1,3,5,11,12,13)
for (i in kolumny_liczbowe){
  i = as.numeric(i)
  adult.mean[,i][is.na(adult.mean[,i])] <- round(mean(adult.mean[,i], na.rm = TRUE))
  print(round(mean(adult.mean[,i], na.rm = TRUE)))}

#c
pow50K <- subset(adult, V15 == ">50K") 
for (i in kolumny_liczbowe){
  i = as.numeric(i)
  pow50K[,i][is.na(pow50K[,i])] <- round(mean(pow50K[,i], na.rm = TRUE))
  print(round(mean(pow50K[,i], na.rm = TRUE)))}

pon50K <- subset(adult, V15 == "<=50K")
for (i in kolumny_liczbowe){
  i = as.numeric(i)
  pon50K[,i][is.na(pon50K[,i])] <- round(mean(pon50K[,i], na.rm = TRUE))
  print(round(mean(pon50K[,i], na.rm = TRUE)))}

adult.mean.c <- rbind(pow50K, pon50K)

#d
pow50Km <- subset(adult, V15 == ">50K") 
for (i in kolumny_liczbowe){
  i = as.numeric(i)
  pow50Km[,i][is.na(pow50Km[,i])] <- round(median(pow50Km[,i], na.rm = TRUE))
  print(round(median(pow50Km[,i], na.rm = TRUE)))}

pon50Km <- subset(adult, V15 == "<=50K")
for (i in kolumny_liczbowe){
  i = as.numeric(i)
  pon50Km[,i][is.na(pon50Km[,i])] <- round(median(pon50Km[,i], na.rm = TRUE))
  print(round(median(pon50Km[,i], na.rm = TRUE)))}

adult.median.c <- rbind(pow50Km, pon50Km)

#e
pow50Ks <- subset(adult, V15 == ">50K")
pon50Ks <- subset(adult, V15 == "<=50K")
kolumny_tekstowe <- c(2,4,6,7,8,9,10,14)

for (i in kolumny_tekstowe){  
  x <- sort(table(pow50Ks[,i], useNA="ifany"), decreasing = TRUE) # x najcz. wyst. wyraz
  print(names(x[1]))
  pow50Ks[,i][is.na(pow50Ks[,i])] <- names(x[1])
}

for (i in kolumny_tekstowe){    x <- sort(table(pon50Ks[,i], useNA="ifany"), decreasing = TRUE) # x najcz. wyst. wyraz
  print(names(x[1]))
  pon50Ks[,i][is.na(pon50Ks[,i])] <- names(x[1])
}

