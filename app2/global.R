library(shinydashboard)
library(shinythemes)
library(ggplot2)
library(dplyr)
library(tm)
library(wordcloud)
library(memoise)



#read data set
data = read.csv('review_data.csv',stringsAsFactors=FALSE)

