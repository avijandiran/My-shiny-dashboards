library(shinydashboard)
library(caTools)
library(shiny)
library(cluster)
library(DT)

ui <- dashboardPage(
  dashboardHeader(title="Wholesale Customer Data"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Data cleaning",tabName="dataCleaning"),
      menuItem("Model",tabName="model"),
      menuItem("Prediction",tabName="prediction")
      
    )
  ),
  dashboardBody(
    tabItems(
      # # First tab content
      tabItem(tabName = "dataCleaning",
              fluidRow ( title="Load the Dataset",column(6,
                                                     DT::dataTableOutput("table1")),
               column(6,DT::dataTableOutput("table2"))
                ),
              
              fluidRow(
                column(6 ,offset=2,
                       actionButton("button1","Clean the Dataset"))
              ),
              
              br(),
              fluidRow(
                box(column(12,
                           numericInput("num",label = "Probability",value = 0.7,min=0.1,max=1,step = 0.1))),
                box(column(6,actionButton("button2","Split the dataset"))
                ))
      ),
      tabItem(tabName ="model",
              fluidRow(
                box(column(6,offset = 6,
                           actionButton("button3","Run Model"))
                )),
              
              fluidRow(
                box(column(6,
                           plotOutput("plot1"))),
                box(column(6,
                           plotOutput("plot2")))
              ),
              
              fluidRow(
                box(column(12,
                           verbatimTextOutput("text1")))
              ),
              fluidRow(
                box(column(6,offset = 6,
                           actionButton("button4","Predict"))
                ))
      ),
      tabItem(tabName ="prediction",
              fluidRow(
                box(column(6,
                           verbatimTextOutput("text2")),
                    column(6,
                           verbatimTextOutput("text3"))
                )),
              fluidRow(
                box(column(12,
                           verbatimTextOutput("text4"))
                ))
      )
    )
  )
)

mydataset1<<-read.csv(file.choose())
server <- function(input, output, session) {
  
  
  mydataset2 <<-(na.omit(mydataset1))
  mydataset3<<-(mydataset2)
  
  output$table1<- DT::renderDataTable(DT::datatable(
    {
      mydataset1
      
    },options = list(
      searching = TRUE,
      paging=TRUE,
      scrollX=TRUE,
      scrollY=TRUE,
      fixedHeader=TRUE)
  ))
  
  
  observeEvent(input$button1,{
    
    
    output$table2<- DT::renderDataTable(DT::datatable(
      {
        mydataset2
        
      },options = list(
        searching = TRUE,
        paging=TRUE,
        scrollX=TRUE,
        scrollY=TRUE,
        fixedHeader=TRUE)))
    
  })
  
  mydataset3$Channel <- NULL
  mydataset3$Region <- NULL
  
  observeEvent(input$button2,{
    set.seed(8)
    split <- sample.split(mydataset3,SplitRatio = 0.7)
    
    trainingdata <<- subset(mydataset3,split=="TRUE")
    testingdata <<- subset(mydataset3,split=="FALSE")
    updateTabItems(session,"tab",selected = "model")
  })
  
  
  
  observeEvent(input$button3,{
    kc3 <-kmeans(mydataset3,3)
    
    
    output$plot1 <- renderPlot({
      plot(Milk~Grocery,mydataset3,col=kc3$cluster)
    })
    
    output$plot2 <- renderPlot({
      clusplot(mydataset3,kc3$cluster, main = 'Clusterplot',color=TRUE, shade=TRUE, labels=2, lines=0)
    })
    
    output$text1 <- renderPrint({
      kc3
    })
  })
  
  observeEvent(input$button4,{
    
    updateTabItems(session,"tab",selected = "prediction")
    G <- aggregate(data=mydataset3,Grocery~kc3$cluster,mean)
    M <- aggregate(data=mydataset3,Milk~kc3$cluster,mean)
    
    output$text2 <- renderPrint({
      G
      
    })
    output$text3 <- renderPrint({
      M
      
    })
    
    output$text4 <- renderPrint({
      cl <- kc3$centers
      cl
    })
    
    
  })
  
}
shinyApp(ui, server)
