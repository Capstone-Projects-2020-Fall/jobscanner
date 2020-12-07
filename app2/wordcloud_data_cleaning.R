library(tm)
library(wordcloud)
library(dplyr)

data = read.csv("review_data.csv", header = TRUE)

google_summary = 
  data %>% 
    select(company,summary) %>% 
    filter(company == "google")

corpus_google_summary =
  Corpus(VectorSource(google_summary$summary))

