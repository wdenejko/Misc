irys <- read.csv('iris.csv')
irys <- irys[,1:4]

clusterKN <- function(data, k, points)
{
	attr <- NCOL(data)
	howmuch <- NROW(data)	
	claster <- array(0:0, dim = c(howmuch,1))
	value <- array(0:0, dim = c(attr,k))#wartosci do porownania 
	
	for(i in 1:howmuch)
	{
		for(l in 1:k)
		{
			for(j in 1:attr)
			{
				value[j,l] <- ((points[l,j]-data[i,j])^2)
				#cat(value[j,l],"\n")
			}
		}

		for(l in 1:k)
		{
			value[l,1] <- sum(value[,l])
			#cat(value[1,l],"\n")
		}

		#index <- which(value == min(value[1,]), arr.ind=TRUE)

		#return(index)
	}
	cat(value[1,])
}

clusterKNpoints <- function(data, k)
{

	attr <- NCOL(data)
	howmuch <- NROW(data)	

	points <- array(0:0, dim = c(2,attr))

	for(i in 1:k)
	{
		for(j in 1:attr)
		{
			rand <- runif(1, min(data[,i]), max(data[,i]))
			points[i,j] <- rand
		}
	}

	return(points)
}

points <- clusterKNpoints(irys,2)


# ko³o

#Co to jest korelacja
#Wspolczynnik pearsona i jakie wartosci przyjmuje, co oznaczaja
#Analiza g³ownych skladowych. Macierz rotacji
#klasyfikacja c45. ogólne zrozumienie algorytmu
#Klasyfikacja Neive Beyes. Znaæ algorytm, sklasyfikowac rekord na podstawie tabeli
#K nearest neibours. Sklasyfikowac rekord.
#Grupowanie KN, to co ostatnio.