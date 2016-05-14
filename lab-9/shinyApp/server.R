library(shiny)

shinyServer(function(input, output) {
    
    ################# DATA HANDLER BLOCK #################
    
    # function: initialize raw matrix with random values
    initGameMatrix <- reactive({
        gameMatrix <- matrix(data = sample(5:20, input$rowNumber * input$columnNumber, replace = T), nrow = input$rowNumber, ncol = input$columnNumber)
        return(gameMatrix)
    })
    
    initOutstandingGameMatrix <- reactive({
        outstandingGameMatrix <- initGameMatrix()
        
        rowsNumber <- input$rowNumber
        columnsNumber <- input$columnNumber
        
        # remove unused rows
        for (i in 1:rowsNumber) {
            for (j in 1:rowsNumber) {
                if ( (isOutstandingRow(outstandingGameMatrix[i,], outstandingGameMatrix[j,], rowsNumber) == 1) && (i != j) ) {
                    outstandingGameMatrix <- outstandingGameMatrix[]
                } else if ( (isOutstandingRow(outstandingGameMatrix[i,], outstandingGameMatrix[j,], rowsNumber) == -1) && (i != j)) {
                    
                }
            }
        }
        
#         for (i in 1:rowsNumberWithoutLast) {
#             if (excludeRow(outstandingGameMatrix[i, columnsRange], outstandingGameMatrix[i+1, columnsRange]) == 1) {
#                 outstandingGameMatrix[i, columnsRange] <- outstandingGameMatrix[i, columnsRange]
#                 rowsNumberWithoutLast <- rowsNumberWithoutLast - 1
#             } else if (excludeRow(outstandingGameMatrix[i, columnsRange], outstandingGameMatrix[i+1, columnsRange]) == -1) {
#                 outstandingGameMatrix[i, columnsRange] <- outstandingGameMatrix[i+1, columnsRange]
#                 rowsNumberWithoutLast <- rowsNumberWithoutLast - 1
#             }
#         }
        
        # remove unused columns
        for (i in 1:columnsNumber) {
            for (j in 1:columnsNumber) {
                
            }
        }
        
#         for (j in 1:columnsNumberWithoutLast) {
#             if (excludeColumn(outstandingGameMatrix[rowsRange, j], outstandingGameMatrix[rowsRange, j]) == 1) {
#                 outstandingGameMatrix[rowsRange, j] <- outstandingGameMatrix[rowsRange, j+1]
#                 columnsNumberWithoutLast <- columnsNumberWithoutLast - 1
#             } else if(excludeColumn(outstandingGameMatrix[rowsRange, j], outstandingGameMatrix[rowsRange, j]) == -1) {
#                 outstandingGameMatrix[rowsRange, j] <- outstandingGameMatrix[rowsRange, j]
#                 columnsNumberWithoutLast <- columnsNumberWithoutLast - 1
#             }
#         }
        
        return(outstandingGameMatrix)
    })
    
    ################# ALGO BLOCK #################
    
    # excludeRow - exclude one of the passed rows
    # @arg rowAbove - [vector] first row, passed to function
    # @arg rowAbove - [vector] second row, passed to function
    # @return - [vector] one of passed rows, 
    # which sum is equal or more that another
    ### excludeRow <- function(rowAboveArg, rowBelowArg, rowLengthArg) {}
    
    getOutstandingRow <- function(rowAboveArg, rowBelowArg, rowLengthArg) {
        rowAbove <- rowAboveArg
        rowBelow <- rowBelowArg
        rowLength <- rowLengthArg
        
        summarise <- 0
        for (i in 1:rowLength) {
            if(rowAbove[i] >= rowBelow[i]) {
                summarise <- summarise + 1
            } else if(rowAbove[i] < rowBelow[i]) {
                summarise <- summarise - 1
            }
        }
        
        if (summarise == rowLengthArg) return(rowAbove)
        else if (summarise == -rowLengthArg) return(rowBelow)
    }
    
    isOutstandingRow <- function(rowAboveArg, rowBelowArg, rowLengthArg) {
        rowAbove <- rowAboveArg
        rowBelow <- rowBelowArg
        rowLength <- rowLengthArg
        
        summarise <- 0
        for (i in 1:rowLength) {
            if(rowAbove[i] >= rowBelow[i]) {
                summarise <- summarise + 1
            } else if(rowAbove[i] < rowBelow[i]) {
                summarise <- summarise - 1
            }
        }
        
        if (abs(summarise) == rowLengthArg) return(TRUE)
        else return(FALSE)
    }
    
    # DOC: exclude one of the passed columns
    # excludeColumn <- function(columnAboveArg, columnBelowArg, columnLengthArg) {}

    
    whichOutstandingColumn <- function(columnAboveArg, columnBelowArg, columnLengthArg) {
        columnAbove <- columnAboveArg
        columnBelow <- columnBelowArg
        columnLength <- columnLengthArg
        
        summarise <- 0
        for (j in 1:columnLength) {
            if(columnAbove[j] < columnBelow[j]) {
                summarise <- summarise + 1
            } else if(columnAbove[j] >= columnBelow[j]) {
                summarise <- summarise - 1
            }
        }
        
        if (summarise == columnLength) return(1)
        else if (summarise == -columnLength) return(-1)
        else return(0)
    }
    
    isOutstandingColumn <- function(columnAboveArg, columnBelowArg, columnLengthArg) {
        
        columnAbove <- columnAboveArg
        columnBelow <- columnBelowArg
        columnLength <- columnLengthArg
        
        summarise <- 0
        for (j in 1:columnLength) {
            if(columnAbove[j] < columnBelow[j]) {
                summarise <- summarise + 1
            } else if(columnAbove[j] >= columnBelow[j]) {
                summarise <- summarise - 1
            }
        }
        
        if (abs(summarise) == columnLength) return(TRUE)
        else return(FALSE)
    }
    
    ################# UI RENDER BLOCK #################
    
    output$rawMatrix <- renderTable({
        initGameMatrix()
    })
    
    output$outstandingMatrix <- renderTable({
        initOutstandingGameMatrix()
    })
})