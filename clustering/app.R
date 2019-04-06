library(caTools)
library(shiny)
library(cluster)


ui <- fluidPage(
  fluidRow(
    tabsetPanel(type = "tabs",id="tab",
                
                tabPanel("Input",h3("Load the Dataset and Split into Test and Train Data"),
                         
                         fluidRow ( 
                           column(6,
                                  DT::dataTableOutput("table1"),height="auto"),
                           column(6,
                                  DT::dataTableOutput("table2"),height="auto")
                         ),
                         
                         fluidRow(
                           column(6 ,offset=2,
                                  actionButton("button1","Clean the Dataset"))
                         ),
                         
                         fluidRow(
                           column(6,
                                  numericInput("num",label = "Probability",value = 0.7,min=0.1,max=1,step = 0.1)),
                           column(6,actionButton("button2","Split the dataset"))
                         )
                ),
                
                
                tabPanel("Model",h2("Kmeans Clustering Model"),
                         
                         fluidRow(
                           column(6,offset = 6,
                                  actionButton("button3","Run Model"))
                         ),
                         
                         fluidRow(
                           column(6,
                                  plotOutput("plot1")),
                           column(6,
                                  plotOutput("plot2"))
                         ),
                         
                         fluidRow(
                           column(12,
                                  verbatimTextOutput("text1"))
                         ),
                         fluidRow(
                           column(6,offset = 6,
                                  actionButton("button4","Predict"))
                         )
                ),
                
                
                tabPanel("Prediction",h3("Prediction"),
                         fluidRow(
                           column(6,
                                  verbatimTextOutput("text2")),
                           column(6,
                                  verbatimTextOutput("text3"))
                         ),
                         fluidRow(
                           column(12,
                                  verbatimTextOutput("text4"))
                         ))
    )))





#sersmydataset1 <<-read.csv("C:/U/Acer/Documents/Clustering/Wholesale customers data.csv")

mydataset1<<-read.csv(file.choose()) 
server <- function(input, output, session) {
  
  
  mydataset2 <<-(na.omit(mydataset1))
  mydataset3<<-(mydataset2)
  
  output$table1<- DT::renderDataTable(DT::datatable(
    {
      mydataset1
      
    },options = list(
      searching = TRUE,
      autoWidth=TRUE,
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
        autoWidth=TRUE,
        paging=TRUE,
        scrollX=TRUE,
        scrollY=TRUE,
        fixedHeader=TRUE)))
    
  })
  
  mydataset3$Channel <- NULL
  mydataset3$Region <- NULL
  
  observeEvent(input$button2,{
    set.seed(88)
    split <- sample.split(mydataset3,SplitRatio = 0.7)
    split
    
    trainingdata <<- subset(mydataset3,split=="TRUE")
    testingdata <<- subset(mydataset3,split=="FALSE")
    updateTabsetPanel(session,"tab",selected = "Model")
  })
  
  
  
  observeEvent(input$button3,{
    kc3 <<-kmeans(mydataset3,3)
    
    
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
    
    updateTabsetPanel(session,"tab",selected = "Prediction")
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