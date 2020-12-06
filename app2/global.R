library(shinydashboard)
library(shinythemes)
library(ggplot2)
library(dplyr)
library(tm)
library(wordcloud)
library(memoise)
library(corrplot)
library(stringr)
library(countrycode)
library(DT)
library(googleVis)
library(plotly)


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
# data set for corr plot

corr_p = data %>%
  mutate(work.balance.stars = as.numeric(work.balance.stars),
         culture.values.stars = as.numeric(culture.values.stars),
         carrer.opportunities.stars = as.numeric(carrer.opportunities.stars),
         comp.benefit.stars = as.numeric(comp.benefit.stars),
         senior.mangemnet.stars = as.numeric(senior.mangemnet.stars)) %>%
  filter(work.balance.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
  filter(culture.values.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
  filter(carrer.opportunities.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
  filter(comp.benefit.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
  filter(senior.mangemnet.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>% 
  select(one_of(choice))

colnames(corr_p) <- c('overall','work.balance','culture.values',
                      'carrer.oppo','comp.benefit','senior.mange')

# cleaned a data set for mapping:
data_map = 
  data %>% 
    filter(., location != 'none') %>% 
    mutate(country = ifelse(str_detect(location, regex("\\)")) == FALSE, 
                            'United States of America', 
                            gsub(".*[(]([^.]+)[)].*","\\1",location))) %>% 
    mutate(country_code = countrycode(country,'country.name','iso2c')) %>% 
    mutate(city = ifelse(country_code=='US',gsub("([^.]+)[,].*",'\\1',location),NA)) %>% 
	mutate(state = ifelse(country_code == 'US', gsub(' ', '', paste('US-', gsub(".*[,]([^.]+).*", "\\1",location))), NA)) %>% 
    select(company,dates,country_code,city,state,choice)