
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema5")

# Cargar dataset
protein <- read.csv('../../data/tema5/protein.csv')
rownames(protein) = protein$Country
protein$Country = NULL
protein_scaled = as.data.frame(scale(protein))

library(devtools) # Instalar con install.packages('devtools')
devtools::install_github('kassambara/factoextra')

km <- kmeans(protein_scaled, 4)
km

aggregate(protein_scaled, by = list(cluster = km$cluster), mean)

library(factoextra)

fviz_cluster(km, data = protein_scaled)
