# Wczytanie danych z pliku

computers <- read.csv("computer_purchase.csv")

# 1.
S <- NROW(computers)
S1 <- sum(computers$buys == 'yes')
S2 <- sum(computers$buys == 'no')
P1 <- S1/S
P2 <- S2/S
Entr <- -P1*log(P1, base = 2)-P2*log(P2, base = 2)

# 1,2.

entropy <- function(table1,table2){

	Adata <- table(table2)
 	count.data <- table(table1,table2)
	I <- array(0:0, dim = c(1,NROW(count.data)))
	S <- I
	E <- 0
	Sall <- 0
	A <- 0

	for(h in 1:NROW(Adata))
	{
		A <- A - sum(Adata[h])/sum(Adata)*log(sum(Adata[h])/sum(Adata),base = 2)	
	}

	for(i in 1:NROW(count.data))
	{
		m <- NROW(count.data[1,])
		
		S[i] <- sum(count.data[i,])
		Sall <- Sall + S[i]	
				
		for(j in 1:m)
		{
			I[i] = I[i] + (- count.data[i,j]/S[i]*log(count.data[i,j]/S[i],base = 2))
		}
	
		if(!is.finite(I[i]))
			I[i] = 0
	}

	for(i in 1:NROW(count.data))
	{
		E <- E + S[i]/Sall*I[i]
	}
	
	return(A[1] - E)
}

wynik1 <- entropy(computers$age,computers$buys)
wynik2 <- entropy(computers$income,computers$buys)
wynik3 <- entropy(computers$student,computers$buys)
wynik4 <- entropy(computers$credit.rating,computers$buys)

#age 		0.2467498
#income 	0.02922257
#student	0.1518355
#credit	0.04812703

# 3

firstt <- computers[computers$age == "<=30",]
firstt <- firstt[,2:5]
wynik <- entropy(firstt$income,firstt$buys)

#0.5709506

wynik <- entropy(firstt$student,firstt$buys)

#0.9709506

wynik <- entropy(firstt$credit.rating,firstt$buys)

#0.01997309

secondt <- computers[computers$age == "31..40",]
secondt <- secondt[,2:5]
wynik <- entropy(secondt$income,secondt$buys)

#NaN

wynik <- entropy(secondt$student,secondt$buys)

#NaN

wynik <- entropy(secondt$credit.rating,secondt$buys)

#NaN

thirdt <- computers[computers$age == ">40",]
thirdt <- thirdt[,2:5]
print(thirdt[1])
wynik <- entropy(thirdt$income,thirdt$buys)

#0.01997309

wynik <- entropy(thirdt$student,thirdt$buys)

#0.01997309

wynik <- entropy(thirdt$credit.rating,thirdt$buys)

#0.9709506

# 4 

classifyC45 <- function(data)
{
	uni <- unique(data[1],incomparables = FALSE)
	
	index <- 0
	wynik <- 0 

	for(i in 1:length(uni[,1]))
	{
		age <- toString(uni[i,])

		datan <- data[data$age == age,]
		datan <- datan[,2:NCOL(datan)]	

		for(j in 1:NCOL(datan))
		{
			new <- entropy(t(datan[j]),t(datan[4]))	

			if(wynik < new)
				index <- i
			else if(wynik == 0)
				index <- "yes"
		}
		
		if(index != "yes")
		{	
			print(sprintf("age = %s ",age))
			print(sprintf("     %s = no: no ",colnames(datan[index])))
			print(sprintf("     %s = yes: yes ",colnames(datan[index])))
		}
		if(index == "yes")
			print(sprintf("age = %s: yes ",age))

		wynik <- 0
		index <- 0
	}
}

# Rekurencja do rozbijania g³êbiej w drzewie, studenta rozbijamy 
# na dwie podgrupy zeby okreslic czy tak czy nie





