
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema5")

library(OpenImageR) # Instalar con install.packages('OpenImageR')
library(ClusterR) # Instalar con install.packages('ClusterR')

imagename <- '../../data/tema5/jb.jpg'
img <- readImage(imagename)

img_resize <- resizeImage(img, 350, 350,
                          method = 'bilinear')

imageShow(img)
img_vector <- apply(img, 3, as.vector)
dim(img_vector)

kmmb <- MiniBatchKmeans(img_vector, clusters = 10,
                        batch_size = 20, num_init = 5,
                        max_iters = 100, init_fraction = 0.2,
                        initializer = 'kmeans++',
                        early_stop_iter = 10, verbose = FALSE)

kmmb

prmb <- predict_MBatchKMeans(img_vector, kmmb$centroids)

get_cent_mb <- kmmb$centroids
new_img <- get_cent_mb[prmb, ]
dim(new_img) <- c(nrow(img), ncol(img), 3)
imageShow(new_img)
