library(shinydashboard)
library(shinythemes)
library(ggplot2)
library(dplyr)
library(tm)
library(wordcloud)
library(memoise)
library(corrplot)
library(stringr)


#read data set
data = read.csv('review_data.csv',stringsAsFactors=FALSE)

#input option:
choice = c('overall.ratings', 
           'work.balance.stars',
           'culture.values.stars',
           'carrer.opportunities.stars',
           'comp.benefit.stars',
           'senior.mangemnet.stars')

companies = c('google','amazon','facebook','netflix','apple','microsoft')