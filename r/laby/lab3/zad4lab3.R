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
	
	#print(PC1)
	
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

	points(PC1,PC2, bg = "black");
}