library(shinydashboard)
library(caTools)
library(shiny)
library(cluster)
library(DT)

ui <- dashboardPage(
  dashboardHeader(title="Wholesale Customer Data"),
  dashboardSidebar(
    sidebarMenu(id = "tabs",
      menuItem("Data cleaning",tabName="dataCleaning",icon = icon("dashboard")),
      menuItem("Model",tabName="model",icon = icon("th")),
      menuItem("Prediction",tabName="prediction",icon = icon("th"))
      
    )
  ),
  dashboardBody(
    tabItems(
      # # First tab content
      tabItem(tabName = "dataCleaning",
              fluidRow ( h3("Clean and Split the dataset into test and train data") ,column(6,
                       DT::dataTableOutput("table1")),
                      column(6,
                             
                             
                             
                       DT::dataTableOutput("table2"))
              ),

              fluidRow(
                column(6 ,offset=2,
                       actionButton("button1","Clean the Dataset"))
              ),
              
br(),
              fluidRow(
                column(12,
                       numericInput("num",label = "Probability",value = 0.7,min=0.1,max=1,step = 0.1)),
                column(6,actionButton("button2","Split the dataset"))
              )
  ),

  tabItem(tabName ="model",
          fluidRow(
            column(6,offset = 6,
                   actionButton("button3","Run Model"))
          ),
          br(),
          fluidRow(
            column(6,
                   plotOutput("plot1")),
            column(6,
                   plotOutput("plot2"))
          ),
          br(),
          fluidRow(
            column(12,
                   verbatimTextOutput("text1"))
          ),
          br(),
          fluidRow(
          column(6,offset = 6,
                   actionButton("button4","Predict"))
          )
  ),
  tabItem(tabName ="prediction",
        
          fluidRow(
            column(6,
                      verbatimTextOutput("text2")),
            column(6,
                   verbatimTextOutput("text3"))
          ),
          fluidRow(
            column(12,
                   verbatimTextOutput("text4"))
          )
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
    set.seed(888)
    split <- sample.split(mydataset3,SplitRatio = 0.7)
  
    trainingdata <<- subset(mydataset3,split=="TRUE")
    testingdata <<- subset(mydataset3,split=="FALSE")
    updateTabItems(session,"tabs","model")
  })
  
  
  
  observeEvent(input$button3,{
    kc <<-kmeans(mydataset3,3)
    
    
    output$plot1 <- renderPlot({
      plot(Milk~Grocery,mydataset3,col=kc$cluster)
    })
    
    output$plot2 <- renderPlot({
      clusplot(mydataset3,kc$cluster, main = 'Clusterplot',color=TRUE, shade=TRUE, labels=2, lines=0)
    })
    
    output$text1 <- renderPrint({
      kc
    })
  })
  
  observeEvent(input$button4,{
    
    updateTabsetPanel(session,"tabs","prediction")
    G <- aggregate(data=mydataset3,Grocery~kc$cluster,mean)
    M <- aggregate(data=mydataset3,Milk~kc$cluster,mean)
    
    output$text2 <- renderPrint({
      G
      
    })
    output$text3 <- renderPrint({
      M
      
    })
    
    output$text4 <- renderPrint({
      cl <- kc$centers
      cl
    })
    
 
    
  })
  
}
shinyApp(ui, server)
