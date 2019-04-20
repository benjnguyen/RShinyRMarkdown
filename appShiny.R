library(flexdashboard)
library(PerformanceAnalytics)
library(quantmod)
library(dygraphs)
library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      
      fluidRow(
      textInput("stock1", "Stock 1", "GOOG"),
      numericInput("w1", "Portf. %", 25, min = 1, max = 100)),
    
      fluidRow(
      textInput("stock2", "Stock 2", "FB"),
      numericInput("w2", "Portf. %", 25, min = 1, max = 100)),
    
      fluidRow(
      textInput("stock3", "Stock 3", "AMZN"),
      numericInput("w3", "Portf. %", 25, min = 1, max = 100)),
     
     fluidRow(
       dateInput("year", "Starting Date", "2010-01-01", format = "yyyy-mm-dd"),
       numericInput("rfr", "Risk-free %", .5, min = 0, max = 5, step = 0.01)
     )
     
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Investment", br(),
                 dygraphOutput("dygraphDollarGrowth")
        ),
        tabPanel("Portfolio Sharpe Ratio", br(),
                 valueBoxOutput("approvalBox1")
        ),
        tabPanel("S&P500 Sharpe Ratio", br(),
                 valueBoxOutput("approvalBox2")
        )
      )
    )
  )
)



monthly_stock_returns <- function(ticker, start_year)
{
  symbol <- getSymbols(ticker, src = 'yahoo', from = start_year, auto.assign = FALSE,
                       warnings = FALSE)
  data <- periodReturn(symbol, period = 'monthly', type = 'log')
  colnames(data) <- as.character(ticker)
  assign(ticker, data, .GlobalEnv)
}

server <- function(input, output, session)
{
  
  
  individual_stocks <- reactive({
    year <- input$year
    req(input$stock1)
    stock1 <- monthly_stock_returns(input$stock1, year)
    req(input$stock2)
    stock2 <- monthly_stock_returns(input$stock2, year)
    req(input$stock3)
    stock3 <- monthly_stock_returns(input$stock3, year)
    
    merged_returns <- merge.xts(stock1, stock2, stock3)
  })
  
  
  portfolio_growth <- reactive({
    w <- c(input$w1/100, input$w2/100, 1-(input$w1+input$w2)/100)
    dollar_growth <- Return.portfolio(individual_stocks(), weights = w, wealth.index = TRUE)
  })
  
  sharpe_ratio <- reactive({
    w1 <- c(input$w1/100, input$w2/100, 1-(input$w1+input$w2)/100)
    portfolio_monthly_returns <- Return.portfolio(individual_stocks(), weights = w1)
    
    sharpe <- round(SharpeRatio(portfolio_monthly_returns, Rf = input$rfr/100), 4)
    sharpe[1,]
  })
  
  sp500_sharpe_ratio <- reactive({
    year <- input$year
    sp500 <- monthly_stock_returns('spy', year)
    sp500_monthly <- Return.portfolio(sp500)
    sp500_sharpe <- round(SharpeRatio(sp500_monthly, Rf = input$rfr/100), 4)
  })
  
  
  output$dygraphDollarGrowth <- renderDygraph({
    dygraph(portfolio_growth(), main = "Growth of $1 Invested in Your Portfolio") %>%
      dyAxis("y", label = "$") %>%
      dyOptions(axisLineWidth = 1.5, fillGraph = TRUE, drawGrid = TRUE)
  })
  
  output$approvalBox1 <- renderValueBox({
    valueBox(value = sharpe_ratio(), icon = 'fa-line-chart', color = "primary")
  })

  output$approvalBox2 <- renderValueBox({
    valueBox(value = sp500_sharpe_ratio(), icon = 'fa-line-chart', color = "primary")
  })
}

shinyApp(ui, server)
