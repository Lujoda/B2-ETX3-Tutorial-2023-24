#### B2/ETX3 Tutorial ####

##### R Script 1: Basics (packages, loading data, basic data manipulation, plotting)


###### Packages ######

  # Packages are used to import
  
  install.packages("here")
  library(here)

###### Loading data #####

  # Reading data (Using "read.csv"-function for ".csv"-files)
  ghg_ger = read.csv(here("Data/1/ghg_ger.csv"))

  
###### Plotting data #####
  
  # Development of CO2 emissions over time
  
  plot(x = ghg_ger$year, # x-axis
       y = ghg_ger$co2)  # y-axis
 
  # The plot is missing important information (e.g. title, unit of CO2 emissions) 
  # Use the build-in help that R offers to add this information
  
  ?plot
  
  # In the documentation we learn that we can use the arguments "main = ", "xlab = " and "ylab = " to add additional info
  
  plot(x = ghg_ger$year, # x-axis
       y = ghg_ger$co2,  # y-axis
       main = "Development of CO2 emissions in Germany", # title
       xlab = "Year", # title of x-axis
       ylab = "CO2 emissions in million tons")  # title of y-axis
  
###### Manipulating data ######
  
  # We want to see the developments of CO2 emission per capita
  # For this we can create a new column dividing CO2 emissions by population
  
  ghg_ger$co2percapita = ghg_ger$co2/ghg_ger$population
  
  # Plotting the development of CO2 per capita
  
  plot(x = ghg_ger$year, # x-axis
       y = ghg_ger$co2percapita,  # y-axis
       main = "Development of CO2 emissions per capita in Germany", # title
       xlab = "Year", # title of x-axis
       ylab = "CO2 emissions in million tons")  # title of y-axis
  
  