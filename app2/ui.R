
  

shinyUI(dashboardPage(skin = "blue",
  
  dashboardHeader(title = "IT Big Employer Reviews", titleWidth = 350),

  dashboardSidebar(
    width = 350,
    sidebarMenu(
      sidebarMenu(
        menuItem("General_Review", tabName = "General_Review", icon = icon("file-export")),
        menuItem("Mapping the data", tabName = 'map', icon = icon('map')),
        menuItem("Rating_Review", tabName = "Selection", icon = icon("bar-chart-o")),
        hr(),
        menuItem("Wordcloud", tabName = "wordcloud", icon = icon("cloud-download-alt")),
        selectizeInput(inputId = "c_select", label = "Choose a company",choices = companies),
        actionButton("update", "Change"),
        sliderInput(inputId = "freq", "Minimum Frequency:",min = 30, max = 500, value = 260),
        sliderInput(inputId = "max", label = "Maximum Number of Words:",min = 1, max = 1000, value = 500)
      ),
      
      hr(),
      
      
      
      sidebarMenu(
        menuItem("Job Scanner Team: this dataset are from glassdoor scraping data,same source as our applicant panel data.")
      )
      
      
    )
  ),
hundredSlider(
  width = 350,
  sidebarMenu(
    sidebarMenu(
      menuItem("General_Review", tabName = "General_Review", icon = icon("file-export")),
      menuItem("Mapping the data", tabName = 'map', icon = icon('map')),
      menuItem("Rating_Review", tabName = "Selection", icon = icon("bar-chart-o")),
      hr(),
      menuItem("Wordcloud", tabName = "wordcloud", icon = icon("cloud-download-alt")),
      selectizeInput(inputId = "c_select", label = "Choose a company",choices = companies),
      actionButton("update", "Change"),
      sliderInput(inputId = "freq", "Minimum Frequency:",min = 30, max = 500, value = 260),
      sliderInput(inputId = "max", label = "Maximum Number of Words:",min = 1, max = 1000, value = 500)
    ),
ata %>%
mutate(work.balance.stars = as.numeric(work.balance.stars),
       culture.values.stars = as.numeric(culture.values.stars),
       carrer.opportunities.stars = as.numeric(carrer.opportunities.stars),
       comp.benefit.stars = as.numeric(comp.benefit.stars),
       senior.mangemnet.stars = as.numeric(senior.mangemnet.stars)) %>%
filter(work.balance.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
filter(culture.values.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
filter(carrer.opportunities.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0))
map(work.balance.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
map(culture.values.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
filter(carrer.opportunities.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0))%>%
filter(comp.benefit.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
filter(senior.mangemnet.stars %in% c(0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)) %>%
select(one_of(choice))

    
    hr(),
    
    br(),
    

    hd(), 
    
    sidebarMenu(
      menuItem("Job Scanner Team: this dataset are from glassdoor scraping data,same source as our applicant panel data.")
    )
    
    
  )
),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "General_Review",
              fluidRow(infoBoxOutput("Anonymous_Response_Ratio"),
                       infoBoxOutput("Total_Response"),
                       infoBoxOutput("Top_Correlation")),
              fluidRow(
               # box(plotlyOutput("hist")),
                box(plotOutput('corr')),
                box(plotlyOutput('current_former')),
                box(
                  title = "Inputs", status = 'warning', solidHeader = TRUE,
                  checkboxGroupInput(inputId = "checkCompany",
                                     h3("company:"),
                                     choices = list('google'='google',
                                                    'amazon'= 'amazon',
                                                    'facebook' = 'facebook',
                                                    'netflix' = 'netflix',
                                                    'apple' = 'apple',
                                                    'microsoft' = 'microsoft'),
                                     selected = c('google', 'amazon')),
                  
                  checkboxInput(inputId = "checkAnonymous",
                                'Anonymous Response',
                                value = FALSE)
                )
              )
      ),
      
      tabItem(tabName = 'map',
              fluidRow(
                box(htmlOutput('us_map')),
                box(htmlOutput('world_map')),
                box(
                  title = "Inputs", status = 'warning', solidHeader = TRUE,
                  checkboxGroupInput(inputId = "checkCompany1",
                                     h3("company:"),
                                     choices = list('google'='google',
                                                    'amazon'= 'amazon',
                                                    'facebook' = 'facebook',
                                                    'netflix' = 'netflix',
                                                    'apple' = 'apple',
                                                    'microsoft' = 'microsoft'),
                                     selected = c('google', 'amazon','facebook','netflix','apple','microsoft'))
                  
                )
              )

      ),
      
      tabItem(tabName = "Selection",
              fluidRow(
                box(plotlyOutput("boxplot")),
                box(plotlyOutput('time_rating')),
                #box(plotlyOutput('avg_rating')),
                box(
                  title = "Inputs", status = 'warning', solidHeader = TRUE,
                  selectInput(inputId = "Selection", 
                              label = "Select item to Display", 
                              choices = choice)
                )
              )       
      ),
      
      tabItem(tabName = "wordcloud",
              fluidRow(
                box(plotOutput("wcplot_sum")),
                box(plotOutput('wcplot_pro')),
                box(plotOutput('wcplot_con')),
                box(plotOutput('wcplot_advice'))
              )
      )
    )
  )
)
)

