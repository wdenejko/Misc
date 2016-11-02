corrplot <- function(x, title1, title2)
{
	barplot( x, col=c(rgb(0,0,1),"red"), main=sprintf("Zale¿noœci pomiedzy atrybutami: %s, %s",title1,title2),legend=rownames(x))
	
}