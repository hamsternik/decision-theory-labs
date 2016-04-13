library(shiny)

shinyServer(function(input, output) {
  
  ################# DATA HANDLER BLOCK #################

  # function: initialize raw matrix with random values
  initRawMatrix <- reactive({
    dataMatrix <- matrix(data = sample(-100:100, getRowNumber() * getColumnNumber()), nrow = getRowNumber(), ncol = getColumnNumber())
    return(dataMatrix)
  })
  
  # function: initialize weights matrix
  initWeightsMatrix <- reactive({
    newDataMatrix <- matrix(data = rep(0, getRowNumber() * getColumnNumber()), nrow = getRowNumber(), ncol = getColumnNumber())
    return(newDataMatrix)
  })
  
  # function: calculate new matrix with weights of each new cell or finding optimal win road
  dataMatrixWeightsCalculation <- reactive({
    rawDataMatrix <- initRawMatrix()
    newDataMatrix <- initWeightsMatrix()
    
    # move from top right cell to down left one
    newDataMatrix[1, getColumnNumber()] = 0
    for (i in 1:getRowNumber()) {
      for (j in getColumnNumber():1) {
        if (j != 1)
          newDataMatrix[i, j-1] <- max(newDataMatrix[i, j] + rawDataMatrix[i, j-1], newDataMatrix[i, j-1])
        if (i != getRowNumber() && j != 1)
          newDataMatrix[i+1, j-1] <- max(newDataMatrix[i, j] + rawDataMatrix[i+1, j-1], newDataMatrix[i+1, j-1])
        if (i != getRowNumber())
          newDataMatrix[i+1, j] = max(newDataMatrix[i, j] + rawDataMatrix[i+1, j], newDataMatrix[i+1, j])
      }
    }
    return(newDataMatrix)
  })
  
  # function: calculate best road which move us to 'easy win' last cell
  calculateBestRoadForWin <- reactive({
    newDataMatrix <- dataMatrixWeightsCalculation()
    bestRoadForWin <- c(newDataMatrix[getRowNumber(), 1])
    i = getRowNumber(); j = 1
    while (i != 1 && j != getColumnNumber()) {
      winCell <- max(newDataMatrix[i-1,j], newDataMatrix[i-1,j+1], newDataMatrix[i,j+1])
      bestRoadForWin <- append(bestRoadForWin, winCell)
      if (winCell == newDataMatrix[i-1,j]) { i = i - 1 }
      else if (winCell == newDataMatrix[i-1,j+1]) { i = i - 1; j = j + 1 }
      else if (winCell == newDataMatrix[i,j+1]) { j = j + 1 }
    }
    while (i != 1) {
      bestRoadForWin <- append(bestRoadForWin, newDataMatrix[i-1, j])
      i = i - 1
    }
    while (j != getColumnNumber()) {
      bestRoadForWin <- append(bestRoadForWin, newDataMatrix[i, j+1])
      j = j + 1
    }  
    return(t(as.matrix(bestRoadForWin)))
  })
  
  calculateBestRoadForWinInRawMatrix <- reactive({
    rawDataMatrix <- initRawMatrix()
    newDataMatrix <- dataMatrixWeightsCalculation()
    bestRoadForWinInRawMatrix <- c(rawDataMatrix[getRowNumber(), 1])
    bestRoadForWin <- c(newDataMatrix[getRowNumber(), 1])
    i = getRowNumber(); j = 1
    while (i != 1 && j != getColumnNumber()) {
      winCell <- max(newDataMatrix[i-1,j], newDataMatrix[i-1,j+1], newDataMatrix[i,j+1])
      bestRoadForWin <- append(bestRoadForWin, winCell)
      if (winCell == newDataMatrix[i-1,j]) { i = i - 1; bestRoadForWinInRawMatrix <- append(bestRoadForWinInRawMatrix, rawDataMatrix[i,j]) }
      else if (winCell == newDataMatrix[i-1,j+1]) { i = i - 1; j = j + 1; bestRoadForWinInRawMatrix <- append(bestRoadForWinInRawMatrix, rawDataMatrix[i,j]) }
      else if (winCell == newDataMatrix[i,j+1]) { j = j + 1; bestRoadForWinInRawMatrix <- append(bestRoadForWinInRawMatrix, rawDataMatrix[i,j]) }
    }
    while (i != 1) {
      bestRoadForWin <- append(bestRoadForWin, newDataMatrix[i-1, j])
      bestRoadForWinInRawMatrix <- append(bestRoadForWinInRawMatrix, rawDataMatrix[i-1,j])
      i = i - 1
    }
    while (j != getColumnNumber()) {
      bestRoadForWin <- append(bestRoadForWin, newDataMatrix[i, j+1])
      bestRoadForWinInRawMatrix <- append(bestRoadForWinInRawMatrix, rawDataMatrix[i,j+1])
      j = j + 1
    }  
    return(t(as.matrix(bestRoadForWinInRawMatrix)))
  })
  
  ### getters block
  
  getRowNumber <- reactive({
    return(input$rowNumber)
  })
  getColumnNumber <- reactive({
    return(input$columnNumber)
  })
  
  ################# UI RENDER BLOCK #################
  
  output$rawMatrix <- renderTable({
    initRawMatrix()
  })
  
  output$weightsMatrix <- renderTable({
    dataMatrixWeightsCalculation()
  })
  
  output$bestRoadForWin <- renderTable({
    calculateBestRoadForWin()
  })
  
  output$bestRoadForWinInRawMatrix <- renderTable({
    calculateBestRoadForWinInRawMatrix()
  })
  
})