tryCatch({
  source("currency/library.r")
}, warning = function(e) {
  source("library.r")
})

currencyData <- prepareCurData()
selectedList <- vectToList(unique(currencyData$Currency))





