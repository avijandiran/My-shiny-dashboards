library(shiny)

ui <-navbarPage("Welcome",id="nav",

  tabPanel("Login",
              textInput("text1",label = "Username"),
              textInput("text2",label = "Password"),
              actionButton("action1",label = "Sign in"),
              br(),
              br(),
              actionLink("actionl1",label="Sign Up/"),
              actionLink("actionl2",label="Forgot Password")
        ),
  
  
  tabPanel("Sign Up",
              textInput("text3",label = "Email Id"),
              textInput("text4",label = "Name"),
              textInput("text5",label = "Create a Password"),
              dateInput("date1",label="Date of Birth",value="2019-05-30"),
              radioButtons("radio1",label="Gender",choices=list("Male","Female","Other")),
              selectInput("select1",label = "Country",choices=list("India","Africa","America")),
              actionButton("action2",label = "Sign up")
           ),
  
    tabPanel("Login DB",
             verbatimTextOutput("text6"),
             verbatimTextOutput("text7")
             ),
  
  
    tabPanel("SignUp DB",
             verbatimTextOutput("text8"),
             verbatimTextOutput("text9"),
             verbatimTextOutput("text10"),
             verbatimTextOutput("text11"),
             verbatimTextOutput("text12"),
             verbatimTextOutput("text13")
             
            )
  
    )
             
           


server <- function(input, output, session) {
  
username <- c("Anusuya","Mohana")
password <- c(12345,67890)
logindb <- data.frame(username,password)

observeEvent(input$action1,{
  logindb
  updateTabsetPanel(session,"nav","Login DB")
  
  output$text6 <- renderPrint({ input$text1 })
  output$text7 <- renderPrint({ input$text2 })
  
}) 
  
  
  observeEvent(input$action2,{
    updateTabsetPanel(session,"nav","SignUp DB")
    
    output$text8<- renderPrint({ input$text3})
    output$text9<- renderPrint({ input$text4})
    output$text10<- renderPrint({ input$text5})
    output$text11<- renderPrint({ input$date1})
    output$text12<- renderPrint({ input$radio1})
    output$text13<- renderPrint({ input$select1})
  })
  
  
  
}

shinyApp(ui, server)