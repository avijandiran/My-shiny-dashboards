library(shiny)
library(ggplot2)

runApp(shinyApp(
  ui <- basicPage(
    plotOutput("plot1", hover = "plot_hover1", height = 250),
    plotOutput("plot2", hover = "plot_hover2", height = 250),
    uiOutput("ui_plot1"),
    uiOutput("ui_plot2")
  ),
  
  
  
  server = function(input, output) {
    
    output$plot1 <- renderPlot({
      p1 <- ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point(aes(col=gear)) +
      theme_bw()
        
    })
    
    
      output$plot1 <- renderPlot({

      p2 <- ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point(aes(col=gear)) +
        theme_bw()
      
      ggarrange(p1,p2,nrow=2)
      
    })
      
      
      
  
output$ui_plot1 <- renderUI({
       
     Hover <- input$plot_hover1
    
     point <- nearPoints(mtcars,Hover, xvar="wt",yvar="mpg",threshold = 10, maxpoints = 1, addDist = TRUE)
    
    if (nrow(point) == 0) return(NULL)

    left_pct <- (Hover$x - Hover$domain$left) / (Hover$domain$right - Hover$domain$left)
    top_pct <- (Hover$domain$top - Hover$y) / (Hover$domain$top - Hover$domain$bottom)

    left_px <- Hover$range$left + left_pct * (Hover$range$right - Hover$range$left)
    top_px <- Hover$range$top + top_pct * (Hover$range$bottom - Hover$range$top)

    style <- paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
                    "left:", left_px + 2, "px; top:", top_px + 2, "px;")


      wellPanel(
        style = style,
        p(HTML(paste0("<b> wt: </b>", point$wt, "<br/>",
                      "<b> mpg: </b>", point$mpg, "<br/>"))))
                      
        
      
    })

output$ui_plot2 <- renderUI({
  
  hover <- input$plot_hover2
  
  point <- nearPoints(mtcars,hover,xvar="wt",yvar="mpg", threshold = 10, maxpoints = 1, addDist = TRUE)
  
  if (nrow(point) == 0) return(NULL)
  
  left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
  top_pct <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)
  
  left_px <- hover$range$left + left_pct * (hover$range$right - hover$range$left)
  top_px <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)
  
  style <- paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
                  "left:", left_px + 2, "px; top:", top_px + 2, "px;")
  
  
  wellPanel(
    style = style,
    p(HTML(paste0("<b> wt: </b>", point$wt, "<br/>",
                  "<b> mpg: </b>", point$mpg, "<br/>"))))
  

})
  }
  
))





