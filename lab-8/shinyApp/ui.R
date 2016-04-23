library(shiny)

shinyUI(fluidPage(
    headerPanel("Decision-Making [Lab Project #8]"),
    sidebarLayout(
        sidebarPanel(
            numericInput("experimentSerialNumber", label = "Количество серий экспериментов", value = 1, min = 1, max = 1000, step = 1),
            numericInput("error", label = "Ошибка", value = 1, min = 0, max = 40, step = 1),
            numericInput("maxHeight", label = "Минимальная высоота", value = 160, min = 160, max = 190, step = 1),
            numericInput("minHeight", label = "Максимальная высота", value = 190, min = 160, max = 190, step = 1),
            numericInput("applicantAmount", label = "Количество претиндентов", value = 100, min = 1, max = 1000, step = 5)
        ),
        mainPanel(
            plotOutput("plot1", click = "plot_click"),
            verbatimTextOutput("probability_info")
            #verbatimTextOutput("some_text")
        )
    )
))