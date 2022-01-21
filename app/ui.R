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
  h1("Endangered Languages of the World"),
  tabsetPanel(
    type = 'tabs',
    tabPanel(
      'Language Map',
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
        column(
          4,
          numericInput("min_speakers",
                       "Minimum number of speakers:",
                       value = NULL)
        ),
        column(
          4,
          numericInput("max_speakers",
                       "Maximum number of speakers:",
                       value = NULL)
        )
      ),
      fluidRow(column(8,
                      textOutput('PopNumber'),
                      leafletOutput('WorldMap')),
               column(4,
                      plotlyOutput("BarPlot")))
    )
    
    ,
    tabPanel(
      'Vitality Correlator',
      selectInput(
        "country_variable",
        "Country variable:",
        choices = c('CO2 Emissions' = 'co2_emissions_percapita_metric_tons', 
                    'Expenditure on Education as GDP Percentage' = 'expenditure_on_education_percentage_GDP', 
                    'Expenditure on Helath as GDP Percentage' = 'expenditure_on_health_percentage_of_GDP',
                    'Expenditure on Research and Development as GDP Percentage' = 'expenditure_on_research_and_development_GDP_percentage', 
                    'Expenditure on Secondary Education' = 'expenditure_on_secondary_education', 
                    'GDP Per Capita in US Dolars' = 'GDP_per_capita_US_dollars', 
                    'Land Area in Thousand Hectars' = 'land_area_thousand_hectars', 
                    'Mid-year population (millions)' = 'population_mid_year_estimates_millions', 
                    'Percentage of People Using Internet' = 'internet_usage_percentage_of_people', 
                    'The Number of International Migrants' = 'international_migrants_number', 
                    'Threatened Species Total Number' = 'threatened_species_total_number', 
                    'Tourist arrivals (Thousands)' = 'tourist_arrivals_thousands')), 
        plotlyOutput('ScatterPlot')
        
      )
    )
  )
)
