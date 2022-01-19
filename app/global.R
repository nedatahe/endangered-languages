library(maps)
library(tidyverse)
library(sf)
library(leaflet)
library(htmltools)
library(shiny)
library(plotly)

UN_UNESCO <- read_csv('UN_UNESCO.csv')





min_speakers <- min(UN_UNESCO$number_of_speakers, na.rm = T)
max_speakers <- max(UN_UNESCO$number_of_speakers, na.rm = T)

