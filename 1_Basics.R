#### B2/ETX3 Tutorial ####

##### R Script 1: Basics (packages, loading data, basic data manipulation, plotting)


###### Packages ######

  # Packages are used to import



###### Loading data #####

  # Set working directory
  setwd("C:/Users/Luic/OneDrive/Master/Hiwi/Stats Tutorial 23_24/Data")

  data = read.csv("owid-co2-data.csv")

  
  ger = data[data$country == "Germany",]

  plot(ger$year, ger$co2)  
  plot(ger$year, ger$cement_co2_per_capita)
  plot(ger$year, ger$cement_co2/ger$population)
  
  