library(XML)

# fetch the raw currency data
fetchCurData <- function() {
  currencyType <- rbind(
    c("USD", "USA"), 
    c("JPY", "Japan"), 
    c("HKD", "Hong Kong"),
    c("GBP", "UK"), 
    c("AUD", "Canada"),
    c("SGD", "Singapore"), 
    c("CHF", "Swiss"), 
    c("HKD", "Hong Kong"),
    c("EUR", "Europe"), 
    c("CNY", "China")
  )
  colnames(currencyType) <- c("Currency","Country")
  currencyUrl = "http://rate.bot.com.tw/xrt/quote/day/"
  
  currency.table = c()
  
  for(item in currencyType[,1]) {
    currency.table <- rbind(
      currency.table, 
      readHTMLTable(paste(currencyUrl, item, sep=""), header=T, which=1,stringsAsFactors=F)
    )
  }
  
  currency.table[,1] <- as.POSIXct(currency.table[,1])
  currency.table[,3] <- as.numeric(currency.table[,3])
  currency.table[,4] <- as.numeric(currency.table[,4])
  currency.table[,5] <- as.numeric(currency.table[,5])
  currency.table[,6] <- as.numeric(currency.table[,6])
  
  return(currency.table)
}

# prepare a currency data
prepareCurData <- function() {
  # fetch currency data
  rawCurrencyData <- fetchCurData()
  rawCurrencyData <- cbind(rawCurrencyData, (rawCurrencyData[,5] + rawCurrencyData[,6])/2.0)
  currencyCols = c(
    "Time",
    "Currency",
    "Cash-Bank-Buy-in",
    "Cash-Bank-Sold-out",
    "Spot-Bank-Buy-in",
    "Spot-Bank-Sold-out",
    "Spot-Bank-Trend-Data"
  )
  colnames(rawCurrencyData) <- currencyCols
  
  return(rawCurrencyData)
}

# prepare a list
vectToList <- function(vectData) {
  return(sapply(vectData, function(x) x))
}
