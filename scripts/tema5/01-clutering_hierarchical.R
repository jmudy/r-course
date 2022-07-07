
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema5")

# Cargar dataset
protein <- read.csv('../../data/tema5/protein.csv')

data <- as.data.frame(scale(protein[, -1]))
data$Country = protein$Country
rownames(data) = data$Country

# Clusterings Jerárquicos y dendogramas

hc <- hclust(dist(data, method = 'euclidean'),
             method = 'ward.D2')
hc

plot(hc, hang = -0.01, cex = 0.7)

fit <- cutree(hc, k = 4)
table(fit)

rect.hclust(hc, k = 4, border = 'red')

hc2 <- hclust(dist(data, method = 'euclidean'),
              method = 'single')
hc2

plot(hc2, hang = -0.01, cex = 0.7)

hc3 <- hclust(dist(data, method = 'euclidean'),
              method = 'complete')
hc3

plot(hc3, hang = -0.01, cex = 0.7)

hc3$merge # orden de juntar los países

hc4 <- hclust(dist(data, method = 'euclidean'),
              method = 'average')
hc4

plot(hc4, hang = -0.01, cex = 0.7)

hc4$merge # orden de juntar los países

d <- dist(data, method = 'euclidean')
d

alb <- data['Albania', -10]
aus <- data['Austria', -10]
sqrt(sum((alb - aus)^2))

d <- dist(data, method = 'manhattan')
d

alb <- data['Albania', -10]
aus <- data['Austria', -10]
sum(abs(alb - aus))

# Clusterings divisitivos y cortes en el dendograma

library(cluster) # Instalar con install.packages('cluster')

dv <- diana(data, metric = 'euclidean')
par(mfrow = c(1, 2))
plot(dv)
par(mfrow = c(1, 1))
