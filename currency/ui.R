library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # css
  tags$head(
    tags$meta(charset = "utf-8"),
    tags$meta(name = "viewport", content = "width=device-width, initial-scale=1"),
    tags$meta(name = "description", content = "I am Jian-Kai Wang."),
    tags$meta(name = "author", content = "JKW, Jian-Kai Wang"),
    tags$title("Currency"),
    tags$link(rel = "stylesheet", type = "text/css", href = "font-awesome/4.6.3/css/font-awesome.min.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "__customized/1.0/general.css")
  ),
  
  h1("Currency in Daily"),
  
  sidebarPanel(

    # use the radio button to choose one currency
    radioButtons("name", 
                 label = h3("Interested Currency"),
                 choices = selectedList, 
                 selected = names(selectedList[1])),
    
    # control section
    hr(),
    h3("Control Panel"),
    p(tags$i(class="fa fa-clock-o", `aria-hidden` = "true"),
      ' Last Updated: ', 
      verbatimTextOutput("lastestUpdated")
    ),
    sliderInput("selectedSeconds", label = h5("Selected Seconds to Refresh"), min = 180, max = 1800, value = 600),
    p(tags$i(class="fa fa-spinner fa-pulse fa-fw"),
      ' Refresh after ', 
      span(class="timeCount"), 
      " , or ",
      actionButton("refreshNow", "refresh"),
      span(" immediately.")
    ),
    
    # additional information section
    plotOutput("termPlot", height = 30),
    p(tags$i(class="fa fa-database", `aria-hidden` = "true"),
      ' Data Source: ', 
      tags$a(href = "http://rate.bot.com.tw/xrt/history?lang=zh-TW", "Bank Of Taiwan", target = "_blank")
    ),
    p(tags$i(class="fa fa-user", `aria-hidden` = "true"),
      ' Author: ', 
      tags$a(href = "https://welcome-jiankaiwang.rhcloud.com","JianKai Wang", target = "_blank")
    )
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotlyOutput("trendPlot", height = 600)
  ),
  
  # javascript
  tags$script(type = "text/javascript", src = "seed/1.0/TimeCounter.js"),
  tags$script(type = "text/javascript", src = "__customized/1.0/general.js"),
  tags$script(HTML(""))
  
))










