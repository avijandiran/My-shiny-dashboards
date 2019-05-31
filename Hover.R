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
                menuItem("Brush",tabName = "brush")
                

                
                
                
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
                )
              
      )
  )
  )
  



server <- function(input, output, session) {
  
  iris
  
  output$plot1 <- renderPlot({
    ggplot(iris,aes(y=iris$Sepal.Length,x=iris$Petal.Length,col=Species,shape=Species))+geom_point()
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
    cat("input$plot_hover:\n")
    str(input$plot_hover)
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

 
  
}

shinyApp(ui, server)