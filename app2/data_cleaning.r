library(dplyr)
library(ggplot2)
library(tidyverse)
source('helper.R')

review = read.csv("employee_reviews.csv", stringsAsFactors = FALSE)
# this seperate job.title column in to several column since there is many information contained in this column.
review1 = separate(review, job.title, c('employee.status', 'position'), sep = '-')
head(review1)

# this create boolean for if the response is from anonymous employee or not
review2 = 
  review1 %>% 
    mutate(., position = trimws(position, which = c('both'))) %>% 
    mutate(is.anonymous = ifelse(position == "Anonymous Employee", TRUE, FALSE))

# this change the dates column to dates formate
review3 = review2 %>% 
    mutate(., dates = trimws(dates, which = c('both'))) %>% 
    mutate(dates = as.Date(as.character(dates), '%b %d, %Y')) %>% 
    mutate(year = as.numeric(format(dates,'%Y'))) %>% 
    mutate(month = as.character(format(dates, '%b')))

# this write cleaned dataframe into csv file
write.csv(review3, file='review_data.csv', row.names=F)


