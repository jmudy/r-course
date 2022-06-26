
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema3")

# Cargar dataset
usarrests <- read.csv('../../data/tema3/USArrests.csv', stringsAsFactors = FALSE)

rownames(usarrests) <- usarrests$X
usarrests$X <- NULL # Eliminar columna X ya que estoy utilizando los nombres de los estados como índices
head(usarrests)

apply(usarrests, 2, var) # Varianza de las distintas columnas

acp <- prcomp(usarrests,
              center = TRUE, scale = TRUE)

print(acp)

plot(acp, type = 'l')

summary(acp)

biplot(acp, scale = 0)

pc1 <- apply(acp$rotation[, 1]*usarrests, 1, sum)
pc2 <- apply(acp$rotation[, 2]*usarrests, 1, sum)

usarrests$pc1 <- pc1
usarrests$pc2 <- pc2

usarrests[, 1:4] <- NULL
 