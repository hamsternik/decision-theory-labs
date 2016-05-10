library(shiny)

shinyServer(function(input, output) {
  
  ### ---------- Data Preparation
  
  calculateApplicants <- function() {
    applicantHeightArr <-sample(seq(from = 0, to = 1, by = .01), size = input$applicantAmount, replace = TRUE)
    applicantHeightArr <- applicantHeightArr * (input$maxHeight - input$minHeight) + input$minHeight
    return(applicantHeightArr)
  }
  
  ### ---------- Calculations
  
  calculateProbabailty <- reactive({
    
    ### DEBUG
    # start_profiling()
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
    
    ### DEBUG
    # finish_proifiling()
    ###
    
    probability <- as.double(numberOfWins / input$experimentSerialNumber)
    print(probability)
    
    return(probability)
  })
  
  ### ---------- UI Render
  
  output$probability_info <- renderText({
    paste0("Probability of choosing applicant: ", calculateProbabailty())
  })
  
  ### ---------- DEBUG
  
  start_profiling <- function() {
    ptm <<- proc.time()
    print(ptm)
  }
  
  finish_proifiling <- function() {
    ptm <<- proc.time() - ptm
    print(ptm)
  }
  
})