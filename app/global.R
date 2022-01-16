library(maps)
library(tidyverse)
library(sf)
library(leaflet)
library(htmltools)
library(shiny)

UNESCO <- read_csv('../data/UNESCO-2011.csv')

UN <- read_csv('../data/UN.csv')

UN <- UN %>%
  filter(Year == 2010)

UNESCO <- UNESCO %>%
  mutate(Country = strsplit(Country, ",")) %>%
  unnest(Country)

GDP <-
  UN %>%
  filter(topic == 'GDP per capita (US dollars)' & Series == 'GDP per capita (US dollars)') %>%
  select(Country, country_GDP_per_capita_US_dollars = Value)

RD <-
  UN %>%
  filter(topic == 'domestic expenditure in RD' & Series == 'Gross domestic expenditure on R & D: as a percentage of GDP (%)') %>%
  select(Country, country_RD_exp_as_GDP_percentage = Value)

CO2 <-
  UN %>%
  filter(topic == 'CO2 emission' & Series == 'Emissions per capita (metric tons of carbon dioxide)')%>%
  select(Country, country_CO2_tons_per_capita = Value)

species <-
  UN %>%
  filter(topic == 'threatened species' & Series == 'Threatened Species: Total (number)')%>%
  select(Country, country_threatened_species_total_num = Value)

education <-
  UN %>%
  filter(topic == 'expenditure on edu' & Series == 'Public expenditure on education (% of GDP)')%>%
  select(Country, country_edu_exp_as_GDP_percentage = Value)

health <-
  UN %>%
  filter(topic == 'expenditure on health' & Series == 'Current health expenditure (% of GDP)')%>%
  select(Country, country_health_exp_as_GDP_percentage = Value)

internet <-
  UN %>%
  filter(topic == 'internet usage' & Series == 'Percentage of individuals using the internet')%>%
  select(Country, country_individuals_using_internet_percentage = Value)

land <-
  UN %>%
  filter(topic == 'land' & Series == 'Land area (thousand hectares)')%>%
  select(Country, country_land_area_thousand_hectars = Value)

migrants <-
  UN %>%
  filter(topic == 'migrants' & Series == 'International migrant stock: Both sexes (% total population)')%>%
  select(Country, country_international_migrants_population_percentage = Value)

tourism <-
  UN %>%
  filter(topic == 'tourism' & Series == 'Tourist/visitor arrivals (thousands)')%>%
  select(Country, country_tourists_thousand = Value)

population <-
  UN %>%
  filter(topic == 'population' & Series == 'Population mid-year estimates (millions)')%>%
  select(Country, country_population_millions = Value)

UN_combined <-
  full_join(GDP, RD) %>%
  full_join(CO2) %>%
  full_join(species) %>%
  full_join(education) %>%
  full_join(health) %>%
  full_join(internet) %>%
  full_join(land) %>%
  full_join(migrants) %>%
  full_join(tourism) %>%
  full_join(population)

UN_UNESCO <- right_join(UN_combined, UNESCO, on = 'Country')

write.csv(UN_UNESCO,'../data/UN_UNESCO.csv')

UN_UNESCO <-
  rename(UN_UNESCO, c('location_description' = 'Description of the location',
                      'english_name' = 'Name in English',
                      'french_name' = 'Name in French',
                      'spanish_name' = 'Name in Spanish',
                      'ISO639-3_codes' = 'ISO639-3 codes',
                      'endangerment_degree' = 'Degree of endangerment',
                      'alternate_names' = 'Alternate names',
                      'name_in_the_language' = 'Name in the language',
                      'number_of_speakers' = 'Number of speakers'))

g_languages <- read_csv('../data/glottolog_languages.csv')
g_areas <- read_csv('../data/glottolog_areas.csv')
g_families <- read_csv('../data/glottolog_families.csv')

glottolog <-
  full_join(g_languages, g_areas, by = 'english_name') %>%
  full_join(g_families, by = 'family_id')

glottolog <- select(glottolog, -'family_id')

UN_UNESCO <- left_join(UN_UNESCO, glottolog)

UN_UNESCO <- UN_UNESCO %>%
  mutate(endangerment_degree = factor(endangerment_degree, 
                                      levels = c("Vulnerable",
                                                 "Definitely endangered",
                                                 "Severely endangered", 
                                                 "Critically endangered",
                                                 "Extinct")))


critical <- UN_UNESCO %>% 
  filter(endangerment_degree == 'Critically endangered')
definite <- UN_UNESCO %>% 
  filter(endangerment_degree == 'Definitely endangered')
extinct <- UN_UNESCO %>% 
  filter(endangerment_degree == 'Extinct')
severe <- UN_UNESCO %>% 
  filter(endangerment_degree == 'Severely endangered')
vulnerable <- UN_UNESCO %>% 
  filter(endangerment_degree == 'Vulnerable')




UN_UNESCO <- 
  UN_UNESCO %>% 
  mutate(vitality_level = case_when(
    endangerment_degree == 'Extinct' ~ 1,
    endangerment_degree == 'Critically endangered' ~ 2,
    endangerment_degree == 'Severely endangered' ~ 3,
    endangerment_degree == 'Definitely endangered' ~ 4,
    endangerment_degree == 'Vulnerable' ~ 5))


pal <- colorFactor(palette = c('navajowhite2', 'yellow', 'orange', 'red', 'black'), 
                   levels = c("Vulnerable",
                              "Definitely endangered",
                              "Severely endangered", 
                              "Critically endangered",
                              "Extinct"))

popup <- paste("<b>English name:</b>", UN_UNESCO$english_name,"<br>",
               "<b>French name:</b>", UN_UNESCO$french_name,"<br>",
               "<b>Spanish name:</b>", UN_UNESCO$spanish_name, "<br>",
               
               "<b>ISO639-3 code:</b>", UN_UNESCO$`ISO639-3_codes`,"<br>",
               "<b>Alternate name:</b>", UN_UNESCO$alternate_names,"<br>",
               "<b>Endangerment degree:</b>", UN_UNESCO$endangerment_degree,"<br>",
               "<b>Number of speakers:</b>", UN_UNESCO$number_of_speakers,"<br>",
               "<b>Country:</b>", UN_UNESCO$Country,"<br>",
               
               "<b>Specific location(s):</b>",  UN_UNESCO$location_description,"<br>"
)

UN_UNESCO <- 
  UN_UNESCO %>% 
  group_by(Country) %>% 
  mutate(vitality_level_mean = mean(vitality_level, na.rm = T))


min_speakers <- min(UN_UNESCO$number_of_speakers, na.rm = T)
max_speakers <- max(UN_UNESCO$number_of_speakers, na.rm = T)

variables <- UN_UNESCO