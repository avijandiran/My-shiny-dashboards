library(shiny)
ui <- fluidPage(
  titlePanel("Hello Shiny!"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "bins",lable="Number of Bins:",min=1,max=50,value=25)
        ),
    mainPanel(
      plotOutput(outputId ="distPlot")
    )
    )
  )


server <-functions(input,output){
  output$distPlot=renderPlot({
    x <- faithful$waiting
  }
  )
}

shinyApp(ui=ui,server=server)