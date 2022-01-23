## Project Title

Endangered Languages of the World
App address: https://lnkd.in/db9H4dW6 

## Description


A Shiny app on RStudio that shows the distribution of endangered languages in the world and shows how countries' economic variables may be correlated with the ratio of endangered languages in each country. 

The app has two tabs:
Tab one, Language Map, shows the distribution of the endangered languages in the world. Each dot on hte map represents an endangered language. The size of the dots is proportional to the number of their speakers. The level of the endangerment of the languages is distinguished based on their color: Khaki for Vulnerable languages, Yellow for Definitely Endangered ones, Orange for Severely Endangered languages, red for Critically Endangered ones, and black for Extinct languages. The vitality/endangerment degree of the languages has been mainly distinguished based on Intergenerational transmission, base on these definitions provided by unesco.org:

* Vulnerable: 	most children speak the language, but it may be restricted to certain domains (e.g., home)
* Definitely endangered: children no longer learn the language as mother tongue in the home
* Severely endangered: language is spoken by grandparents and older generations; while the parent generation may understand it, they do not speak it to children or among themselves
* Critically endangered: the youngest speakers are grandparents and older, and they speak the language partially and infrequently
* Extinct: there are no speakers left


The users can use the selection boxes to look up endangered languages based on their level of endangerment, country, name in English, ISO code, and minimum/maximum number of speakers. Each selection or combination of selections shows the number of the languages selected and the total number of speakers. The "Endangerment Degree" box makes is possible for the users to choose more than one level of endangerment. The interactivity of the tabs can be improved in future updates such that certain selections automatically interact with other tabs. The bar chart on the right side of the map is interactive with the choice of country at the present time. As the country is selceted, this bar chart updates such that it shows the endanger language composition of the country. 


The second tab of this app, "Vitality Correlator", shows the relationship between country's economic variable such as Expenditure on Secondary Education, with the ratio of endangered languages per country. While some of the variables did not show a strong correlation between the country variables and the endangerment ratio, some of them show a rather strong relationship: The countries with higher rate of expenditure on secondary educations are associated with higher rate of endangered languages in them. Among the highest is the US. However, caution needs to be taken interpreting these relationship such that correlation is not translated into causation. 


## Data
The main dataset (UNESCO) is downloaded from Kaggle, posted by the Guardian. You can find the dataset here:https://www.kaggle.com/the-guardian/extinct-languages

Further updates of the data are not available publically. It includes 14 variables (i.e. columns) in total: the name of language, longitude, latitude, degree of endangerment (vulnerable, definitely vulnerable, severely vulnerable, critically endangered, or extinct), and the number of speakers. 

Several datasets (UN) were downloaded from the UN website: https://data.un.org/. The datasets are listed on the website as:
International migrants and refugees, GDP and GDP per capita, Education at the primary, secondary and tertiary levels,  Public expenditure on education, Health expenditure, Gross domestic expenditure on R & D, Land, CO2 emissions estimates, Threatened species, Internet usage, and Tourist/visitor arrivals and tourism expenditure.  These datasets were filtered to the data in year 2011 or the nearest year so that the results are comparable with the language data that belongs to year 2011. 


A third part of the data comes from Ethnologue: https://www.ethnologue.com/browse/countries
Ethnologue provides a list of the countries and the languages spoken in each. The counts of the languages per country were put into a dataset. I applied several modifications to this dataset due to the the mismatches between the names of the countries in this dataset and my original language dataset. One drawback of using this dataset is that the data is updated; so the number of total languages in each country reflects their current status. Plus, depending on the definition of "language" these numbers can be misleading. Still, I used the data for my app, as the dataset served my purposes of learning!

The three sources of data were merged to make my dataset (UN_UNESCO.csv)



## Dependencies

* In order to run the app, RStudio needs to be installed :
https://www.rstudio.com/products/rstudio/

* In addition, R needs to be installed:
https://www.r-project.org/


## Installing

* The interactive app is available at: https://nedatahe.shinyapps.io/endangered-languages-of-the-world/

* The app and the data used are also available on this github repository:

https://github.com/nedatahe/endangered-languages


## Executing program

These steps are required to run the app:
* Run the global.R file on RStudio,
* Run the server.R file on RStudio, 
* Run the ui.R file on Rstudio, 
* On the Files tab on the app, from the Setting gear, set the Working Directory as where you have downloaded the app into your computer. 


## Author

Neda Taherkhani

Email: neda.tahe[atsign]gmail.com

LinKedin: https://www.linkedin.com/in/nedata/ 

## Acknowledgments

Acknowledgements go to the instructor of the Data Science (5) bootcamp at Nashville Software School, Michael Halloway, and the TAs of the bootcamp, Veronica Ikeshoji-Orlati and Alvin Wendt. I also appreciate the role of Bryan Finlayson in helping me build and debug the app. 
