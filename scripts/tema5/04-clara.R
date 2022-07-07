
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema5")

# Cargar dataset
protein <- read.csv('../../data/tema5/protein.csv')
rownames(protein) = protein$Country
protein$Country = NULL
protein_scaled = as.data.frame(scale(protein))

library(cluster) # Instalar con install.packages('cluster')
library(factoextra)

km <- pam(protein_scaled, 4)
km

fviz_cluster(km)

# Clustering Large Application (CLARA)
# Altamente recomendable cuando tenemos datasets de miles de observaciones
clarafit <- clara(protein_scaled, 4, samples = 5)
clarafit

fviz_cluster(clarafit) # Salen los mismos resultados que con el K-medoides
