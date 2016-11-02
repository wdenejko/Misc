iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), header = FALSE) 

names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

install.packages("ggvis")
library(ggvis)

iris %>% ggvis(~Petal.Length, ~Petal.Width, fill = ~Species) %>% layer_points()

table(iris$Species) 

summary(iris)

library(class) # KNN

normalize <- function(x) {
num <- x - min(x)
denom <- max(x) - min(x)
return (num/denom)
}

iris_norm <- as.data.frame(lapply(iris[1:4], normalize))
summary(iris_norm)

set.seed(1234)

ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))
iris.training <- iris[ind==1, 1:5]
iris.test <- iris[ind==2, 1:4]

iris.trainLabels <- iris[ind==1, 5]
iris.testLabels <- iris[ind==2, 5]

iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k=3)

install.packages("gmodels")
library(gmodels)

CrossTable(x = iris.testLabels, y = iris_pred, prop.chisq=FALSE)

# NAIVE BYTES
install.packages('e1071', dependencies = TRUE)
library(e1071)

## Example with metric predictors:
data(iris)
m <- naiveBayes(Species ~ ., data = iris)
## alternatively:
m <- naiveBayes(iris[,-5], iris[,5])
table(predict(m, iris[,-5]), iris[,5])

iris.test <- iris[ind==2, 1:4]

ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))

iris.training <- iris[ind==1, 1:5]
m2 <- naiveBayes(Species ~ ., data = iris.training)
table(predict(m2, iris.training[,-5]), iris.training[,5])

iris.test <- iris[ind==2, 1:5]
m3 <- naiveBayes(Species ~ ., data = iris.test)
table(predict(m3, iris.test[,-5]), iris.test[,5])


# DRZEWA DECYZYJNE
install.packages('party')
library(party)
iris_ctree <- ctree(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data=iris)
print(iris_ctree)
plot(iris_ctree)













