library(maps)
library(tidyverse)
library(sf)
library(leaflet)
library(htmltools)
library(shiny)
library(plotly)
library(scales)
UN_UNESCO <- read_csv('UN_UNESCO.csv')
UN_UNESCO <- UN_UNESCO %>%
  mutate(endangerment_degree = factor(endangerment_degree, 
                                      levels = c("Vulnerable",
                                                 "Definitely endangered",
                                                 "Severely endangered", 
                                                 "Critically endangered",
                                                 "Extinct")))

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
            'Tourist arrivals (Thousands)' = 'tourist_arrivals_thousands')



min_speakers <- min(UN_UNESCO$number_of_speakers, na.rm = T)
max_speakers <- max(UN_UNESCO$number_of_speakers, na.rm = T)

