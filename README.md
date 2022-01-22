# Project Title

Endangered Languages of the World


## Description


A Shiny app on RStudio that shows the distribution of endangered languages in the world and shows how countries' economic variables may be correlated with the ratio of endangered languages in each country. 

The main dataset (UNESCO) is downloaded from Kaggle, posted by the Guardian. You can find the dataset here:https://www.kaggle.com/the-guardian/extinct-languages

Further updates of the data are not available publically. It includes 14 variables (i.e. columns) in total: the name of language, longitude, latitude, degree of endangerment (vulnerable, definitely vulnerable, severely vulnerable, critically endangered, or extinct), and the number of speakers. 

Several datasets (UN) were downloaded from the UN website: https://data.un.org/. The datasets are listed on the website as:
International migrants and refugees, GDP and GDP per capita, Education at the primary, secondary and tertiary levels,  Public expenditure on education, Health expenditure, Gross domestic expenditure on R & D, Land, CO2 emissions estimates, Threatened species, Internet usage, and Tourist/visitor arrivals and tourism expenditure.  


A third part of the data comes from Ethnologue: https://www.ethnologue.com/browse/countries
Ethnologue provides a list of the countries and the languages spoken in each. The counts of the languages per country were put into a dataset. 

The three sources of data were merged to make my dataset (UN_UNESCO.csv)

## Getting Started

### Dependencies

* In order to run the app, RStudio needs to be installed :
https://www.rstudio.com/products/rstudio/

* In addition, R needs to be installed:
https://www.r-project.org/


### Installing

* The interactive app is available at: https://nedatahe.shinyapps.io/endangered-languages-of-the-world/

* The app and the data used are also available on this github repository:

https://github.com/nedatahe/endangered-languages


### Executing program

These steps are required to run the app:
* Run the global.R file on RStudio,
* Run the server.R file on RStudio, 
* Run the ui.R file on Rstudio, 
* On the Files tab on the app, from the Setting gear, set the Working Directory as where you have downloaded the app into your computer. 


## Author

Neda Taherkhani
Email: neda.tahe&gmail.com
LinKedin: https://www.linkedin.com/in/nedata/ 

## Acknowledgments

Acknowledgements go to the instructor of the Data Science (5) bootcamp at Nashville Software School, Michael Halloway, and the TAs of the bootcamp, Veronica Ikeshoji-Orlati and Alvin Wendt. I also appreciate the role of Bryan Finlayson in helping me build and debug the app. 
