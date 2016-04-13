library(shiny)

shinyUI(fluidPage(
  headerPanel("Dynamic Programming [Lab Project #7]"),
  sidebarLayout(
    sidebarPanel(
      p("Динамическое программирование в теории управления и теории вычислительных систем — 
        способ решения сложных задач путём разбиения их на более простые подзадачи. 
        Он применим к задачам с оптимальной подструктурой (англ.), 
        выглядящим как набор перекрывающихся подзадач, сложность которых чуть меньше исходной. 
        В этом случае время вычислений, по сравнению с «наивными» методами, можно значительно сократить."),
      tags$hr(),
      
      numericInput("rowNumber", label = "Enter number of rows", value = 5, min = 1, max = 20, step = 1),
      numericInput("columnNumber", label = "Enter number of columns", value = 5, min = 1, max = 20, step = 1)
    ),
    mainPanel(
      p("Первоначальная таблица с рандомно заданными значениями"),
      tableOutput("rawMatrix"),
      br(),
      
      p("Посчитання таблица весов"),
      tableOutput("weightsMatrix"),
      br(),
      
      p("Лучший путь от начала до конца в матрице весов"),
      tableOutput("bestRoadForWin"),
      
      p("Лучший путь от начала до конца в первой матрице"),
      tableOutput("bestRoadForWinInRawMatrix")
    )
  )
))