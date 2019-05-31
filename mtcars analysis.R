library(shinydashboard)
library(shiny)
library(ggplot2)
library(DT)

ui <- dashboardPage(
  dashboardHeader(title="Data Analysis"),
  dashboardSidebar(
    sidebarMenu(id="list",
    menuItem("Data Source",tabName = "datas"),
    menuItem("Data Cleaning",tabName = "datac"),
    menuItem("Model Building",tabName = "modelb"),
    menuItem("Data visualization",tabName = "datav")
    
  )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "datas",
              fluidRow(h4("Dataset of Mtcars"),column(12,DT::dataTableOutput("table1"))),
              fluidRow(column(12,actionButton("button1","Next")))),
              
      tabItem(tabName = "datac", h3("Summary of mtcars"),
                  fluidRow(column(12,verbatimTextOutput("text1"))),
              fluidRow(column(12,h3("correlation"),plotOutput("plot1"))),
              br(),
              fluidRow(column(12,offset =-6,actionButton("button2","Next")))
      ),
      
    tabItem(tabName = "modelb",
            fluidRow(column(6,h3("Model A"),verbatimTextOutput("text2")),
                     column(6,h3("Model B"),verbatimTextOutput("text3"))),
            br(),
            fluidRow(column(12,offset =-6,actionButton("button3","Next")))
            ),
    
    tabItem(tabName = "datav",
            fluidRow(column(12,h3("Plot 1"),plotOutput("plot2"))),
                            fluidRow(column(12,h3("Plot 2"),plotOutput("plot3"))
            ))
    )
    )
    
  )
    
  


server <- function(input,output,session){
  data <- mtcars
  output$table1 <- DT::renderDataTable(DT::datatable(
    {
    data

    },options = list(
      searching = TRUE,
      paging=TRUE,
      scrollX=TRUE,
      scrollY=TRUE,
      fixedHeader=TRUE)
  ))
  
  observeEvent(input$button1,{
    updateTabsetPanel(session,"list","datac")
     summary1 <- summary(mtcars)
  
   output$text1 <- renderPrint(
     {
       summary1
  
     })
 
  output$plot1 <- renderPlot({
   plot(~.,data)
   })
  
  })

  
  observeEvent(input$button2,{
    
    updateTabsetPanel(session,"list","modelb")
    
    modelA1 <- lm(mpg ~ hp + wt, data)
    modelA2 <- lm(mpg ~ as.factor(cyl) + disp + hp + drat + wt, data) 
    anova(modelA1, modelA2)
    
    output$text2 <- renderPrint({
      modelA1
      })
    
    output$text3 <- renderPrint({
      modelA2
    })
  })
  
  observeEvent(input$button3,{
    
    updateTabsetPanel(session,"list","datav")
    
    output$plot2 <- renderPlot({
      ggplot(mtcars, aes(x=disp, y=mpg))+ geom_point()
    })
    
    output$plot3 <- renderPlot({
      ggplot(mtcars, aes(x=hp, y=mpg))+ geom_point()
    })
    
    

  })

}
shinyApp(ui, server)