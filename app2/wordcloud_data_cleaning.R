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

corpus_google_summary[[1]][1]

# Text Cleaning

#convert the text to lower case
corpus_google_summary = 
  tm_map(corpus_google_summary, content_transformer(tolower))
#remove numbers
corpus_google_summary = 
  tm_map(corpus_google_summary, removeNumbers)
#remove english commom stopwords
corpus_google_summary = 
  tm_map(corpus_google_summary, removeWords,stopwords("english"))
# remove punctuations
corpus_google_summary = 
  tm_map(corpus_google_summary, removePunctuation)
# eliminate extra white spaces
corpus_google_summary = 
  tm_map(corpus_google_summary, stripWhitespace)
#Stemming Texts
#corpus_google_summary = 
#  tm_map(corpus_google_summary, stemDocument)

