
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema13")

library(devtools) # Instalar con install.packages('devtools')
devtools::install_github("apache/spark@v3.2.2", subdir = "R/pkg")

library(SparkR)
sparkR.session()

iris_df <- createDataFrame(iris)

showDF(iris_df, 5)

sub_iris_df <- select(iris_df, 
                      c("Sepal_Length", "Petal_Length"))
showDF(sub_iris_df, 5)

library(magrittr)

agr_iris_df <- iris_df %>% groupBy("Species") %>%
  avg("Sepal_Length") %>%
  withColumnRenamed("avg(Sepal_Length)", "Avg_Sepal_Length") %>%
  orderBy("Species")
agr_iris_df$Avg_Sepal_Length <- format_number(agr_iris_df$Avg_Sepal_Length,2)

showDF(agr_iris_df)

createOrReplaceTempView(iris_df, "IrisTable")
collect(sql("SELECT * FROM IrisTable LIMIT 10"))
collect(sql(paste("SELECT Species sp, avg(Sepal_Length) avg_sl, ",
                  "avg(Sepal_Width) avg_sw FROM IrisTable ",
                  "GROUP BY sp ORDER BY avg_sl desc")))
