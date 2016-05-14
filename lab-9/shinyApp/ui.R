library(shiny)

shinyUI(fluidPage(
    headerPanel("[Lab Project #9]"),
    sidebarLayout(
        sidebarPanel(
            numericInput("rowNumber", label = "Enter number of rows", value = 5, min = 1, max = 20, step = 1),
            numericInput("columnNumber", label = "Enter number of columns", value = 5, min = 1, max = 20, step = 1)
        ),
        mainPanel(
            p("Заданная матрица игры (с рандомно заданными значениями)"),
            tableOutput("rawMatrix"),
            
            br(),
            
            p("Упрощенная матрица M"),
            tableOutput("outstandingMatrix")
        )
    )
))