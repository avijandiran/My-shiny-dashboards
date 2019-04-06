library(ggplot2)
library(shiny)

ui <- fluidPage(
  titlePanel("Basic DataTable"),
  fluidRow(
    # Create a new Row in the UI for selectInputs
    fluidRow(
      column(4,
             selectInput("man",
                         "Manufacturer:",
                         c("All",
                           unique(as.character(mpg$manufacturer))))
      ),
      column(4,
             selectInput("trans",
                         "Transmission:",
                         c("All",
                           unique(as.character(mpg$trans))))
      ),
      column(4,
             selectInput("cyl",
                         "Cylinders:",
                         c("All",
                           unique(as.character(mpg$cyl))))
      )
      
    ),
    # Create a new row for the table.
    fluidRow (
      column(12,
             DT::dataTableOutput("table"))
    ),
    
    fluidRow(column(12,
                    verbatimTextOutput("default")
    ))))


server <- function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- mpg
    
    if (input$man != "All") {
      data <- data[data$manufacturer == input$man,]
    }
    if (input$cyl != "All") {
      data <- data[data$cyl == input$cyl,]
    }
    if (input$trans != "All") {
      data <- data[data$trans == input$trans,]
    }
    data1 <<- data
  }, 
  
    options = list(
    searching = TRUE,
    autoWidth=TRUE,
    paging=FALSE,
    scrollX=T,
    scrollY=T,
    scrollCollapse = T,
    fixedHeader=TRUE)
  
  
  ))
  
  observeEvent(input$table_rows_selected,{
    a <- input$table_rows_selected
    selected_df <- data1[a, ]
    output$default <- renderPrint({selected_df})
  })
}

shinyApp(ui=ui,server = server)