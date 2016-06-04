library(shiny)
library(knitr)
library(ggplot2)
library(ggthemes)
library(formattable)
library(shinydashboard)


load("rh.roc.RData")


shinyServer(function(input, output) {
    
   
  output$table1 <- renderFormattable({ 
        tps <- rh_roc[rh_roc$Accuracy == input$acc,"True.Positive.Scores"] 
        tns <- rh_roc[rh_roc$Accuracy == input$acc,"True.Negative.Scores"]
        fps <- rh_roc[rh_roc$Accuracy == input$acc,"False.Predictive.Scores"]
        fns <- rh_roc[rh_roc$Accuracy == input$acc,"False.Negative.Scores"]
        
        conf_matrix <- data.frame(TrueNegative = as.numeric(tns), FalsePositive =fps, FalseNegative = fns, TruePositive = tps, stringsAsFactors = F)
#         conf_matrix <- data.frame(rbind(c(tns, fps),c(fns, tps)))
#         names(conf_matrix) <- c("Predicted False", "Predicted True")
#         row.names(conf_matrix) <- c("Actually False", "Actually True")
        
       formattable(conf_matrix, list(
           TrueNegative = color_tile("white", "orange"),
           FalsePositive = color_tile("white", "orange"),
           FalseNegative = color_tile("white", "orange"),
           TruePositive = color_tile("white", "orange")
        )
        )
       
  
                              }
                            )
  
  output$text2 <- renderText({ 
      tps <- rh_roc[rh_roc$Accuracy == input$acc,"True.Positive.Scores"]
      tns <- rh_roc[rh_roc$Accuracy == input$acc,"True.Negative.Scores"]
      fps <- rh_roc[rh_roc$Accuracy == input$acc,"False.Predictive.Scores"]
      fns <- rh_roc[rh_roc$Accuracy == input$acc,"False.Negative.Scores"]
      tot_rev <- tps * input$revenue
      tot_cost <-  (tps + fps) * input$cost 
      paste("The ratio of Revenue to Cost is ", prettyNum(tot_rev / tot_cost, big.mark = ",", digits = 2))
      
        }
  )
  
  
  output$text3 <- renderText({ 
      tps <- rh_roc[rh_roc$Accuracy == input$acc,"True.Positive.Scores"]
      tns <- rh_roc[rh_roc$Accuracy == input$acc,"True.Negative.Scores"]
      fps <- rh_roc[rh_roc$Accuracy == input$acc,"False.Predictive.Scores"]
      fns <- rh_roc[rh_roc$Accuracy == input$acc,"False.Negative.Scores"]
      tot_rev <- tps * input$revenue
      tot_cost <-  (tps + fps) * input$cost 
      paste("The Net Profit is ", prettyNum(tot_rev - tot_cost, big.mark = ","))
      
  }
  )
  
  output$plot1 <- renderPlot({ 
        tps <- rh_roc[rh_roc$Accuracy == input$acc,"True.Positive.Scores"]
        tns <- rh_roc[rh_roc$Accuracy == input$acc,"True.Negative.Scores"]
        fps <- rh_roc[rh_roc$Accuracy == input$acc,"False.Predictive.Scores"]
        fns <- rh_roc[rh_roc$Accuracy == input$acc,"False.Negative.Scores"]
        tot_rev <- tps * input$revenue
        tot_cost <-  (tps + fps) * input$cost 
        df <- data.frame(Financials = factor(c("Revenue", "Cost"),levels = c("Revenue", "Cost")), Values = c(tot_rev, tot_cost))
        ggplot(df, aes(x= Financials, y = Values, fill = Financials)) + geom_bar(stat = "identity") + theme(legend.position="none") + theme_fivethirtyeight() + scale_fill_fivethirtyeight()
        #barplot(c(tot_rev, tot_cost), names.arg = c("Revenue", "Cost"))
    
  }
  )
                                    }
            ) 
