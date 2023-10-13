#### B2/ETX3 Tutorial ####

##### R Script 2: Linear regression

#### Packages #####

#install.packages("here")
  library(here)

##### Data #####
  troposphere = read.csv(here("Data/2/troposphere.csv"))
  
  # In this exercise we will work with atmospheric data in the troposphere (altitude [m], temperature [°C], 
  # oxygen content [%], wind speed [km/h]) to explore linear regressions

##### Linear regression ######

###### Creating model and checking assumptions #######
  
  # We want to explore the relationship between altitude and temperature in the troposphere
  # Let's see if we can use linear regression to predict temperature from altitude
  
  # First we plot the two variables on a scatterplot to see whether a linear relationship looks plausible or not

  plot(troposphere$Altitude, troposphere$Temperature)
    # Looks good!

  # So now let's define our linear model using the "lm()" function
  # We want to predict temperature from altitude, so:

  temp_mod = lm(Temperature ~ Altitude, data = troposphere)
  
  # We add the regression line from the model to the scatterplot to see how it fits
  
  abline(temp_mod)
  # Looks great
  
  
  # Now we  have to check whether the assumptions of the linear model are fulfilled:
  
  
  # 1. Linearity -> Yes! (we already checked that by plotting the variables)
  
  # 2. Normal distribution of residual errors -> ?
  
  # 3. Constant variance of residuals (Homoscedasticity) -> ?
  
  # 4. Independece of observations -> Yes! we assume that the data was gathered correctly
  
  # Also we will check for outliers and influential observations
  
  # To perform this model diagnosis we can use the "plot()"-function on our model "temp_mod"
  # It will return diagnostic plots where we can see whether the assumptions are met or not
  plot(temp_mod)
  
  
  # We can see that normal distribution of residual errors constant variance of residuals (Homoscedasticity) 
  # are fulfilled and that there are no outliers or influential observations
  
  # If you are unsure how to read this from the plots, go see the "Additional resources" on github
  # There are links quickly explaining "Linear model assumptions and diagnosis"
  
  

###### Interpreting model ######
  
  # Now that we know all the assumptions are fulfilled and our model is plausible
  # we can interpret the model outcome and gain an understanding between the relationship of altitude 
  # and temperature
  
  # For that we use the "summary()"-function
  
  summary(temp_mod)
    # We can gather a lot of information from the output in the console, most importantly:
  
    # 1. The p-value is very small (<2.2e-16) -> the linear relationship between altitude and temperature
    # is statistically highly significant
  
    # 2. R-squared value is very high (>= 0.99) -> the model can predict temperature from altitude 
    # very accurately
  
    # 3. The formula to predict temperature from altitude is: 
    # Temperature = 15.06 - 0.0065*Altitude
  
  
  
###### Adding confidence intervals #####
  
  conf_intervals = confint(temp_mod, level = 0.95) # 95% confidence interval
  conf_intervals
  
    # The 95% confidence interval of the influence of altitude on temperature is [-0.0067, -0.0062]
    # The interval does not contain 0, hence the negative relationship between altitude and temperature 
    # is significant
  
  
  # To visualize the confidence band in the plot it is easier to use ggplot
  
  library(ggplot2)
  temp_alti_plot_conf = ggplot(troposphere, aes(Altitude, Temperature)) + 
    geom_point() +
    stat_smooth(method = lm, level = 0.95) # This adds a 95% confidence band
  temp_alti_plot_conf
  
  # We also want to add the prediction band
  # First we calculate it:
  predict_interval = predict(temp_mod, interval = "prediction")
  
  # Then we add it to the plot
  troposphere_predict = cbind(troposphere, predict_interval) 
      # Add the prediction band values to the troposphere data set
  
  temp_alti_plot_conf_pred = ggplot(troposphere_predict, aes(Altitude, Temperature)) + 
    geom_point() +
    stat_smooth(method = lm, level = 0.95) + # This adds a 95% confidence band (grey band)
    geom_line(aes(y = lwr), color = "red", linetype = "dashed")+ # These two lines add the prediction band
    geom_line(aes(y = upr), color = "red", linetype = "dashed")  # (red band)
  
  temp_alti_plot_conf_pred
  
  # Remember, the confidence interval deals with the average (mean) and 
  # the prediction interval deals with actual predictions
  
  
  
  
  
  
  
  
  
##### Tasks #####
  
  # 1. Perform a linear regression on the variables "altitude" and "windspeed" in the "low_troposphere"
  # data set:
  
  low_troposphere = read.csv(here("Data/2/lower_troposphere.csv"))
  
  # Go through the following steps:
  
    # 1.1 Check for linearity
  
    # 1.2 Create linear model
  
    # 1.3 Perform model diagnosis and check if all assumptions are fulfilled
  
    # 1.4 Add confidence and prediction bands to the plot
  
  
  
  
  # 2. Answer the following question: Is simple linear regression suitable to predict oxygen levels in the
  # troposphere from altitude and why?
  # (use the variables "Altitude" and "Oxygen" the data set "troposphere")
  
