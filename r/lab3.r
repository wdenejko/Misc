# 1. a
dane <- read.csv("~/Documents/R/iris.csv",header = TRUE);

irysy <- dane
# 1. b
cor(dane[[1]],dane[[2]])
cor(dane[[1]],dane[[3]])
cor(dane[[1]],dane[[4]])
cor(dane[[2]],dane[[3]])
cor(dane[[2]],dane[[4]])
cor(dane[[3]],dane[[4]])

# 2.
# a.
iris.numeric = dane[c(1:4)]
# b.
logDane = log(dane[c(1:4)])
# c.
scaleDane = scale(logDane)

# 3.
# a.
iris.preproc = scaleDane
# b.
iris.pca = prcomp(iris.preproc)
irysybezkolumn <- iris.pca[1]$rotation[1:8]
irysybezkolumn
irysybezkolumn2 <- iris.pca[2]$rotation[1:8]
irysybezkolumn2
# c.
predict(iris.pca)
iris2 <-  data.frame(iris.original$sepallength, iris.original$sepalwidth , iris.original$petallength, iris.original$petalwidth)
irysylog <- log(iris2)
irysyscale <- scale(irysylog)
irysy2.pca <- prcomp(irysyscale)

pcamatrix <- matrix(irysybezkolumn2[1:4], nrow=4, ncol=1)
scalematrix <- matrix(irysyscale[1,], nrow=1, ncol=4)

cat("Wynik mnozenia macierzy: ",scalematrix %*% pcamatrix,"\n")
cat("Liczba:", predict(iris.pca)[1],"\n")

# e.
iris.pca.data <- predict(irysy2.pca)[,1:2]
iris.pca.data <- cbind(iris.pca.data,irysy[5:5])

# 4.
attach(iris.pca.data); plot(PC1,PC2, col=c("red","blue","green")[class]); detach(iris.pca.data)
legend('topright', legend = c('Setosa', 'Versicolor', 'Virginica'), col=c('red', 'blue', 'green'), pch = c(21,21), bty='o', cex=.6)

# 5.
recognizeIris <- function(sepllength,sepalwidth,petallength,petalwidth)
{
	irysnew <-  c(sepllength,sepalwidth,petallength,petalwidth)
	iryslog <- log(irysnew)
	irysscale <- scale(iryslog)

	#scale powinnismy obliczyc samemu scale(sepl)  =  sqpL - Mean(logSepL)/sd(logSepL))
	#i tak dla ka¿dego

	pcamatrix <- matrix(irysybezkolumn[1:4], nrow=4, ncol=1)
	scalematrix <- matrix(irysscale[1,], nrow=1, ncol=4)
	PC1 <- scalematrix %*% pcamatrix
	
	pcamatrix <- matrix(irysybezkolumn[5:8], nrow=4, ncol=1)
	scalematrix <- matrix(irysscale[1,], nrow=1, ncol=4)

	PC2 <- scalematrix %*% pcamatrix

	if(PC1 < -1)
		newirys <- data.frame(PC1,PC2,"Setosa")
	else if(PC1 > 0 && PC1 < 1)
		newirys <- data.frame(PC1,PC2,"Versicolor")
	else if(PC1 > 1)
		newirys <- data.frame(PC1,PC2,"Virginica")

	print(newirys)
	points(PC1,PC2);
}

recognizeIris(6.9, 3.2, 5.6, 2.2)
recognizeIris(6.0, 2.6, 4.4, 1.6)
recognizeIris(4.8, 3.6, 1.4, 0.2)
