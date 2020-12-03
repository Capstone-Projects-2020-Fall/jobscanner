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
                ,
                

