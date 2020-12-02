#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
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


# Define server logic required to estimate Professor Salary based on variables input
shinyServer(function(input, output) {
  
  MethodSelection<-reactive({
    #fit<-lm(salary~.,data = Salaries)
    MytrControl<-trainControl(method = "cv", number = 3,verboseIter = TRUE)
    
    if(input$PredictionMethod=="Linear regression"){
      fit<-train(salary~.,data = Salaries,method="lm",trControl=MytrControl)
    }
    else if(input$PredictionMethod=="Decision Tree"){
      fit<-train(salary~.,data = Salaries,method="rpart",trControl=MytrControl)
    }
    else if(input$PredictionMethod=="Random Forest"){
      fit<-train(salary~.,data = Salaries,method="rf",trControl=MytrControl)
    }
    fit
  })
  
  DataEntryCase<-reactive({
    case<-Salaries[1,]
    case$rank<-input$Rank
    case$discipline<-input$Discipline
    case$yrs.since.phd<-input$yrs.since.phd
    case$yrs.service<-input$yrs.service
    case$sex<-input$sex
    case$salary<-predict(MethodSelection(),case)[1]
    case
  })
  
  PredictSalaryLM<-reactive({
    predict(MethodSelection(),DataEntryCase())
  })
  
  