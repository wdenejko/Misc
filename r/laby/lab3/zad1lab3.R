irysy <- read.csv("~/Documents/R/iris.csv")
iris2 <-  data.frame(iris.original$sepallength, iris.original$sepalwidth , iris.original$petallength, iris.original$petalwidth)
irysylog <- log(iris2)
irysyscale <- scale(irysylog)
irysy2.pca <- prcomp(irysyscale)
irysy2.pca

# wariancja to odchylenie standardowe podniesione do kwadratu !!

# b) irysy2.pca dwie kolumny najlepsze zostawiamy z tego (czyli dwie pierwsze)

irysybezkolumn <- irysy2.pca[2]$rotation[1:8]
irysybezkolumn

# c)irysyscale pierwszy wiersz * irysy2.pca pierwsza kolumna (suma) i sprawdzamy czy jest to PC1 
# mno¿enie macierzy

pcamatrix <- matrix(irysybezkolumn[1:4], nrow=4, ncol=1)
scalematrix <- matrix(irysyscale[1,], nrow=1, ncol=4)

cat("Wynik mno¿enia macierzy: ",scalematrix %*% pcamatrix,"\n")

cat("Liczba:", predict(irysy2.pca)[1],"\n")

#zad d) Porównanie irysyscale$SepalLength itp. z PC1 , PC2
# PC2 sepallenght i sepalwidth korelacja wyraŸnie ujemna, reszta bliska 0
#

#zad e)

iris.pca.data <- predict(irysy2.pca)[,1:2]
iris.pca.data <- cbind(iris.pca.data,irysy[5:5])

#zad 3 

attach(iris.pca.data); plot(PC1,PC2, col=c("red","blue","green")[class]); detach(iris.pca.data)
legend('topright', legend = c('Setosa', 'Versicolor', 'Virginica'), col=c('red', 'blue', 'green'), pch = c(21,21), bty='o', cex=.6)

#zad 4 

recognizeIris(6.9, 3.2, 5.6, 2.2)
recognizeIris(6.0, 2.6, 4.4, 1.6)
recognizeIris(4.8, 3.6, 1.4, 0.2)


