library(shiny)
library(plotly)

tryCatch({
  source("currency/library.r")
}, warning = function(e) {
  source("library.r")
})

# shiny server main function
shinyServer(function(input, output, session) {
  
  #################
  # run every session
  #################
  
  # fetch the currency data
  currencyData <<- prepareCurData()
  
  # prepare a list
  selectedList <<- vectToList(unique(currencyData$Currency))
  #################
  
  output$lastestUpdated <- renderText({ 
    # get lastest time
    as.character(max(currencyData$Time))
  })
  
  output$trendPlot <- renderPlotly({
    
    if (length(input$name) == 0) {
      print("Please select at least one currency.")
    } else {
      trend <- currencyData[currencyData[,2] == input$name, ]
      time <- trend[,1]
      SpotBankBuy <- trend[,5]
      SpotBankSold <- trend[,6]
      
      # trend line in average
      coefVal <- coef(lm(`Spot-Bank-Trend-Data` ~ Time, data = currencyData[currencyData[,2] == input$name, ]))
      
      # buy in / sold out average
      timePoints <- length(currencyData[currencyData[,2] == input$name, 1 ])
      beginTime <- currencyData[currencyData[,2] == input$name, 1 ][ceiling(timePoints * 0.2)]
      buyInMean <- mean(currencyData[currencyData[,2] == input$name, 5 ])
      soldOutMean <- mean(currencyData[currencyData[,2] == input$name, 6 ])
      
      # plotly
      ggplot(trend) +
        geom_line(aes(x = time, y = SpotBankBuy, color = "Buy"), lwd = 1) +
        geom_line(aes(x = time, y = SpotBankSold, color = "Sold"), lwd = 1) +
        geom_abline(intercept = coefVal[1], slope = coefVal[2], lty = 1) + 
        geom_hline(yintercept = buyInMean, lty = 5) +
        annotate("text", x = beginTime, y = buyInMean * 0.9995, label = paste(round(buyInMean, digits = 3),"",sep="")) + 
        geom_hline(yintercept = soldOutMean, lty = 5) +
        annotate("text", x = beginTime, y = soldOutMean * 1.0005, label = paste(round(soldOutMean, digits = 3),"",sep="")) + 
        labs(x = "Time", y = "Spot", title = "Currency Daily Trend") +
        scale_colour_hue("Category", l = 70, c = 150) + 
        ggthemes::theme_few()
    }
    
  })
  
})
