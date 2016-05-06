library(shiny)

shinyServer(function(input, output) {
  
  ### ---------- Data Preparation
  
  calculateApplicants <- function() {
    applicantHeightArr <-sample(seq(from = 0, to = 1, by = .01), size = input$applicantAmount, replace = TRUE)
    applicantHeightArr <- applicantHeightArr * (input$maxHeight - input$minHeight) + input$minHeight
    return(applicantHeightArr)
  }
  
  ### ---------- Calculations
  
  # IMPLEMENTATION: Algo #1
  calculateProbabailtyByFirstAlgo <- reactive({
    
    ###
    ptm <- proc.time()
    ###
    
    numberOfWins <- 0
    
    for(i in 1:input$experimentSerialNumber) {
      applicantHeightArr <-sample(seq(from = 0, to = 1, by = .01), size = input$applicantAmount, replace = TRUE)
      applicantHeightArr <- applicantHeightArr * (input$maxHeight - input$minHeight) + input$minHeight
      people <- applicantHeightArr
      
      globalMax <- max(people)
      selectedElement <- round(input$applicantAmount / exp(1)) + 1
      localMax <- max(people[1:selectedElement])
      
      ind <- 1
      for(j in selectedElement:input$applicantAmount) {
        if (people[j] >= localMax) {
          ind <- j; break;
        }
      }
      
      if ((globalMax - people[ind]) <= input$error)
        numberOfWins <- numberOfWins + 1
    }
    
    output$applicants_plot <- renderPlot({
      amountOfApplicants <- "Amount of applicants"
      plot(people,
           xlab = amountOfApplicants,
           ylab = amountOfApplicants,
           main = "Applicants general amount",
           col = "black"
      )
    })
    
    ###
    print(proc.time() - ptm)
    ###
    
    probability <- as.double(numberOfWins / input$experimentSerialNumber)
    print(probability)
    return(probability)
  })
  
  # IMPLEMENTATION: Algo #2
  calculteProbabilityBySecondAlgo <- reactive({
    numberOfWins <- 0
    pretendents <- calculateApplicants()
    
    output$applicants_plot <- renderPlot({
      amountOfApplicants <- "Amount of applicants"
      plot(pretendents,
           xlab = amountOfApplicants,
           ylab = amountOfApplicants,
           main = "Applicants general amount",
           col = "black"
      )
    })
    
    mmax <- max(pretendents);
    bestIndex <- round(input$applicantAmount / exp(1)) + 1
    tmpMax = pretendents[1]
    for (i in 1:input$applicantAmount) {
      if (i < bestIndex) {
        if (pretendents[i] > tmpMax) {
          print(pretendents[i])
          print(tmpMax)
          tmpMax <- pretendents[i];
        }
      }
      if (i == bestIndex) {
        if (pretendents[bestIndex] > tmpMax) {
          tmpMax = pretendents[bestIndex];
          if (mmax - tmpMax <= input$error) {
            numberOfWins <- numberOfWins + 1
          }
          break;
        }
      }
      if (i > bestIndex) {
        if (pretendents[i] > tmpMax) {
          tmpMax = pretendents[i];
          if (mmax - tmpMax <= input$error) {
            numberOfWins <- numberOfWins + 1
          }
          break;
        }
      }
    }
    
    probability <- as.double(numberOfWins / input$experimentSerialNumber)
    return(probability)
  })
  
  ### ---------- UI Render
  
  output$probability_info <- renderText({
    paste0("Probability of choosing applicant: ", calculateProbabailtyByFirstAlgo())
    #paste0("Probability of choosing applicant: ", calculteProbabilityBySecondAlgo())
  })
  
})