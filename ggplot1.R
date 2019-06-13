library(shiny)
library(ggplot2)
library(cowplot)
library(ggpubr)


iris

ui <- basicPage(
  plotOutput("plot1",hover = ("plot_hover")),
  verbatimTextOutput("info"),
  uiOutput("ui_plot")
)

server <- function(input, output) {
  output$plot1 <- renderPlot({
    g1 <- ggplot(iris, aes(x = Petal.Length, y = Sepal.Length)) +
      geom_point(aes(col=Species)) 
    
  
   g2 <- ggplot(iris, aes(x = Petal.Length, y = Sepal.Length)) +
  geom_point(aes(col=Species))
    
    ggarrange(g1,g2,nrow=2)
    
    #plot_grid(g1,g2,nrow=2)
  })
  
  output$ui_plot <- renderUI({
    
    hover<- input$plot_hover
    
    point<- nearPoints(iris, hover,xvar="Petal.Length", yvar="Sepal.Length", threshold = 5, maxpoints = 1,
                       addDist = TRUE)
    
    if (nrow(point) == 0) return(NULL)
    
    
    
    left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
    top_pct <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)
    
    left_px <- hover$range$left + left_pct * (hover$range$right - hover$range$left)
    top_px <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)
    
    style <- paste("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
                    "left:", left_px + 2, "px; top:", top_px + 2, "px;")
    
    
    
    wellPanel(
      style = style,
      p(HTML(paste("<b> Petal.Length: </b>", point$Petal.Length, "<br/>",
                    "<b> Sepal.Length: </b>", point$Sepal.Length, "<br/>"))))
  })
}


shinyApp(ui, server)