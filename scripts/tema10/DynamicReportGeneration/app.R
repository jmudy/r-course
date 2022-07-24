
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  selectInput('choice', 'Selecciona la variable que deseas en el Eje X',
              choices = c('weight',
                          'acceleration',
                          'horsepower',
                          'cylinders')),
  downloadButton('report', 'Generar informe')
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$report <- downloadHandler(
    # Nombre del fichero, bien en HTML, bien en PDF
    filename = 'Report.pdf',
    # Función generadora del contenido del fichero
    content = function(file){
      # Markdown base sobre el que generar el informe
      report <- file.path('Report.Rmd')
      # Configuramos una lista de parámetros que pasar al Rmd
      params <- list(n = input$choice)
      # Generamos el Rmd con los parámetros y lo evaluamos de forma global
      rmarkdown::render(report,
                        output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
                        )
    }
  )
}

# Run the application 
shinyApp(ui = ui, server = server)
