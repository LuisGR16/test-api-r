# Instalar y cargar las bibliotecas necesarias
install.packages(c("httr", "jsonlite", "ggplot2", "scales"))
library(httr)
library(jsonlite)
library(ggplot2)
library(scales)

# Definir la base de la URL y la clave de API
base <- "https://api.covidactnow.org/v2/states.json?"
apiKey <- "apiKey=cf3e62d1db204782b4bfd5887c7f657b"
urlAPICovid <- paste0(base, apiKey)

# Obtener los datos en formato JSON
jsonData <- GET(urlAPICovid)
jsonData$status_code # Imprimir el código de estado

# Convertir los datos JSON a una lista y luego a un dataframe
COVID_list <- fromJSON(rawToChar(jsonData$content), flatten = TRUE)
df <- data.frame(state = COVID_list$state, population = COVID_list$population)

# Mostrar el dataframe
print(df)

# Crear el gráfico de población por estado
ggplot(df, aes(x = reorder(state, -population), y = population)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Población por Estado", x = "Estado", y = "Población") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_y_continuous(labels = comma)
