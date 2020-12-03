library(shiny)
library(shinydashboard)
library(dplyr)
library(tidyr)
library(DT)
library(PythonInR)
library(pdftools)
library(rsconnect)



pyConnect()
pyExecfile("helper.py")

ui = 
  dashboardPage(
    dashboardHeader(title = 'JobScanner'),
    dashboardSidebar(
      sidebarMenu(
        menuItem("About", tabName = "about", icon = icon("info")),
        menuItem("Search Job", tabName = "search", icon = icon("database")),
        fileInput('file1', "Insert your JD as PDF file",
                  accept=c('pdf'))
        
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(tabName = 'about',
                fluidRow(
                  box(title = 'Candidate Matching for employer!!', status = "primary", solidHeader = TRUE, collapsible = F, width = 12,
                      br(),
                      tags$p("This app allows user use JD to find best candidate matches in database based on Jaccard similarity of the resume and job description.")
                  ))
                , fluidRow(
                  box(title = "About Me", status = "primary", solidHeader = TRUE, collapsible = T, collapsed = T,width = 12,
                      column(
                        width = 10,
                        h4("Job Scanner Team"),
                        tags$p("(greetings from Team leader Zhang)"),
                        
                        tags$hr()
                      )
                  ))
        ),
        tabItem(tabName = "search",
                fluidRow(
                  box(width = NULL, status = "primary", solidHeader = TRUE,
                      title = "Your top matched job, hand picked by team from CIS 4398!",dataTableOutput("table"))
                )
        )
      )
    )
  )
server = function(input, output){
  output$table <- renderDataTable({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    
    cvPdf = paste(pdf_text(inFile$datapath),collapse = '')
    pyCall('get_best_match', cvPdf)
    f = read.csv(file="BestMatch.csv",
                 sep = ",",dec = ".", stringsAsFactors = F) 
    data = f%>% mutate(.)
    return(data[,-1])
  }, escape = FALSE )
}

shinyApp(ui, server)


                

