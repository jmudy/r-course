
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema8")

library(recommenderlab) # Instalar con install.packages('recommenderlab')

data(MovieLense)
head(MovieLense)

rating_movies <- MovieLense[rowCounts(MovieLense) > 50,
                            colCounts(MovieLense) > 100]

rating_movies@data[1, 1]
rating_movies@data[1, ]

head(rownames(rating_movies))
head(colnames(rating_movies))

t_id <- sample(x = c(T, F), size = nrow(rating_movies),
               replace = T, prob = c(0.8, 0.2))

data_train <- rating_movies[t_id, ]
data_test <- rating_movies[!t_id, ]

# Filtrado colaborativo basado en los ítems (IBCF)

ibcf <- Recommender(data = data_train,
                    method = 'IBCF',
                    parameter = list(k = 30))

ibcf_mod <- getModel(ibcf)
ibcf_mod

n_rec <- 10

ibcf_pred <- predict(object = ibcf,
                     newdata = data_test,
                     n = n_rec)
ibcf_pred

ibcf_rec_matrix <- sapply(ibcf_pred@items,
                          function(x){
                            colnames(rating_movies)[x]
                            }
                          )

View(ibcf_rec_matrix[, 1:3])

# Filtrado colaborativo basado en usuarios (UBCF)

ubcf <- Recommender(data = data_train, method = 'UBCF')

ubcf_mod <- getModel(ubcf)
ubcf_mod

ubcf_pred <- predict(object = ubcf,
                     newdata = data_test,
                     n = n_rec)
ubcf_pred

ubcf_rec_matrix <- sapply(ubcf_pred@items,
                          function(x){
                            colnames(rating_movies)[x]
                            }
                          )

View(ubcf_rec_matrix[, 1:3])

head(ubcf_pred@items)
colnames(rating_movies)[318]

# Representación de la matriz de recomendaciones

recommender_models <- recommenderRegistry$get_entries(datatype = 'realRatingMatrix')
names(recommender_models)

image(MovieLense, main = "Mapa de calor de la matriz de valoraciones de películas") # Tarda en renderizar

min_n_movies <- quantile(rowCounts(MovieLense), 0.99)
min_n_movies

min_n_users <- quantile(colCounts(MovieLense), 0.99)
min_n_users

image(MovieLense[rowCounts(MovieLense) > min_n_movies,
                 colCounts(MovieLense) > min_n_users])

min_r_movies <- quantile(rowCounts(rating_movies), 0.98)
min_r_users <- quantile(colCounts(rating_movies), 0.98)
image(rating_movies[rowCounts(rating_movies) > min_r_movies,
                    colCounts(rating_movies) > min_r_users],
      main = 'Mapa de calor del top de películas y usuarios')

# Recomendaciones basadas en datos binarios

rating_movies_viewed <- binarize(rating_movies, minRating = 1)
image(rating_movies_viewed)

t_id <- sample(x = c(T, F),
               size = nrow(rating_movies_viewed),
               replace = T,
               prob = c(0.8, 0.2))

b_data_train <- rating_movies_viewed[t_id, ]
b_data_test <- rating_movies_viewed[!t_id, ]

# distancia entre un item i y un item j
# Jaccard index: d(i, j) = (i y j) / (i o j)

b_model <- Recommender(data = b_data_train,
                       method = 'IBCF',
                       parameter = list(method = 'Jaccard'))

b_details <- getModel(b_model)
b_details

b_pred <- predict(object = b_model,
                  newdata = b_data_test,
                  n = n_rec)

b_rec_matrix <- sapply(b_pred@items,
                       function(x){
                         colnames(rating_movies)[x]
                       })

View(b_rec_matrix[, 1:3])
