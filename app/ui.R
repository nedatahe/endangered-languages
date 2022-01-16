#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  h1("Endangered Languages of the World"),
  
  fluidRow(
    column(4,
           selectInput(
             'country',
             'Country of origin:',
             choices = c('All', UN_UNESCO %>%
                           pull(Country) %>%
                           unique() %>%
                           sort())
           )),
    column(4,
           
           selectInput(
             'language',
             'Endangered language:',
             choices = c('All', UN_UNESCO %>%
                           pull(english_name) %>%
                           unique() %>%
                           sort())
           )),
    column(4,
           
           selectInput(
             'iso',
             'ISO code of the language:',
             choices = c(
               'All',
               UN_UNESCO %>%
                 pull(`ISO639-3_codes`) %>%
                 unique() %>%
                 sort()
             )
           ))
  ),
  
  fluidRow(
    column(
      4,
      selectInput(
        'endangerment',
        'Degree of endangerment:',
        choices = c(
          'All' = 'All',
          'Vulnerable' = 'Vulnerable',
          'Definitely endangered' = 'Definitely endangered',
          'Severely endangered' = 'Severely endangered',
          'Critically endangered' = 'Critically endangered',
          'Extinct' = 'Extinct'
          
        ),
        multiple = TRUE
      )
    ),
    column(4,
           numericInput(
             "min_speakers",
             "Minimum number of speakers:",
             value = NULL
           )),
    column(4,
           numericInput(
             "max_speakers",
             "Maximum number of speakers:",
             value = NULL
           ))),
    fluidRow(column(8,
                    leafletOutput('WorldMap')),
             column(
               4,
               plotOutput("PercentageBarPlot"),
               plotOutput('NumberBarPlot')
             ))
  )
)
