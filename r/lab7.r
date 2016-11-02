
install.packages("neuralnet")
install.packages("ggvis")
install.packages("gmodels")
install.packages('e1071', dependencies = TRUE)
install.packages('party')

library(ggvis)
library(gmodels)
library(class)
library(e1071)
library(party)

install.packages("arules")
install.packages("arulesViz")
library(arules)
library(arulesViz)


library(neuralnet)

siatk.dane <- read.csv("~/Documents/R/sieci.csv",header = TRUE);
siatk.nn <- neuralnet(gra~wiek+waga+wzrost, siatk.dane, hidden=2, lifesign="full")
plot(siatk.nn)


## X = a * w1 + b * w2 + c * w3
test <- function(x,y,z) {
	wewX <- x * -0.46122 + y * 0.97314 + z * -0.39203 + 0.80109
	wewY <- x * 0.78548 + y * 2.10684 + z * -0.57847 + 0.43529
	zewX <- 1/(1+exp(-wewX))
	zewY <- 1/(1+exp(-wewY))
	wynik <- zewX * -0.81546 + zewY * 1.03775 + -0.2368

	return (wynik)
}

siatk.predict <- compute(siatk.nn, siatk.dane[1:3])

# zad 2

iris <- read.csv("~/Documents/R/iris.csv", header = FALSE) 

names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

normalize <- function(x) {
num <- x - min(x)
denom <- max(x) - min(x)
return (num/denom)
}

iris_norm <- as.data.frame(lapply(iris[1:4], normalize))
summary(iris_norm)

set.seed(1234)

ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
itrain <- iris[sample(1:150, 50),]

itrain$setosa <- c(itrain$Species == "setosa")
itrain$versicolor <- c(itrain$Species == "versicolor")
itrain$virginica <- c(itrain$Species == "virginica")
itrain$Species <- NULL

inet <- neuralnet(setosa + versicolor + virginica ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, itrain, hidden=3, lifesign="full")
plot(inet, rep="best")
plot(inet, rep=”best”, intercept=FALSE)

predict <- compute(inet, iris[1:4])

result<-0
for (i in 1:150) { result[i] <- which.max(predict$net.result[i,]) }

for (i in 1:150) { if (result[i]==1) {result[i] = "setosa"} }

for (i in 1:150) { if (result[i]==2) {result[i] = "versicolor"} }

for (i in 1:150) { if (result[i]==3) {result[i] = "virginica"} }

comparison <- iris

comparison$Predicted <- result

# zad 3 

diabetes <- read.csv("~/Documents/R/diabetes.csv",header = TRUE);

normalize <- function(x) {
num <- x - min(x)
denom <- max(x) - min(x)
return (num/denom)
}

diabetes_norm <- as.data.frame(lapply(diabetes[1:8], normalize))
summary(diabetes_norm)

inddiab <- sample(2, nrow(diabetes), replace=TRUE, prob=c(0.7, 0.3))
diabtrain <- diabetes[sample(1:150, 50),]

diabtrain$tested_positive <- c(diabtrain$class == "tested_positive")
diabtrain$tested_negative <- c(diabtrain$class == "tested_negative")
itrain$class <- NULL

diabnet <- neuralnet(tested_positive + tested_negative ~ pregnant.times + glucose.concentr + blood.pressure + skin.thickness + insulin + mass.index + pedigree.func + age, diabtrain, hidden=3, lifesign="full")
plot(diabnet, rep="best")

predict <- compute(diabnet, diabetes[1:8])
for (i in 1:768) { result[i] <- which.max(predict$net.result[i,]) }

for (i in 1:768) { if (result[i]==1) {result[i] = "tested_positive"} }

for (i in 1:768) { if (result[i]==2) {result[i] = "tested_negative"} }

comparison <- diabetes
comparison$Predicted <- result


sum(comparison$class == "tested_negative")
sum(comparison$class == "tested_positive")

sum(comparison$Predicted == "tested_negative")
sum(comparison$Predicted == "tested_positive")

# zad 7

str(titanic.raw)
rules <- apriori(titanic.raw)
inspect(rules)

rules <- apriori(titanic.raw,
 parameter = list(minlen=2, supp=0.005, conf=0.8),
 appearance = list(rhs=c("Survived=No", "Survived=Yes"),
 default="lhs"),
 control = list(verbose=F))

 
 rules.sorted <- sort(rules, by="lift")
 inspect(rules.sorted)
 
  subset.matrix <- is.subset(rules.sorted, rules.sorted)
  subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
  redundant <- colSums(subset.matrix, na.rm=T) >= 1
  which(redundant)

  rules.pruned <- rules.sorted[!redundant]
  inspect(rules.pruned)

  plot(rules)
  plot(rules, method="paracoord", control=list(reorder=TRUE))

