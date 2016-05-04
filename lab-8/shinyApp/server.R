library(shiny)

shinyServer(function(input, output) {
    ### BLOCK - Data Handling
    
    ### ERROR WHYYYYYY!!!?
#     calculateApplicants <- reactive({
#         applicantHeightArr <-sample(seq(from = 0, to = 1, by = .01), size = getApplicantAmount(), replace = TRUE)
#         applicantHeightArr <- applicantHeightArr * (getMaxHeight() - getMinHeight()) + getMinHeight()
#         return(applicantHeightArr)
#     })
    
    calculateNumberOfWins <- function() {
    #calculateNumberOfWins <- reactive({
                numberOfWins <- 0
                for(i in 1:getExperimentSeriaNumber()) {
                    applicantHeightArr <- sample(seq(from=0, to=1, by=.01), size = getApplicantAmount(), replace = TRUE)
                    applicantHeightArr <- applicantHeightArr * (getMaxHeight() - getMinHeight()) + getMinHeight()
                    peoples <- applicantHeightArr
                    output$plot1 <- renderPlot({
                                    amountOfApplicants <- "Amount of applicants"
                                    plot(peoples,
                                        xlab = amountOfApplicants,
                                        ylab = amountOfApplicants,
                                        main = "Applicants general amount",
                                        col = "black"
                                    )
                                })
                    globalMax <- max(peoples)
                    selectedElement <- round(getApplicantAmount() / exp(1)) + 1
                    localMax <- max(peoples[1:selectedElement])
                    ind <- 1
                    for(j in selectedElement:getApplicantAmount()) {
                        if (peoples[j] >= localMax) {
                            ind <- j; break;
                        }
                    }
                    if ((globalMax - peoples[ind]) <= getErrorValue()) {
                        numberOfWins = numberOfWins + 1
                        output$some_text <- renderText({
                            paste0("Last winner: ", peoples[ind])
                        })
                    } else {
                        output$some_text <- renderText({
                            paste0("Last looser: ", globalMax)
                        })
                    }
                }
                return(numberOfWins)
        
        # LOOOOOOOOOOOOOOOOOOOOL
#         delta <- input$error
#         numberOfWins <- 0
#         applicantHeightArr <- sample(seq(from=0, to=1, by=.01), size = getApplicantAmount(), replace = TRUE)
#         applicantHeightArr <- applicantHeightArr * (getMaxHeight() - getMinHeight()) + getMinHeight()
#         pretendents <- applicantHeightArr
#         print(pretendents)
#         output$plot1 <- renderPlot({
#             amountOfApplicants <- "Amount of applicants"
#             plot(pretendents,
#                 xlab = amountOfApplicants,
#                 ylab = amountOfApplicants,
#                 main = "Applicants general amount",
#                 col = "black"
#             )
#         })
#         
#         mmax <- max(pretendents);
#         bestIndex <- round(getApplicantAmount() / exp(1)) + 1
#         tmpMax = pretendents[1]
#         for (i in 1:getApplicantAmount()) {
#             if (i < bestIndex) {
#                 if (pretendents[i] > tmpMax) {
#                     print(pretendents[i])
#                     print(tmpMax)
#                     tmpMax <- pretendents[i];
#                 }
#             }
#             if (i == bestIndex) {
#                 if (pretendents[bestIndex] > tmpMax) {
#                     tmpMax = pretendents[bestIndex];
#                     if (mmax - tmpMax <= delta) {
#                         numberOfWins <- numberOfWins + 1
#                     }
#                     break;
#                 }
#             }
#             if (i > bestIndex) {
#                 if (pretendents[i] > tmpMax) {
#                     tmpMax = pretendents[i];
#                     if (mmax - tmpMax <= delta) {
#                         numberOfWins <- numberOfWins + 1
#                     }
#                     break;
#                 }
#             }
#         }
#         print(numberOfWins)
#         probability <- as.double(numberOfWins / getExperimentSeriaNumber())
#         return(probability)
#})
    }
    
    calculateProbability <- function() {
    #calculateProbability <- reactive({
        numberOfWins <- calculateNumberOfWins()
        probability <- as.double(numberOfWins / getExperimentSeriaNumber())
        return(probability)
    #})
    }
    
    ### BLOCK - Getters
    
    getExperimentSeriaNumber <- reactive({
        return(input$experimentSerialNumber)
    })
    
    getErrorValue <- reactive({
        return(input$error)
    })
    
    getMinHeight <- reactive({
        return(input$minHeight)
    })
    
    getMaxHeight <- reactive({
        return(input$maxHeight)
    })
    
    getApplicantAmount <- reactive({
        return(input$applicantAmount)
    })
    
    ### BLOCK - UI Rendering
    
#     output$plot1 <- renderPlot({
#         amountOfApplicants <- "Amount of applicants"
#         plot(
#             calculateApplicants(),
#             xlab = amountOfApplicants,
#             ylab = amountOfApplicants,
#             main = "Applicants general amount",
#             col = "black"
#         )
#     })
    
    output$probability_info <- renderText({
        p <- calculateProbability()
        #p <- calculateNumberOfWins()
        paste0("Probability of choosing applicant: ", p)
    })
    
    })