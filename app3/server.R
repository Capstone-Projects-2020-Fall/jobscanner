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
  
  
  output$Plots<- renderPlot({
    
    SalaryEstimation<-PredictSalaryLM()[1]
    
    #generating plots
    g<-ggplot(Salaries)
    plotRank<-g+geom_point(aes(x=salary,y=rank),alpha=0.5)+
              geom_point(aes(x=SalaryEstimation[1],y=input$Rank),fill="red",shape=23,size=5)+
              geom_hline(yintercept = ifelse(input$Rank=="Prof",3,ifelse(input$Rank=="AsstProf",2,1)),color="red")+
              geom_vline(xintercept=SalaryEstimation[1],color="red")+
              theme(axis.text.y = element_text(angle = 90, hjust = 1))+
              ggtitle("Salary v.s. Rank")+
              theme(plot.title = element_text(hjust = 0.5,lineheight=.8, face="bold"))
    
    plotDiscipline<-g+geom_point(aes(x=salary,y=discipline),alpha=0.5)+
              geom_point(aes(x=SalaryEstimation[1],y=input$Discipline),fill="red",shape=23,size=5)+
              geom_hline(yintercept = ifelse(input$Rank=="B",1,2),color="red")+
              geom_vline(xintercept=SalaryEstimation[1],color="red")+
              theme(axis.text.y = element_text(angle = 90, hjust = 1))+
              ggtitle("Salary v.s. Discipline")+
              theme(plot.title = element_text(hjust = 0.5,lineheight=.8, face="bold"))
    
    plotSincePhd<-g+geom_point(aes(x=salary,y=yrs.since.phd),alpha=0.5)+
              geom_point(aes(x=SalaryEstimation[1],y=input$yrs.since.phd),fill="red",shape=23,size=5)+
              geom_hline(yintercept = input$yrs.since.phd,color="red")+
              geom_vline(xintercept=SalaryEstimation[1],color="red")+
              ggtitle("Salary v.s. Years Since PhD")+
              theme(plot.title = element_text(hjust = 0.5,lineheight=.8, face="bold"))
      
    plotSinceService<-g+geom_point(aes(x=salary,y=yrs.service),alpha=0.5)+
              geom_point(aes(x=SalaryEstimation[1],y=input$yrs.service),fill="red",shape=23,size=5)+
              geom_hline(yintercept = input$yrs.service,color="red")+
              geom_vline(xintercept=SalaryEstimation[1],color="red")+
              ggtitle("Salary v.s. Years Since Service")+
              theme(plot.title = element_text(hjust = 0.5,lineheight=.8, face="bold"))
    
    plotSex<-g+geom_point(aes(x=salary,y=sex),alpha=0.5)+
              geom_point(aes(x=SalaryEstimation[1],y=input$sex),fill="red",shape=23,size=5)+
              geom_hline(yintercept = ifelse(input$sex=="Female",1,2),color="red")+
              geom_vline(xintercept=SalaryEstimation[1],color="red")+
              theme(axis.text.y = element_text(angle = 90, hjust = 1))+
              ggtitle("Salary v.s. Gender")+
              theme(plot.title = element_text(hjust = 0.5,lineheight=.8, face="bold"))
    
    grid.arrange(plotRank,plotDiscipline,plotSincePhd,plotSinceService,plotSex,nrow=1,ncol=5)
  })
  
  output$EstimatedSalary<- renderTable({
    list("Prediction Method"=input$PredictionMethod,"Estimated Salary"=PredictSalaryLM()[1], "RMSE/std dev"= MethodSelection()$results[1,2])
  })
  
  output$EnteredCase<- renderTable({
    DataEntryCase()
  })
  
  output$SalariesTable<- renderDataTable({
    Salaries
  })
  
  
  
})
