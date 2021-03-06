
  

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
      
r
      
      sidebarMenu(
        menuItem("Job Scanner Team: this dataset are from glassdoor scraping data,same source as our applicant panel data.")
      )
      
      
    )
  ),


    
    hr(),
    
    br(),
    

    hd(), 
    
    sidebarMenu(
      menuItem("Job Scanner Team: this dataset are from glassdoor scraping data,same source as our applicant panel data.")
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

rigidTab(tabName = "wordcloud",
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

