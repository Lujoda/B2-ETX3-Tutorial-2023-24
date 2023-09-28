#### B2/ETX3 Tutorial ####

##### R Script 1: Basics (packages, loading data, basic data manipulation, plotting)

      # In this exercise we will be working with a big data set containing greenhouse gas emissions of various countries
      # over the last few hundred years (Hannah Ritchie, Pablo Rosado and Max Roser (2020) - "Greenhouse gas emissions". 
      # Published online at OurWorldInData.org. Retrieved from: 'https://ourworldindata.org/greenhouse-gas-emissions' 
      # [Online Resource])

###### Packages ######

  # Packages are used to import
  
  install.packages("here")
  library(here)

###### Loading data #####

  # Reading data (Using "read.csv"-function for ".csv"-files)
  #ghg_ger = read.csv(here("Data/1/ghg_ger.csv"))
  ghg = read.csv(here("Data/1/ghg.csv"))
  
  
  # You can inspect your data set by using the "View()"-function or clicking on it in the top right "Environment" window
  # View(ghg)
  
  # You can gain additional insight into the data by using some of the following commands (among others)
  
  summary(ghg) # Some distributional information of all variables (min, mean, max, etc.)
  
  str(ghg)     # Types of variables (character, number, integer, etc.)
  
  names(ghg)   # Names of the variables/columns
  
  nrow(ghg)    # Number of rows (observations)
  
  ncol(ghg)    # Number of columns (variables)
  # As you may notice it contains a lot of information and looks quite chaotic
  # Because of this it is always the first step to clean the data and extract only the information necessary for us
  
###### Cleaning data ######
  
  # In this exercise we want to focus only on CO2 emissions from Germany
  # We want to keep the columns "year", "population" and "co2" and ditch the rest
  # One way of doing it is using the following command
  
  
  ghg_ger = ghg[ghg$country == "Germany",]         # We create a new data set "ghg_ger" which fulfill the condition that
                                                   # the country is Germany
  
  ghg_ger = ghg_ger[c("year","population","co2")] # Then we only keep the columns "year", "population" and "co2"
  
  
  # When we look at it again it is no longer chaotic and contains only relevant information
  # View(ghg_ger)
  
  

###### Plotting data #####
  
  
  # Now that we extacted the relevant data we want to plot 
  # the development of CO2 emissions over time in Germany
  
  
  # For this we can use the base R "plot()"-function
  # (The "$" sign is used to select a single column by name from a data set)
  
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

  
##### Your tasks #####
  
  
  ###### 1. Subsetting #####
  
  # Create subset of the "ghg" data set that only contains information about the year, 
  # methane emissions and population of China
  
  
  
  ###### 2. Plotting ######
  
  # Plot the development of methane emissions in China

  
  ###### 3. New column ######
  
  # Create a new column "methanepercapita" that resembles the methane emissions 
  # relative to the population and plot it