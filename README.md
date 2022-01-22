# Project Title

Endangered Languages of the World

## Description

A Shiny app on RStudio that shows the distribution of endangered languages in the world and shows how countries' economic variables may be correlated with the ratio of endangered languages in each country. 

The main dataset (UNESCO) is downloaded from Kaggle, posted by the Guardian. You can find the dataset here:https://www.kaggle.com/the-guardian/extinct-languages

Further updates of the data are not available publically. It includes 14 variables (i.e. columns) in total: the name of language, longitude, latitude, degree of endangerment (vulnerable, definitely vulnerable, severely vulnerable, critically endangered, or extinct), and the number of speakers. 

Several datasets (UN) were downloaded from the UN website: https://data.un.org/

A third part of the data comes from Ethnologue: https://www.ethnologue.com/browse/countries
They provide a list of the countries and the languages spoken in each. The counts of the languages per country were put into a dataset. 

The three sources of data were merged to make my dataset (UN_UNESCO.csv)

## Getting Started

### Dependencies

* In order to run teh app, RStudio needs to be installed at:
https://www.rstudio.com/products/rstudio/


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

## Help

The Help tab on RStudio is a great place to look up the commands and functionality of the code. 
```

## Author



Neda Taherkhani
Email: neda.tahe&gmail.com
Github: https://github.com/nedatahe
LinKedin: https://www.linkedin.com/in/nedata/ 



## Acknowledgments

Acknowledgements go to the instructor of the Data Science 5 bootcamp at Nashville Software School, Michael Halloway, and the TAs of the bootcamp, Veronica Ikeshoji-Orlati and Alvin Wendt. I also appreciate the role of Bryan Finlayson in helping me build and debug the app. 
