
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema5")

# Cargar dataset
bh <- read.csv('../../data/tema5/BostonHousing.csv')

library(corrplot) # Instalar con install.packages('corrplot')

corr <- cor(bh[, -14])
corr

corrplot(corr, method = 'circle')
# scale = TRUE, matriz de correlaciones
# scale = FALSE, matriz de covarianzas
bh_acp <- prcomp(bh[, -14], scale = TRUE)

summary(bh_acp)

plot(bh_acp)
plot(bh_acp, type = 'lines')

biplot(bh_acp, col= c('gray', 'red'))

head(bh_acp$x, 5)

bh_acp$rotation

bh_acp$sdev
