library(shiny)

ui <- fluidPage(
  h1(titlePanel("Title of the panel")),
  
  sidebarLayout(position = "right",
                sidebarPanel ("sidebar panel"),
                mainPanel(
                  h1("First level title",align="center"),
                  h2("Second level title"),
                  h3("Third level title"),
                  h4("Fourth level title"),
                  h5("Fifth level title"),
                  h6("Sixth level title")
  )
)
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)