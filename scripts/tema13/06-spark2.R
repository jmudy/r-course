
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema13")

library(devtools) # Instalar con install.packages('devtools')
devtools::install_github("apache/spark@v3.2.2", subdir = "R/pkg")

library(SparkR)
sparkR.session()

#Las casas de boston y ejemplo de clasificación
df <- read.df("../../data/tema13/boston-housing-logistic.csv",
              "csv", header = "true", inferSchema = "true", 
              na.strings = "NA")
showDF(df, 5)

train_data <- sample(df, FALSE, 0.8)
test_data <- except(df, train_data)

model <- glm(CLASS ~ NOX + DIS + RAD+ TAX + PTRATIO, 
             data = train_data, family = "binomial")
prediction <- predict(model, newData = test_data)
showDF(prediction)

# Sistema de recomendación con bases de datos en MySQL
# NO FUNCIONA

db_url <- "jdbc:mysql://localhost:3306/RecommendationSystem"
df_rates <- read.jdbc(db.url, "RecommendationSystem.Rating", 
                      user = "XXXX", password = "XXXX") # Usuario y contraseña de MySQL

library(sparklyr) # Instalar con install.packages('sparklyr')
spark_install(version = "3.2.2")
# Para actualizar sparklyr una vez instalado, lo hacemos desde su GIT
# Recomendable para que no de problemas después
# devtools::install_github("rstudio/sparklyr")

config <- spark_config()
config$`sparklyr.shell.driver-class-path` <- 
  "lib/mysql-connector-java-8.0.29/mysql-connector-java-8.0.29.jar"

sc <- spark_connect(master = "local",
                    version = "3.2.2",
                    config = config)

df_rates <- spark_read_jdbc(sc, "Movies_JDBC", options=list(
  url=db.url,
  user="XXXX", # Usuario de MySQL
  password="XXXX", # Contraseña de MySQL
  dbtable="Rating")
)

library(dplyr) # Instalar con install.packages('dplyr')

summarise(df_rates, count = n())

train <- dplyr::sample_frac(df_rates, 0.7, replace = F)
summarise(train, count = n())

test <- anti_join(df_rates, train)
summarise(test, count = n())

model <- ml_als(test, rating_col = "rating", 
                user_col = "userID", item_col = "movieID",
                max_iter = 5, reg_param = 0.01)

summary(model)

pred <- ml_predict(model, test)
head(pred)

dplyr::filter(pred, userID == 28 & prediction > 3)
dplyr::filter(pred, movieID == 924) %>% 
  summarise(rate = mean(prediction, na.rm = T), count = n())
