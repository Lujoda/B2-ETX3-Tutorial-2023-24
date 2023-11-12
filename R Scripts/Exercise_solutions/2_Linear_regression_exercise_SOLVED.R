##### R Script 2: Linear regression

#### Packages #####

#install.packages("pacman")
library(pacman)
p_load(here)


##### Data #####
troposphere = read.csv(here("Data/2/troposphere.csv"))
  # In this exercise we will work with atmospheric data in the troposphere (altitude [m], temperature [°C], 
  # oxygen content [%], wind speed [km/h]) to explore linear regressions

low_troposphere = read.csv(here("Data/2/lower_troposphere.csv"))
  # This data set contains altitude [m] and wind speed data [km/h] from the lower atmosphere




##### Tasks #####

# 1. Perform a linear regression on the variables "altitude" and "windspeed" in the "low_troposphere"
# data set:



# Go through the following steps:

# 1.1 Check for linearity
plot(low_troposphere$altitude, low_troposphere$windspeed)

    # A linear relationship looks plausible!

# 1.2 Create linear model
model = lm(windspeed ~ altitude, data = low_troposphere) # Always put the dependent variable first (we want to predict
                                                         # windspeed from altitude, so windspeed is supposedly dependent 
                                                         # on altitude)




# 1.3 Perform model diagnosis and check if all assumptions are fulfilled
plot(model)

    # Scale-Location -> Variance seems to be constant = Homoscedasticity is fulfilled

    # QQplot -> data points are not perfectly on the diagonal line but it is still sufficient to assume 
    # a normal distribution of errors

    # Residuals vs Leverage -> No outliers are present



# 1.4 Add confidence and prediction bands to the plot
library(ggplot2)
model_plot_conf = ggplot(low_troposphere, aes(altitude, windspeed)) + 
  geom_point() +
  stat_smooth(method = lm, level = 0.95) # This adds a 95% confidence band
model_plot_conf

# We also want to add the prediction band
# First we calculate it:
predict_interval = predict(model, interval = "prediction", level = 0.95)

# Then we add it to the plot
low_troposphere_predict = cbind(low_troposphere, predict_interval) 
# Add the prediction band values to the troposphere data set

model_plot_conf_pred = ggplot(low_troposphere_predict, aes(altitude, windspeed)) + 
  geom_point() +
  stat_smooth(method = lm, level = 0.95) + # This adds a 95% confidence band (grey band)
  geom_line(aes(y = lwr), color = "red", linetype = "dashed")+ # These two lines add the prediction band
  geom_line(aes(y = upr), color = "red", linetype = "dashed")  # (red band)

model_plot_conf_pred


# 1.5 Model interpretation
summary(model)

    # There is a significant linear relationship between altitude and wind speed in the lower troposphere (p-value < 0.001)
    # With every meter of altitude wind speed increases by about 0.11 km/h
    




# 2. Answer the following question: Is simple linear regression suitable to predict oxygen levels in the
# troposphere from altitude and why?
# (use the variables "Altitude" and "Oxygen" from the data set "troposphere")



# To answer this question we go through the same procedure as before

# 2.1 Check for linearity
plot(troposphere$Altitude, troposphere$Oxygen)

  # It alreay does not look like a linear relationship is fitting
  # But let's try to create this model and use the diagnostic plots to get more info

model2 = lm(Oxygen ~ Altitude, data = troposphere)
plot(model2)
  
  # Residuals vs. Fitted and Scale-Location plots also indicate clearly that a simple linear model is unsuitable 
  # for the data
