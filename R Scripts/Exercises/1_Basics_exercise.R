#### B2/ETX3 Tutorial ####

##### R Script 1: Basics (packages, loading data, basic data manipulation, plotting)

# In this exercise we will be working with a big data set containing greenhouse gas emissions of various countries
# over the last few hundred years (Hannah Ritchie, Pablo Rosado and Max Roser (2020) - "Greenhouse gas emissions". 
# Published online at OurWorldInData.org. Retrieved from: 'https://ourworldindata.org/greenhouse-gas-emissions' 
# [Online Resource])




###### Packages ######

# Packages are used to import new external functions into R that are not available in the 
# standard (base) version of R

#install.packages("pacman")
library(pacman)
p_load(here, ggplot2)



##### Data ######
ghg = read.csv(here("Data/1/ghg.csv"))


##### Your tasks #####


###### 1. Subsetting #####

  # Create subset of the "ghg" data set that only contains information about the year, 
  # methane emissions and population of China





###### 2. Plotting ######
    
  # Plot the development of methane emissions in China (if you want you can use ggplot2)
  # The plot should only depict years in which methane emission data is available (= methane value should not be "NA", the 
  # function na.omit() removes all rows which contain "NA")
  # Give your plot and your axes a title 


###### 3. New column ######

  # Create a new column "methanepercapita" that resembles the methane emissions 
  # relative to the population and plot it (if you want you can use ggplot2)
  


###### Bonus task - filtering ######

  # Create a new data frame from "ghg" that:
  # 1. Only contains data from the year 2015
  
  # 2. Only contains countries with a CO2 emission less than 1 billion tons (CO2 unit in the data frame is million tons)
  # (similar to this you can also remove outliers in a data frame)

  # 3. Only contains countries that have a iso code (e.g IND,RUS,JPN)
 

