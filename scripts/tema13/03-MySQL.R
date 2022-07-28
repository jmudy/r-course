
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema13")

library(RODBC) # Instalar con install.packages('RODBC')
odbcDataSources()

con <- odbcConnect("MySQL",
                   uid = "jmudy",
                   pwd = "v@lencia92")

custData <- sqlQuery(con, "select rating from RecommendationSystem.Rating limit 5;")
custData

customers <- c("Juan Gabriel", "Ricardo", "María")
orderdate <- as.Date(c('2018-01-25', '2017-12-31', '2017-12-1'))
orderamount <- c(350, 44.65, 105.32)
orders <- data.frame(customers, orderdate, orderamount)

sqlSave(con, orders, "RecommendationSystem.Orders", append = F)

df <- sqlQuery(con, "select * from RecommendationSystem.Orders")
df

library(RMySQL) # Instalar con install.packages('RMySQL')
con <- dbConnect(MySQL(),
                 dbname = "RecommendationSystem",
                 host = "127.0.0.1", 
                 port = 3306, 
                 username = "jmudy",
                 password = "v@lencia92")

ac <- dbReadTable(con, "Accomodation")
head(ac)

df <- dbGetQuery(con, "select * from Accomodation where title like '%chalet%'")
df

dbWriteTable(con, "Orders", orders, row.names = F)

dbReadTable(con, "Orders")


rs <- dbSendQuery(con, paste("SELECT a.location, max(a.price)",
                             "FROM Accomodation a ", 
                             "GROUP BY a.location ",
                             "ORDER BY max(a.price) DESC"))

while(!dbHasCompleted(rs)){
  print(fetch(rs, n = 2)) # n = -1 para obtenerlos todos de golpe
}

dbClearResult(rs)
dbDisconnect(con)
dbListConnections(dbDriver("MySQL"))

library(RJDBC) # Instalar con install.packages('RJDBC')
# Descargar https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-java-8.0.29.tar.gz
# Y copiarlo en en carpeta lib/
driver <- JDBC("com.mysql.jdbc.Driver", 
               classPath = "lib/mysql-connector-java-8.0.29/mysql-connector-java-8.0.29.jar", "'")
con <- dbConnect(driver, "jdbc:mysql://127.0.0.1:3306/RecommendationSystem", 
                 "jb", "1234", useSSL = F)

dbReadTable(con, 'Accomodation')

dbGetQuery(con, "select * from Accomodation")
