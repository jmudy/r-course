
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema5")

# Cargar dataset
protein <- read.csv('../../data/tema5/protein.csv')
rownames(protein) = protein$Country
protein$Country = NULL
protein_scaled = as.data.frame(scale(protein))

library(cluster) # Instalar con install.packages('cluster')
library(factoextra)
library(fpc) # Instalar con install.packages('fpc')
library(NbClust) # Instalar con install.packages('NbClust')

nb <- NbClust(protein_scaled, distance = 'euclidean',
              min.nc = 2, max.nc = 12,
              method = 'ward.D2', index = 'all')

fviz_nbclust(nb) + theme_minimal() # No funciona, salta error

km_res <- kmeans(protein_scaled, 3)
sil_km <- silhouette(km_res$cluster,
                     dist(protein_scaled))

sil_sum <- summary(sil_km)
sil_sum

fviz_silhouette(sil_km)
fviz_cluster(km_res, data = protein_scaled)

dd <- dist(protein_scaled, method = 'euclidean')

km_stats <- cluster.stats(dd, km_res$cluster)
km_stats$within.cluster.ss
km_stats$clus.avg.silwidths
km_stats$dunn

kmed <- pam(protein_scaled, 3)
sil_kmed <- silhouette(kmed$clustering,
                     dist(protein_scaled))

fviz_cluster(kmed, data = protein_scaled)
fviz_silhouette(sil_kmed)

kmed_stats <- cluster.stats(dd, kmed$clustering)
kmed_stats$within.cluster.ss
kmed_stats$clus.avg.silwidths
kmed_stats$dunn

res_com <- cluster.stats(dd, km_res$cluster,
                         kmed$clustering)

res_com$corrected.rand
res_com$vi
