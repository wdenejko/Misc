d1 <- c(2,1,0,0,0)
d2 <- c(1,1,0,0,1)
d3 <- c(0,0,3,1,0)
d4 <- c(1,0,2,1,1)
df = data.frame(d1,d2,d3,d4)
rownames(df) <- c("system","operating","programming","exercise","guide")
mat <- svd(df)

# mat // U - slowa, D - przkatna, V- dokumenty
mat <- mat$d

#utrata informacji wzór z wyk³adu
#
#	1 - (x^2+y^2)/(x^2+y^2+z^2+w^2)
#
# ¿eby nie przekroczyæ trzeba obci¹æ 3
# 0.01411229

obc <- 1 - (mat[1]^2+mat[2]^2+mat[3]^2)/(mat[1]^2+mat[2]^2+mat[3]^2+mat[4]^2)

# zad 1 		b)

calculateCommonMatrix <- function(book1, book2)
{
	columns <- NCOL(book1)
	upperSumm <- 0
	lowerSumm <- 0
	firstSQRT <- 0 
	secondSQRT <- 0
	
	for(i in 1:4)
	{
		upperSumm <- upperSumm + (book1[i] * book2[i])
		firstSQRT <- firstSQRT + book1[i]^2
		secondSQRT <- firstSQRT + book2[i]^2
	}

	lowerSumm <- sqrt(firstSQRT) * sqrt(secondSQRT)
	
	return(1-upperSumm/lowerSumm)
}

mat <- svd(df)
book1 <- mat$v[,1]
book2 <- mat$v[,2]
book3 <- mat$v[,3]
book4 <- mat$v[,4]

result1 <- calculateCommonMatrix(book1,book2)
result2 <- calculateCommonMatrix(book1,book3)
result3 <- calculateCommonMatrix(book1,book4)

# zad2

# -N
#  Normalize input data.
# -R
#  Rank approximation used in LSA. May be actual number of 
#  LSA attributes to include (if greater than 1) or a proportion 
#  of total singular values to account for (if between 0 and 1). 
#  A value less than or equal to zero means use all latent variables.
#  (default = 0.95)
# -A
#  Maximum number of attributes to include in 
#  transformed attribute names. (-1 = include all)

#zad3

letter <- array(0:0, dim = c(24,24))

letter[3,11] <- 1
letter[3,10] <- 1
letter[3,12] <- 1
letter[3,13] <- 1
letter[3,14] <- 1

letter[22,14] <- 1
letter[22,13] <- 1
letter[22,12] <- 1
letter[22,11] <- 1
letter[22,10] <- 1



