# lab 6 

# zad 1

#yes yes  + + +  true positive (TP)
#yes no  + false negative (FN)
#no yes + false positive (FP)
# no no + + true negative (TN)

comp_matrix <- matrix(c(3,1,1,2), nrow=2, ncol=2)

# 5 dobrze sklasyfikowanych, a 2 �le
 
good <- 5/7 * 100  # 71.42%

# FP rate mowi o stopniu zak�amania FP/(FP+TP) 33%
# TP rate m�wi o stopniu poprawno�ci TP/(TP + FN) 75%