library(shiny)
library(DT)

server <- shinyServer(function(input, output, session) {
  
  output$x1 = DT::renderDataTable(cars, server = FALSE)
  
  output$x2 = DT::renderDataTable({
    sel <- input$x1_rows_selected
    if(length(cars)){
      cars[sel, ]
    }
    
  }, server = FALSE)  
  
})


ui <- fluidPage(
  
  fluidRow(
    column(6, DT::dataTableOutput('x1')),
    column(6, DT::dataTableOutput('x2'))
  )
  
)

shinyApp(ui, server)