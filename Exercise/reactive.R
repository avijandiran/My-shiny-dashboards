library(shiny)

ui <- fluidPage(
  
titlePanel("Demo"),
sidebarLayout(
  sidebarPanel(("Enter Info"),
    textInput("name","Enter username",""),
    textInput("password","Password","")),
  mainPanel(("Personal Informatiom"),
  textOutput("myname"),
  textOutput("mypwd")
  )
))


server <- function(input, output, session) {
  
  output$myname <- renderText(input$name)
  output$mypwd <- renderText(input$password)
  
}

shinyApp(ui, server)


