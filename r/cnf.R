phi1 = read.csv("R/phi1.cnf", header = FALSE, sep =" ")
phi2 = read.csv("R/phi2.cnf", header = FALSE, sep =" ")

fitness = function(data, podstawienie) {
  a <- 0
  for (i in 1:nrow(data))
    for (j in 1:(ncol(data) - 1)) {
      v <- data[i, j]
      p <- podstawienie[abs(v)]
      s <- if (sign(v) == 1) p else !p
      if (s) {
        a <- a + 1
        break
      }
    }
  
  return(a)
}

fitness = function(data, podstawienie) {
  a <- apply(data, 1, function(x) {
    check <- function(position) {
      v <- x[position]
      p <- podstawienie[abs(v)]
      p <- if (sign(v) == 1) p else !p
      return(p)
    }
    return(check(1)|check(2)|check(3))
  })
  sum(a)
}

wynik1 <- fitness(phi1, c(1,0,1,1))
wynik2 <- fitness(phi1, c(1,1,1,1))

pod <- round(runif(50, 0, 1))
wynik3 <- fitness(phi2, pod)

library(genalg)
library(ggplot2)
input <- phi2
iter<-100
GAmodel <- rbga.bin(size = nrow(input), popSize = 2000, iters = iter,
                    mutationChance = 0.02, elitism = F, evalFunc = function(ch) {return(-fitness(input, ch))})
summary(GAmodel, echo=TRUE)

animate_plot <- function() {
  for (i in seq(1, iter)) {
    temp <- data.frame(Iteracja = c(seq(1, i), seq(1, i)), Legenda = c(rep("Średnia",
              i), rep("Najlepsza", i)), WartoscFitness = c(-GAmodel$mean[1:i], -GAmodel$best[1:i]))
    pl <- ggplot(temp, aes(x = Iteracja, y = WartoscFitness, group = Legenda,
            colour = Legenda)) + geom_line() + scale_x_continuous(limits = c(0,
            iter)) + scale_y_continuous(limits = c(nrow(input) * 4/5, nrow(input) + 2)) + geom_hline(y =
            max(temp$WartoscFitness),
            lty = 2) + annotate("text", x = 1, y = max(temp$WartoscFitness) +
            2, hjust = 0, size = 3, color = "black", label = paste("Najlepsze rozwiązanie:",
            max(temp$WartoscFitness))) + scale_colour_brewer(palette = "Set1")
    print(pl)
  }
}
animate_plot()