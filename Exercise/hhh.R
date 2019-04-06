library(shiny)


ui <- fluidPage(
  fluidRow(
    column(width = 6,
           "hello"
    ),
    column(width = 6, 
           "hello"
    )
  )
)

server <- function(input, output, session) {
  
}
shinyApp(ui=ui,server=server)





