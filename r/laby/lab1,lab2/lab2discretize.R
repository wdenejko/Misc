discretize <- function(x,n){

xmax = max(x)
xmin = min(x)

print(xmax)
print(xmin)

part = round((xmax - xmin) / n, digits=2)

print(part)

xnew <- x

for(i in 1:length(x))
{ 
	for(j in 1:n)
	{
		if(j!=n)
		{
			if(x[i]<=((j*part) + xmin) && x[i]>=((j-1)*part) + xmin)
			{
				xnew[i] = paste(((j*part) + xmin) - (part), (j*part) + xmin, sep=", ")
				break
			}	
		}
		else
		{
			if(x[i]<=xmax && x[i]>=((j-1)*part) + xmin)
			{	
				xnew[i] = paste(((j*part) + xmin) - (part), xmax, sep=", ")
				break
			}
		}
	}
}

return(xnew)

}