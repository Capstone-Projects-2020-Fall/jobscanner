#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
options(shiny.sanitize.errors = FALSE)

library(shiny)
library(ggplot2)
library(gridExtra)
library(caret)
library(randomForest)
library(ipred)



Salaries<-read.csv("./Salaries.csv")
Salaries<<-Salaries[,-1]


# Define UI for application that Predicts Professor Salary
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Estimating Salaries for scholars"),
  
  # Sidebar with a slider input for Professor Data Entry 
  navbarPage("Job scanner panel#2",
             tabPanel("Yes we are back!",
                      sidebarPanel(width = 3,
                                   selectInput("Rank", "School Rank", unique(Salaries$rank)),
                                   selectInput("Discipline", " Discipline", unique(Salaries$discipline)),
                                   sliderInput("yrs.since.phd","Years of intern:",min = min(Salaries$yrs.since.phd),max = max(Salaries$yrs.since.phd),value = 30),
                                   sliderInput("yrs.service","Years of Service:",min = min(Salaries$yrs.service),max = max(Salaries$yrs.service),value = 30),
                                   selectInput("sex", "Gender", unique(Salaries$sex)),
                                   radioButtons("PredictionMethod", "Prediction Method :", c("Linear regression", "Decision Tree", "Random Forest"),"Linear regression"),
                                   submitButton("Apply Selection")
                      ),
					  
                      # Show Salary Estimation, Plots and Dataset
                      mainPanel(width = 9,tabsetPanel(
                        tabPanel("Salary Estimation & Plots", 
                                 tableOutput("EstimatedSalary"),
                                 plotOutput("Plots"),
                                 tableOutput("EnteredCase")),
                        tabPanel("Salaries Dataset", dataTableOutput("SalariesTable"))
                      ))),
             tabPanel("About This Panel",
                      mainPanel(
                        includeHTML("AboutApplication.html"))),
             tabPanel("About Salaries Dataset",
                      mainPanel(
                        includeHTML("AboutData.html")))
  )
))


						