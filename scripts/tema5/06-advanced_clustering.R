
library(fpc) # Instalar con install.packages('fpc')
library(factoextra)

data('multishapes', package = 'factoextra')

par(mfrow = c(1, 1))
head(multishapes)
dataPoints <- multishapes[, 1:2]
plot(dataPoints)

km <- kmeans(dataPoints, 5)
fviz_cluster(km, data = dataPoints)

dsFit <- dbscan(dataPoints, eps = 0.15, MinPts = 5)
dsFit

fviz_cluster(dsFit, data = dataPoints, geom = 'point')

library(mclust) # Instalar con install.packages('mclust')

mclust <- Mclust(dataPoints)
plot(mclust)

summary(mclust)
