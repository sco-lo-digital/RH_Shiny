library(shiny)
load("rh.roc.RData")
# Define UI for
shinyUI(fluidPage(
  # Application title
  titlePanel(img(src="restorationhardware.png", height = 100, width = 100)),
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(   h3("Calibrate Business Considerations"),
                    #cost
                    numericInput("cost",
                                 label = h5("Cost of Sending Catalog\n ($/catalog)"), 
                                 value = 10.00),
                    #revenue
                    numericInput("revenue",
                                 label = h5("Average value of Teen order ($/order)"), 
                                 value = 300.00),
                    h3("Calibrate Model"),
                    h5("Deploying the model requires selecting a specified level of accuracy, which correlates to a likelihood threshold. At a higher level of accuracy, there will be a larger proportion of TP to FP, however, 
                     the absolute number of TPs is sacrificed. Try relaxing the Accuracy and observe the effects
                     on TPs and FNs"),
                    selectInput("acc",
                              label = h5("Accuracy"), 
                              choices = rh_roc$Accuracy)
                 
                  
                  ),
    mainPanel(h1("Confusion Matrix for eXtreme Gradient Boosted Trees with Early Stopping Model"),
              formattableOutput("table1"),
              textOutput("text2"),
              textOutput("text3"),
              plotOutput("plot1")
              
              )
  )
))
