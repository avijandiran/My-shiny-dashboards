# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(ggplot2)

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
  },options = list(
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
  v <- reactiveValues()
  v$s <- NULL
  
  data <- reactive({
    iris[iris$Species==input$pickvalue]
  })
  
  output$job_data  <- DT::renderDataTable({
    datatable(data(),selection = "single")
  })
  
  observe({
    if(!is.null(input$job_data_rows_selected)){
      v$s <- input$job_data_rows_selected
    }
  })
  
  output$x4 <- DT::renderDataTable({
    datatable(data()[v$s,])
  })
}