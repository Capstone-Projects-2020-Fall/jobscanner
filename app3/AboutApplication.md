---
output: 
  html_document: 
    keep_md: yes
---



## About This shiny Application

This shiny application was designed as a semi-panel to illustrate the job scanner matching function by Job scanner Team.


## What do this shiny application do ?

In this application I picked a dataset about scholar salary (See "About Salary Dataset" tab for detailed info).<br />

According to that dataset we will try to predict the salary of a scholar with a given criteria, since many of us will go to grad school somehow (Kevin in our team will!) (rank,discipline,yrs.since.phd,yrs.service and sex) which YOU will input in the shiny input gadgets (to the left of the shiny page).<br />

By selecting desired machine learning algorithm: Linear regression, Decision Tree or Random Forest, we will estimate the fair salary for a Professor with such criteria.



```r
# cross validation with 5 folds to return RMSE for each method (Higher RMSE is higher error)
MytrControl<-trainControl(method = "cv", number = 5,verboseIter = TRUE)

#Select Algoeithm according to you selection
if(input$PredictionMethod=="Linear regression"){
      fit<-train(salary~.,data = Salaries,method="lm",trControl=MytrControl)
}
else if(input$PredictionMethod=="Decision Tree"){
      fit<-train(salary~.,data = Salaries,method="rpart",trControl=MytrControl)
}
else if(input$PredictionMethod=="Random Forest"){
      fit<-train(salary~.,data = Salaries,method="rf",trControl=MytrControl)
}

#Now to predict using the (fit) model on the (entry) data
predict(fit,entry)
```

After this we will show our estimated salary as a red point on plots of salary against all other variables to show OUR Professor within the other observations in Professors Salaries dataset. 
