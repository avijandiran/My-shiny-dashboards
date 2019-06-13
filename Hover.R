library(ggplot2)
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title="Plot Examples"),
  dashboardSidebar(
    sidebarMenu(id="plots",
                menuItem("Click",tabName = "click"),
                menuItem("Double click",tabName = "dbclick"),
                menuItem("Hover",tabName = "hover"),
                menuItem("Brush",tabName = "brush"),
                menuItem("Brush & Zoom ",tabName = "zoom")
      
  )),
  
  dashboardBody(
    tabItems(
      
      tabItem(tabName = "click",
              fluidRow(h4("click on the plot for Info"),plotOutput("plot1",click = "plot_click")),
              br(),
              fluidRow(h4("Points near click"),verbatimTextOutput("click_info")),
              br(),
              fluidRow(column(12,actionButton("button1","Next Tab")))
            ),
      
      
      
      tabItem(tabName = "dbclick", h4("Double click on the plot for Info"),
              fluidRow(column(12,plotOutput("plot2",dblclick = dblclickOpts(id = "plot_dblclick")))),
              br(),
              fluidRow(h4("Points near click"),verbatimTextOutput("dbclick_info")),
              br(),
              fluidRow(column(12,offset =-6,actionButton("button2","Next Tab",)))
      ),
      
      
      
      tabItem(tabName = "hover",h4("Hover over the plot for Info"),
              fluidRow(column(12,plotOutput("plot3",hover = hoverOpts(id = "plot_hover")))),
              br(),
              fluidRow(h4("Points near click"),verbatimTextOutput("hover_info")),
              br(),
              fluidRow(column(12,actionButton("button3","Next")))
              ),
      
      
      
      tabItem(tabName = "brush",h4("Brush on the plot for Info"),
              fluidRow(column(12,plotOutput("plot4", brush=brushOpts(id="plot_brush")))),
              br(),
              fluidRow(h4("Points near click"),verbatimTextOutput("brush_info"))
      ),
      
      tabItem(tabName = "zoom",
              fluidRow(
                column(12, class = "well",
                       h4("Brush and double-click to zoom"),
                       plotOutput("plot5", height = 300,
                                  dblclick = "plot_dblclick5",
                                  brush = brushOpts(
                                    id = "plot_brush5",
                                    resetOnNew = TRUE)
                       ))
                )
  )
  )
  )
)
  



server <- function(input, output, session) {
  
  iris
  
  output$plot1 <- renderPlot({
    ggplot(iris,aes(y=Sepal.Length,x=Petal.Length,col=Species,shape=Species))+geom_point()
  })
  
  output$click_info <- renderPrint({
    cat("input$plot_click:\n")
    str(input$plot_click)
  })
  
  output$dbclick_info <- renderPrint({
    cat("input$plot_dblclick:\n")
    str(input$plot_dblclick)
  })
  
  output$hover_info <- renderPrint({
    #cat("input$plot_hover:\n")
    #str(input$plot_hover)
    
    hover <- input$plot_hover
    
    point <- nearPoints(iris,hover,xvar="Petal.Length",yvar="Sepal.Length",threshold = 10, maxpoints = 1,
               addDist = TRUE,allRows = FALSE)
    
    if (nrow(point) == 0) return(NULL)
    
    left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
    top_pct <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)
    
    left_px <- hover$range$left + left_pct * (hover$range$right - hover$range$left)
    top_px <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)
    
    style <- paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
                    "left:", left_px + 2, "px; top:", top_px + 2, "px;")
    
    wellPanel(
      style = style,
      p(HTML(paste0("<b> wt: </b>", point$Petal.Length, "<br/>",
                    "<b> mpg: </b>", point$Sepal.Length, "<br/>",))))
  })
 
  output$brush_info <- renderPrint({
     cat("input$plot_brush:\n")
     str(input$plot_brush)
    
  })
  
  
    
  observeEvent(input$button1,{
    updateTabsetPanel(session,"plots","dbclick")
    
    output$plot2 <- renderPlot({
      ggplot(iris,aes(y=iris$Sepal.Length,x=iris$Petal.Length,col=Species))+geom_area()
      
      
    })
    
  })

  observeEvent(input$button2,{
    
    updateTabsetPanel(session,"plots","hover")
    
    output$plot3 <- renderPlot({
      ggplot(iris,aes(y=iris$Sepal.Length,x=iris$Petal.Length,col=Species))+geom_boxplot()
      
     
    })
    
    
  })

  observeEvent(input$button3,{
    
    updateTabsetPanel(session,"plots","brush")
    
    output$plot4 <- renderPlot({
      ggplot(iris,aes(x=iris$Sepal.Length,shape=Species,col=Species,fill=Species))+geom_histogram(bins=50)
    
      })
    
    })

  ranges <- reactiveValues(x = NULL, y = NULL)
  
  output$plot5 <- renderPlot({
    ggplot(iris, aes(Sepal.Length, Petal.Length)) +
      geom_point() +
      coord_cartesian(xlim = ranges$x, ylim = ranges$y, expand = FALSE)
    
  })
  
  observeEvent(input$plot_dblclick5, {
    brush <- input$plot_brush5
    if (!is.null(brush)) {
      ranges$x <- c(brush$xmin, brush$xmax)
      ranges$y <- c(brush$ymin, brush$ymax)
      
    } else {
      ranges$x <- NULL
      ranges$y <- NULL
    }
  })
  
}

shinyApp(ui, server)