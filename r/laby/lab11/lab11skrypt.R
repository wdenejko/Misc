books <- read.csv('bookszad4.csv')
book1 <- books[13,]
book2 <- books[14,]
book3 <- books[6,]

calculateCommonMatrix <- function(book1, book2)
{

	columns <- NCOL(book1)
	upperSumm <- 0
	lowerSumm <- 0
	firstSQRT <- 0 
	secondSQRT <- 0
	
	for(i in 1:columns)
	{
		upperSumm <- upperSumm + (book1[1,i] * book2[1,i])
		firstSQRT <- firstSQRT + book1[1,i]^2
		secondSQRT <- firstSQRT + book2[1,i]^2
	}

	lowerSumm <- sqrt(firstSQRT) * sqrt(secondSQRT)
	
	return(1-upperSumm/lowerSumm)
}

result1 <- calculateCommonMatrix(book1,book2)
result2 <- calculateCommonMatrix(book1,book3)

calculateMatrix <- function(data)
{

	columns <- NCOL(data)
	rows <- NROW(data)
	upperSumm <- 0
	lowerSumm <- 0
	firstSQRT <- 0 
	secondSQRT <- 0

	matrix_sum <- matrix(nrow=rows, ncol=rows)

	for(l in 1: rows)
	{
		for(j in 1:rows)
		{
			for(i in 1:columns)
			{
				upperSumm <- upperSumm + (data[l,i] * data[j,i])
				firstSQRT <- firstSQRT + data[l,i]^2
				secondSQRT <- firstSQRT + data[j,i]^2
			}

			lowerSumm <- sqrt(firstSQRT) * sqrt(secondSQRT)
			matrix_sum[l,j] <- round(1-upperSumm/lowerSumm,digits=5)

			upperSumm <- 0
			lowerSumm <- 0
			firstSQRT <- 0 
			secondSQRT <- 0
		}	
	}

	colnames(matrix_sum) <- c(paste("D", 1:rows))
	rownames(matrix_sum) <- c(paste("D", 1:rows))
	return(matrix_sum)
}

result3 <- calculateMatrix(books)