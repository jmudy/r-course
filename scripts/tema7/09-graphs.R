
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema7")

library(igraph) # Instalar con install.packages('igraph')

g_dir <- graph(edges = c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6, 5,6), n = 6)
g_n_dir <- graph(edges = c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6, 5,6), n = 6, directed = FALSE)

par(mfrow = c(1, 2))

plot(g_dir)
plot(g_n_dir)

par(mfrow = c(1, 1))

g_isolated <- graph(c('Juan', 'María',
                      'María', 'Ana',
                      'Ana', 'Juan',
                      'José', 'María',
                      'Pedro', 'José',
                      'Joel', 'Pedro'),
                    isolates = c(
                      'Carmen',
                      'Antonio',
                      'Mario',
                      'Vicente'
                    ))

plot(g_isolated, edge.arrow.size = 1,
     vertex.color = 'gold', vertex.size = 15,
     vertex.frame.color = 'gray', vertex.label.color = 'black',
     vertex.label.cex = 0.8, vertex.label.dist = 2,
     edge.curved = 0.2)
