library(shiny)

ui <- fluidPage(
  titlePanel("My shiny App"),
  
  sidebarLayout(
    
    sidebarPanel(
      h2("Installation"),
      p("Shiny is available on CRAN , so you can install it in the usual way from your R console:"),
      code('install.packages("shiny")'),
      br(),
      br(),
      br(),
      br(),
      img(src="rstudio.png",height = 70, width = 200), 
      br(),
      "Shiny is a product of",
      span("RStudio",style="color:blue")
),

 mainPanel(
          h1("introduction to shiny"),
          p("shiny is a new package  from Rstuido that makes it",
          em("incredibly")," easy to build interactive web applications in R"),
          br(),
          p("for introduction and live examples vist",a("the shiny home page.",herf="http://shiny.rstudio.com")),
          br(),
          
          h2("Features"),
          p("-Build useful web applications with only few lines of code -no javascript needed."),
          p("-Shiny applications are automatically 'live' in the same way that",
          strong(" spreadsheets"),"are live.Outputs change instantly as users modify inputs, 
          without requriring a reload of the browser")
)
)
)
server <- function(input, output) {
  
}

shinyApp(ui, server)