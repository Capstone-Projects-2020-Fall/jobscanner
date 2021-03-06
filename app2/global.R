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

//need to add new cors
getBroken_Matrix = memoise(function(comp){

  advice.to.mgmt = data %>% select(company,advice.to.mgmt) %>% filter(advice.to.mgmt != 'none', company == comp)
  corpus_advice = Corpus(VectorSource(advice.to.mgmt$advice.to.mgmt))
  corpus_advice = tm_map(corpus_advice, content_transformer(tolower))
  corpus_advice = tm_map(corpus_advice, removeNumbers)
  corpus_advice = tm_map(corpus_advice, removeWords ,stopwords('english'))
  corpus_advice = tm_map(corpus_advice, removePunctuation)
  corpus_advice = tm_map(corpus_advice, stripWhitespace)
  corpus_advice = tm_map(corpus_advice, removeWords,c("get","told","gave","took","can", "could"))
  tdm_advice = TermDocumentMatrix(corpus_advice, control = list(minWordLength = 1))
  tdm_advice = removeSparseTerms(tdm_advice, 0.9)
  m_advice = as.matrix(tdm_advice)
  filter(rowSums(m_advice), decreasing = False)
})


shinyServer(
  
  function(input,output, session){
    
    r_time_rating <- reactive(
      data %>%
        mutate(work.balance.stars = as.numeric(work.balance.stars),
               culture.values.stars = as.numeric(culture.values.stars),
               carrer.opportunities.stars = as.numeric(carrer.opportunities.stars),
               comp.benefit.stars = as.numeric(comp.benefit.stars),
               senior.mangemnet.stars = as.numeric(senior.mangemnet.stars)) %>%
        filter(work.balance.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
        filter(culture.values.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
        filter(carrer.opportunities.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
        filter(comp.benefit.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
        filter(senior.mangemnet.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0))
    )
    wc_data_sum = reactive({
      input$update
      isolate({
        withProgress({
          setProgress(message = "Processing corpus....
                      ")
          getTermMatrix_sum(input$c_select)
        })
      })
    })
    
    wc_data_pro = reactive({
      input$update
      
      isolate({
        withProgress({
          setProgress(message = "Processing corpus....
                      ")
          getTermMatrix_pro(input$c_select)
        })
      })
    })
    wc_data_con = reactive({
      input$update
      isolate({
        withProgress({
          setProgress(message = "Processing corpus...")
          getTermMatrix_con(input$c_select)
        })
      })
    })

    wc_data_advice = reactive({
      input$update
      isolate({
        withProgress({
          setProgress(message = "Processing corpus...")
          getTermMatrix_advice(input$c_select)
        })
      })
    })
    
    # Make the wordcloud drawing predictable during a session
        wordcloud_rep = repeatable(wordcloud)
        
        output$wcplot_sum = renderPlot({

          v1 = wc_data_sum()
          wordcloud_rep(names(v1), v1, rot.per = 0.3,
                        min.freq = input$freq,
                        max.words = input$max,
                        colors = brewer.pal(8,"Dark2"))
          title(main="Word Cloud - Column Summary")
        })
        
        output$wcplot_pro = renderPlot({
          v2 = wc_data_pro()
          wordcloud_rep(names(v2), v2, rot.per = 0.3,
                        min.freq = input$freq, max.words = input$max,
                        colors = brewer.pal(8,"Dark2"),
                        main = "Title")
          title(main="Word Cloud - Column Pros")
        })
        
        output$wcplot_con = renderPlot({
          v3 = wc_data_con()
          wordcloud_rep(names(v3), v3, rot.per = 0.3,
                        min.freq = input$freq, max.words = input$max,
                        colors = brewer.pal(8,"Dark2"))
          title(main="Word Cloud - Column Cons")
        })

        output$wcplot_advice = renderPlot({
          v4 = wc_data_advice()
          wordcloud_rep(names(v4), v4, rot.per = 0.3,
                        min.freq = input$freq, max.words = input$max,
                        colors = brewer.pal(8,"Dark2"))
          title(main="Word Cloud - Column Advice to Management")
        })
        
    # geo map us plot
        output$us_map <- renderGvis({
          data_map %>% filter(country_code == 'US', company %in% input$checkCompany1) %>%
            group_by(state) %>%
            summarise(number_review = n()) %>%
            gvisGeoChart(., 'state', 'number_review',
                       options=list(region="US",
                                    displayMode="regions",
                                    resolution="provinces",
                                    width="auto", height="auto"))
        })
        
    # geo map world
        output$world_map <- renderGvis({
          data_map %>%
            filter(company %in% input$checkCompany1) %>%
            group_by(country_code) %>%
            summarise(number_review = n()) %>%
            gvisGeoChart(., 'country_code', 'number_review')
        })
        
        output$current_former <- renderPlotly(
          data %>%
            filter(is.anonymous == input$checkAnonymous) %>%
            group_by(company, employee.status) %>%
            summarise(n = n()) %>%
            mutate(ratio = n/sum(n)) %>%
            filter(company %in%  input$checkCompany) %>%
            ungroup(company) %>%
            ggplot(., aes(x = employee.status, y = ratio, group = company)) +
            geom_col(position = 'dodge', aes(fill = company)) +
            labs(title = "Ratio comparsion between current and former employee",
                 x = '',
                 y = 'Ratio')+
            theme_bw()+
            theme(legend.key = element_blank())
        )
        output$time_rating <- renderPlotly(
          r_time_rating() %>%
            group_by(year, company) %>%
            summarise(avg = mean(get(input$Selection))) %>%
            ungroup(company) %>%
            ggplot(., aes(x = year, y = avg)) +
            geom_line(aes(color = company), size = 2) +
            labs(title = "Averge rating over time",
                 x = 'Year',
                 y = 'Average Rating') +
            theme_bw()
        )
        
        output$avg_rating <- renderPlotly(
          r_time_rating() %>%
            group_by(company) %>%
            summarise(avg = mean(get(input$Selection))) %>%
            ungroup(company) %>%
            ggplot(., aes(x = reorder(company, + avg), avg)) +
            geom_bar(stat = 'identity', colour = 'black', aes(fill = company))+
            coord_flip()+
            geom_text(aes(label = round(avg,2), y = avg/2), size = 4.5) +
            labs(title = "Overall Rating Comparison",
                 x = 'Average Score',
                 y = 'Company') +
            theme_bw()
        )

summary = data %>% select(company,summary) %>% filter(company == comp)
corpus_sum = Corpus(VectorSource(summary$summary))
corpus_sum = tm_map(corpus_sum, content_transformer(tolower))
corpus_sum = tm_map(corpus_sum, removeNumbers)
corpus_sum = tm_map(corpus_sum, removeWords ,stopwords('english'))
corpus_sum = tm_map(corpus_sum, removePunctuation)
corpus_sum = tm_map(corpus_sum, stripWhitespace)
corpus_sum = tm_map(corpus_sum, removeWords,c("get","told","gave","took","can", "could"))
tdm_sum= TermDocumentMatrix(corpus_sum,control = list(minWordLength = 1))
tdm_sum = removeSparseTerms(tdm_sum, 0.9)
m_sum= as.matrix(tdm_sum)
sort(rowSums(m_sum), decreasing = TRUE)
})

# eliminate extra white spaces - 
corpus_google_summary =
  tm_map(corpus_google_summary, stripWhitespace)
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
	
# wordcloud:
getTermMatrix_sum = memoise(function(comp){

  summary = data %>% select(company,summary) %>% filter(company == comp)
  corpus_sum = Corpus(VectorSource(summary$summary))
  corpus_sum = tm_map(corpus_sum, content_transformer(tolower))
  corpus_sum = tm_map(corpus_sum, removeNumbers)
  corpus_sum = tm_map(corpus_sum, removeWords ,stopwords('english'))
  corpus_sum = tm_map(corpus_sum, removePunctuation)
  corpus_sum = tm_map(corpus_sum, stripWhitespace)
  corpus_sum = tm_map(corpus_sum, removeWords,c("get","told","gave","took","can", "could"))
  tdm_sum= TermDocumentMatrix(corpus_sum,control = list(minWordLength = 1))
  tdm_sum = removeSparseTerms(tdm_sum, 0.9)
  m_sum= as.matrix(tdm_sum)
  sort(rowSums(m_sum), decreasing = TRUE)
})

getTermMatrix_pro = memoise(function(comp){
  
  pro = data %>% select(company,pros) %>% filter(company == comp)
  corpus_pro = Corpus(VectorSource(pro$pros))
  corpus_pro = tm_map(corpus_pro, content_transformer(tolower))
  corpus_pro = tm_map(corpus_pro, removeNumbers)
  corpus_pro = tm_map(corpus_pro, removeWords ,stopwords('english'))
  corpus_pro = tm_map(corpus_pro, removePunctuation)
  corpus_pro = tm_map(corpus_pro, stripWhitespace)
  corpus_pro = tm_map(corpus_pro, removeWords,c("get","told","gave","took","can", "could"))
  tdm_pro = TermDocumentMatrix(corpus_pro,control = list(minWordLength = 1))
  tdm_pro = removeSparseTerms(tdm_pro, 0.9)
  m_pro = as.matrix(tdm_pro)
  sort(rowSums(m_pro), decreasing = TRUE)
})

getTermMatrix_con = memoise(function(comp){

  con = data %>% select(company,cons) %>% filter(company == comp)
  corpus_con = Corpus(VectorSource(con$cons))
  corpus_con = tm_map(corpus_con, content_transformer(tolower))
  corpus_con = tm_map(corpus_con, removeNumbers)
  corpus_con = tm_map(corpus_con, removeWords ,stopwords('english'))
  corpus_con = tm_map(corpus_con, removePunctuation)
  corpus_con = tm_map(corpus_con, stripWhitespace)
  corpus_con = tm_map(corpus_con, removeWords,c("get","told","gave","took","can", "could"))
  tdm_con = TermDocumentMatrix(corpus_con,control = list(minWordLength = 1))
  tdm_con = removeSparseTerms(tdm_con, 0.9)
  m_con = as.matrix(tdm_con)
  sort(rowSums(m_con), decreasing = TRUE)
})

getTermMatrix_advice = memoise(function(comp){

  advice.to.mgmt = data %>% select(company,advice.to.mgmt) %>% filter(advice.to.mgmt != 'none', company == comp)
  corpus_advice = Corpus(VectorSource(advice.to.mgmt$advice.to.mgmt))
  corpus_advice = tm_map(corpus_advice, content_transformer(tolower))
  corpus_advice = tm_map(corpus_advice, removeNumbers)
  corpus_advice = tm_map(corpus_advice, removeWords ,stopwords('english'))
  corpus_advice = tm_map(corpus_advice, removePunctuation)
  corpus_advice = tm_map(corpus_advice, stripWhitespace)
  corpus_advice = tm_map(corpus_advice, removeWords,c("get","told","gave","took","can", "could"))
  tdm_advice = TermDocumentMatrix(corpus_advice, control = list(minWordLength = 1))
  tdm_advice = removeSparseTerms(tdm_advice, 0.9)
  m_advice = as.matrix(tdm_advice)
  sort(rowSums(m_advice), decreasing = TRUE)
})


summary = data %>% select(company,summary) %>% filter(company == comp)
corpus_sum = Corpus(VectorSource(summary$summary))
corpus_sum = tm_map(corpus_sum, content_transformer(tolower))
corpus_sum = tm_map(corpus_sum, removeNumbers)
corpus_sum = tm_map(corpus_sum, removeWords ,stopwords('english'))
corpus_sum = tm_map(corpus_sum, removePunctuation)
corpus_sum = tm_map(corpus_sum, stripWhitespace)
corpus_sum = tm_map(corpus_sum, removeWords,c("get","told","gave","took","can", "could"))
tdm_sum= TermDocumentMatrix(corpus_sum,control = list(minWordLength = 1))
tdm_sum = removeSparseTerms(tdm_sum, 0.9)
m_sum= as.matrix(tdm_sum)
sort(rowSums(m_sum), decreasing = TRUE)
})

