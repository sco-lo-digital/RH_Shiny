library(shiny)

load("rh.roc.RData")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$text1 <- renderText({ 
        paste("The number of TPs at this rate is", tps <- rh_roc[rh_roc$True.Positive.Rates == input$TP,"True.Positive.Scores"])
  
                              }
                            )
  output$text2 <- renderText({ 
        paste("The expected revenue at the avg. value you've entere is", revs <- tps * input$revenue)
    
  }
  )
                                    }
            ) 
