library(plotrix)
library(shiny)
library(ggplot2)


runApp(shinyApp(
  ui <- basicPage(
    plotOutput("plot1", hover = "plot_hover", height = 250,
    dblclick = "plot1_dblclick",
    brush = brushOpts(
      id = "plot1_brush",
      resetOnNew = TRUE)),
    uiOutput("ui_plot")
  ),



server = function(input, output) {
  output$plot1 <- renderPlot({
    
    x <- c(1:5, 6.9, 7)
    y <- 2^x
    
    from <- 33
    to <- 110
    
    plot(x, y, type="b", xlab="index", ylab="value")
    
    gap.plot(x, y, gap=c(from,to), type="b", xlab="index", ylab="value")
    axis.break(2, from, breakcol="snow", style="gap")
    axis.break(2, from*(1+0.02), breakcol="black", style="slash")
    axis.break(4, from*(1+0.02), breakcol="black", style="slash")
    axis(2, at=from)
    
    
  })
  
  
  output$ui_plot <- renderUI({
    
    ranges <- reactiveValues(x = NULL, y = NULL)
    
    brush <- input$plot1_brush
    if (!is.null(brush)) {
      ranges$x <- c(brush$xmin, brush$xmax)
      ranges$y <- c(brush$ymin, brush$ymax)
      
    } else {
      ranges$x <- NULL
      ranges$y <- NULL
    }
    
    
    hover <- input$plot_hover
    
    point <- nearPoints(mtcars,hover,xvar="wt",yvar="mpg", threshold = 10, maxpoints = 1,addDist = T, allRows = F)
    
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





