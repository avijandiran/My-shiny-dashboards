library(shiny)
library(shinydashboard)
library(DT)
library(shinythemes)
library(shinyWidgets)
require(ggplot2)
require(shiny)
library(plotly)
library(ggvis)

shinyUI(
  dashboardPage(title = "Demo",skin="yellow",
                dashboardHeader(title="My First Dashboard!",dropdownMenu(
                  type="message",messageItem(from="Yokesh",message = "This is my 1st dashboard that i have created!")
                )),
                dashboardSidebar(
                  sidebarMenu(                                          
                    sidebarSearchForm("searchText","buttonSearch","Search"),
                    #                    menuItem("Histogram plot",tabName = "dashboard",icon = icon("dashboard")),                                                   
                    menuItem("Exploratory data analysis!",tabName = "Software",icon = icon("th")),
                    menuItem("Additional analysis!",tabName = "Voice"),
                    menuItem("Detailed analysis",tabName="ab",badgeLabel = "New",badgeColor = "green"),
                    menuItem("Raw data",tabName = "ac")
                  )),
                dashboardBody(
                  tabItems(
                    tabItem(tabName = "Software",
                            tabsetPanel(type="tabs",
                                        tabPanel("Data",
                                                 fluidPage(
                                                   fluidRow(tags$h1("Original Data table & Filtered Data table")),
                                                   fluidRow(column(10,DT::dataTableOutput('faith'))),
                                                   fluidRow(column(8,verbatimTextOutput('filteredTableSelected')))
                                                 )),
                                        tabPanel("Summary",verbatimTextOutput("summ")),
                                        tabPanel("Structure",verbatimTextOutput("struc")))),
                    tabItem(tabName = "Voice",h1("Page under construction!")),
                    tabItem(tabName = "ab",h1("New analysis coming soon!")),
                    tabItem(tabName = "ac",h1("Page under construction!"))
                    
                  )
                )
  )
)



server
========
  library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)
library(stringr)
library(plotly)
library(ggplot2)
library(shinyBS)
library(reshape2)
library(tidyverse)
library(plyr)

shinyServer(function(input,output,session){
  
  
  myDF=mtcars
  # View(myDF)
  myDF=cbind(car.names = rownames(myDF), myDF)  ## Assigning the row names to a new column.
  # View(myDF)
  rownames(myDF)=NULL  ## And then removing the row names away from my data frame
  
  # Specifying the column names and then converting to categorical in myDF dataframe table
  cols=c("cyl","vs","am","gear","carb")
  myDF[cols]=lapply(myDF[cols], factor)
  # str(myDF)
  
  # subseting the numerical attributes alone from the myDF and storing it in a new variable named sub_myDF
  subset_colclasses <- function(myDF, colclasses="numeric") {
    myDF[,sapply(myDF, function(vec, test) class(vec) %in% test, test=colclasses)]
  }
  sub_myDF=subset_colclasses(myDF)
  
  
  ## creating a reactive function
  mydata <- reactive({myDF})
  
  ## passing the reactive function created above over down here.
  output$faith=DT::renderDataTable({
    DT::datatable(mydata(), options = list(scrollX = TRUE, sScrollY = '75vh', scrollCollapse = TRUE), extensions = list("Scroller"))
  })
  
  
  ## creating a reactive function for storing the values that we are selecting and then subseting on the original data.
  filteredTable_selected <- reactive({
    ids <- input$faith_rows_selected
    mydata()[ids,]
  })
  
  
  
  ## Defining the filtered data table along in a verbatim text input 
  output$filteredTableSelected <- renderPrint({
    filteredTable_selected()
  })  
  
  
  output$summ=renderPrint({
    summary(myDF)
  })
  
  output$struc=renderPrint({
    str(myDF)
  })  
  