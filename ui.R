library(shiny)
# Define UI for
shinyUI(fluidPage(
  # Application title
  titlePanel(img(src="restorationhardware.png", height = 100, width = 100)),
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel( h3("Calibrate Model"),
                  selectInput("TP",
                              label = h5("True Positive Rate"), 
                              choices = rh_roc$True.Positive.Rates),
                  h3("Calibrate Business Considerations"),
                  numericInput("cost",
                               label = h5("Cost of Sending Catalog\n ($/catalog)"), 
                               value = 40.00),
                  numericInput("revenue",
                               label = h5("Average value of Teen order ($)"), 
                               value = 300.00)
                  ),
    mainPanel(h1("Summary"),
              textOutput("text1"),
              textOutput("text2"))
  )
))
