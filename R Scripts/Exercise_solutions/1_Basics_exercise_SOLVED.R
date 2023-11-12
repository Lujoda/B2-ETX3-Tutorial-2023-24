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

  ghg_chi = ghg[ghg$country == "China",]
  ghg_chi = ghg_chi[c("year","methane","population")]



###### 2. Plotting ######
  
  # Plot the development of methane emissions in China (if you want you can use ggplot2)
  # The plot should only depict years in which methane emission data is available (= methane value should not be "NA", the 
  # function na.omit() removes all rows which contain "NA")
  # Give your plot and your axes a title 
  
    # Simple plot
  plot(ghg_chi$year,
       ghg_chi$methane)

    # Removing NAs
  ghg_chi_noNA = na.omit(ghg_chi)
  
    # Plot without NAs
  plot(ghg_chi_noNA$year,
       ghg_chi_noNA$methane)
  
    
    # Add titles
  plot(ghg_chi_noNA$year,
       ghg_chi_noNA$methane,
       main = "Development of methane emission in China from 1990 to 2020 in million tons",
       xlab = "Year",
       ylab= "Methane emissions in million tons")
  
  
  
    ## ggplot2 way
    gg = ggplot(data = ghg_chi_noNA, aes(x = year, y = methane)) +
      
      # Specify the geom (line plot)
      geom_line(color = "dodgerblue") +
      
      # Customize axis labels and titles
      labs(
        x = "Year",
        y = "Methane emissions [million tons]",
        title = "Development of methane emissions in China"
      ) +
      
      
      # Customize the theme for a professional look
      theme_bw()   # black and white theme
    
    
    gg
    
###### 3. New column ######

  # Create a new column "methanepercapita" that resembles the methane emissions 
  # relative to the population and plot it (if you want you can use ggplot2)
    
    # Create new column
  ghg_chi_noNA$methanepercapita = ghg_chi_noNA$methane/ghg_chi_noNA$population

    
    # Plot
    plot(ghg_chi_noNA$year,
         ghg_chi_noNA$methanepercapita,
         main = "Development of methane emission per capita in China from 1990 to 2020 in million tons",
         xlab = "Year",
         ylab= "Methane emissions in million tons")
    
    
    
    ## ggplot2 way
    gg = ggplot(data = ghg_chi_noNA, aes(x = year, y = methanepercapita)) +
      
      # Specify the geom (line plot)
      geom_line(color = "dodgerblue") +
      
      # Customize axis labels and titles
      labs(
        x = "Year",
        y = "Methane emissions per capita [million tons]",
        title = "Development of methane emissions in China"
      ) +
      
      
      # Customize the theme for a professional look
      theme_bw()   # black and white theme
    
    
    gg
    

###### Bonus task - filtering ######

  # Create a new data frame from "ghg" that:
    # 1. Only contains data from the year 2015
    
    ghg_filter = ghg[ghg$year == 2015,]
    
    # 2. Only contains countries with a CO2 emission less than 1 billion tons (CO2 unit in the data frame is million tons)
    # (similar to this you can also remove outliers in a data frame)

    ghg_filter = ghg_filter[ghg$co2 < 1000,]
    
    # 3. Only contains countries that have a iso code (e.g IND,RUS,JPN)
    
      # Removing rows with NA in iso_code column
    ghg_filter = ghg_filter[!is.na(ghg_filter$iso_code),]
    
      # Removing rows with empty values in iso_column (empty values are mostly strings with no content,
      # string with content: "GER", empty string: "")
    ghg_filter = ghg_filter[ghg_filter$iso_code != "",]
    

