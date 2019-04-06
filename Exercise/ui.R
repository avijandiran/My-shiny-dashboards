# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(ggplot2)

ui <- fluidPage(
  titlePanel("Basic DataTable"),
  
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
  )))
fluidRow(
  column(width=6,
         selectInput("pickvalue", label = "Pick a Value", choices = unique(iris$Species)))
),

br(),
fluidRow(
  column(12,
         DT::dataTableOutput("job_data"))
  
),
br(),
fluidRow(
  column(12,DT::dataTableOutput("x4"))
)
)
