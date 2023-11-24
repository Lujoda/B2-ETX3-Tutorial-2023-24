#### B2/ETX3 Tutorial ####

##### R Script 4: ANOVA and multiple linear regression

# In this exercise we will work with two fictional data sets:

# Air quality data: measured the annual average NO2, PM10 and O3 concentrations (in ug/m^3) for four different cities

# Forest data: which sampled forest areas and measured the parameters
# soil type ["Clay", "Sand"], average temperature [°C], rainfall [mm], forest type ["Deciduous", "Coniferous", "Mixed"],
# soil organic matter [%], tree height [m], and the number of species.


#### Packages #####

#install.packages("pacman")
library(pacman)
p_load(here, ggplot2, car, GGally)


#### Data ####
forest = read.csv("Data/4/forest_data.csv")
air_quality = read.csv("Data/4/air_quality.csv") # (pollutant concentrations in ug/m^3)


#### Tasks ####

  # Task 1 ANOVA: Find out whether there is a difference between air pollution between the different cities 
  # (Use the "air_quality" data set)

  # Conduct an ANOVA to assess differences between the cities with regards to one of the pollutants 
  # (choose either NO2, PM10 or O3)
    
    # Visualisation
    
    # NO2
    ggplot(air_quality_data, aes(x = City, y = NO2)) + geom_violin()

    # PM10
    ggplot(air_quality_data, aes(x = City, y = PM10)) + geom_violin()
    
    # O3
    ggplot(air_quality_data, aes(x = City, y = O3)) + geom_violin()
    
    
    
    
    # Step 0: Define model

      # We use the "aov()"-function from the "car" package to perform the ANOVA
    
    

    # Step 1: Check Assumptions

        # Assumption 1: Normality of Residuals
        
        
        
        # Assumption 2: Homogeneity of Variances
        
    
        
        # Assumption 3: Independence of Observations

        


    # Step 2: Interpret the ANOVA output




    # Step 3: Post-hoc tests (if needed)
    # If there are significant differences, you  want to perform post-hoc tests.






  # Task 2: Multiple Linear Regression
    
  # Create a model to predict average tree height from the other variables
    
    
    
    # Step 0: Fit model (You can select variables to include in the regression model either by using logic or prior knowledge
    # (e.g. plants need water to grow -> Rainfall should have a influence on tree height) but you can also look whether a linear 
    # relationship between the predictors and the variable of interest exists (a useful function for this is the "ggpairs()"-
    # function from the "GGally" package, try it out in Step 2 to find suitable predictor variables))

    
    
    # Step 1: Check Assumptions
    # Assumption 1: Linearity
    # Use scatterplots to visualize the relationships between predictor variables and the response variable
    ggpairs(forest)

    
    
    # Assumption 2: Multicollinearity
    # Check for multicollinearity among predictor variables
    
    
    # Method 1: Variance Inflation Factor (VIF)
 
    
    # Method 2: Correlation matrix

    
    
    # Assumption 3: Independence of Residuals
    # Check the independence of residuals using a Durbin-Watson test
    # Install the "lmtest" package if not already installed
    # install.packages("lmtest")
   
    
    
    
    # Step 2: Model diagnosis ( if you are unsure about this read this guide to diagnostic plots: 
    #                          https://www.statology.org/diagnostic-plots-in-r/ )
    
    
      # 2.1 Linearity of residuals
  
    
    
      # 2.2 Normality of Residuals
      # Check for normality of residuals using a Q-Q plot
  
    
    
    
      # 2.3 Check Homoscedasticity
    
    
    
    
      # 2.4 Influential Observations
  
      
    
    
  
    # Step 3: Interpret the Model

 
    