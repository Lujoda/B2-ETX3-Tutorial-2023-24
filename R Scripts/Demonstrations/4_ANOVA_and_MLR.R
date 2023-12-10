#### B2/ETX3 Tutorial ####

##### R Script 4: ANOVA and multiple linear regression

    # In this exercise we will work with a fictional data set which sampled forest areas and measured the parameters
    # soil type ["Clay", "Sand"], average temperature [°C], rainfall [mm], forest type ["Deciduous", "Coniferous", "Mixed"],
    # soil organic matter [%], tree height [m], and the number of species.
    # 
    # The data will help you to understand the concepts and uses of ANOVA and multiple linear regression



#### Packages #####

#install.packages("pacman")
library(pacman)
p_load(here, readxl, ggplot2, car)


##### Data #####
forest = read.csv("Data/4/forest_data.csv")




##### 1. ANOVA #####

        # We want to find out whether there is a difference in tree height when observing forests of different types
    
    # Step 0: Define model
    tree_height_forest_type_ANOVA = aov(Tree_Height ~ Forest_type, data = data) # We use the "aov()"-function from the
                                                                                # "car" package to perform the ANOVA
    
    
    # Step 1: Check Assumptions
      # Assumption 1: Normality of Residuals
      
      # Check the normality of residuals using a Q-Q plot
      
        # Extract residuals from model
        residuals = residuals(tree_height_forest_type_ANOVA)
      
        # Check residuals for normality
        qqnorm(residuals)
        qqline(residuals)
      
        
        # Residuals are normally distributed!
        
        
        
      # Assumption 2: Homogeneity of Variances
        
      # You can use violin plots for visual inspection
      ggplot(forest_data, aes(x = Forest_type, y = Tree_Height)) + geom_violin()
        
      # For mathematical checking of homogeneity of variances you can use a Levene's test
      leveneTest(Tree_Height ~ Forest_type, data = forest_data)
      
        # p-value > 0.05, hence variances are assumed to be homogeneous
      
      
      # Assumption 3: Independence of Observations
      # Ensure independence of observations, which is often assumed in ANOVA
      
  
    # Step 2: Interpret the ANOVA output
    summary(tree_height_forest_type_ANOVA)
    
      # p-value = 0.19 (> 0.05), there is a 19% probability that differences between the groups
      # with regard to forest type is merely due to chance
    
    
    # Step 3: Post-hoc tests (if needed)
    # If there are significant differences, you may want to perform post-hoc tests.
    # Examples include Tukey's HSD or pairwise t-tests.
    
    # Either method will show you p-values for each possible combination
    # From this output you can see what groups are significantly different from each other
    
    # Tukey's HSD
    TukeyHSD(tree_height_forest_type_ANOVA)
    
    # Pairwise t-tests (adjust p-values for multiple comparisons)
    pairwise.t.test(forest_data$Tree_Height, data$Forest_type, p.adj = "bonferroni")
    
    
    # Post-hoc test would not have been necessary in this case, because the ANOVA result was not significant
    
  

  
#### 2. Multiple Linear Regression ####
    
    
    # Step 0: Fit model(You can select variables to include in the regression model either by using logic or prior knowledge
    # (e.g. plants need water to grow -> Rainfall should have a influence on tree height) but you can also look whether a linear 
    # relationship between the predictors and the variable of interest exists
    
    mlr_tree_height = lm(Tree_Height ~ Temperature + Soil_organic_matter, data = forest_data)
    
    # Step 1: Check Assumptions
    # Assumption 1: Linearity
    # Use scatterplots to visualize the relationships between predictor variables and the response variable
    plot(forest_data$Temperature, forest_data$Tree_Height, main = "Scatterplot of Temperature vs. Tree_Height")
    plot(forest_data$Soil_organic_matter, forest_data$Tree_Height, main = "Scatterplot of Soil_organic_matter vs. Tree_Height")
    
      # There appears to be a linear relationship between tree height and temperature/soil organic matter
    
    # Assumption 2: Multicollinearity
    # Check for multicollinearity among predictor variables
      
      # Method 1: Variance Inflation Factor (VIF)
      vif(mlr_tree_height) # (use vif()- function on fitted model)
      
        # All VIF are close to 1, so there seems to be no multicollinearity
      
      
      # Method 2: Correlation matrix
      cor(forest_data[c("Temperature", "Soil_organic_matter")])
        
        # Correlation between variables is low, so multicollinearity seems unlikely
      
      
    # Assumption 3: Independence of Residuals
    # Check the independence of residuals using a Durbin-Watson test
    # Install the "lmtest" package if not already installed
    # install.packages("lmtest")
    library(lmtest)
      
    dwtest(mlr_tree_height, alternative = "two.sided")
    
      # p-value > 0.05, hence we assume that there is no autocorrelation of residuals
    
    
    

    # Step 2: Model diagnosis ( if you are unsure about this read this guide to diagnostic plots: 
    #                          https://www.statology.org/diagnostic-plots-in-r/ )
    
    
    # 2.1 Linearity of residuals
    plot(mlr_tree_height, which = 1)
      
      # Line is horizontal -> assumption met
    
    # 2.2 Normality of Residuals
    # Check for normality of residuals using a Q-Q plot
    plot(mlr_tree_height, which = 2)
    
      # All point approximately on the line -> assumption met
    
    # 2.3 Check Homoscedasticity
    plot(mlr_tree_height, which = 3)
    
      # Variance is constant -> assumption met
    
    # 2.4 Influential Observations
    plot(mlr_tree_height, which = 5)
    
      
      # No outliers present
    
    
    # Step 3: Interpret the Model
    summary(mlr_tree_height)

    # Both temperature and soil organic matter seem to have a significant (p < 0.01) positive effect on tree height.
    # However the two variables are not sufficient to predict tree heights very accurately (R squared is smaller than 0.4)
    
 
