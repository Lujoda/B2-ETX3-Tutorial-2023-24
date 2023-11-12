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

# 1.2 Create linear model

# 1.3 Perform model diagnosis and check if all assumptions are fulfilled

# 1.4 Add confidence and prediction bands to the plot

# 1.5 Interpret the models results



# 2. Answer the following question: Is simple linear regression suitable to predict oxygen levels in the
# troposphere from altitude and why?
# (use the variables "Altitude" and "Oxygen" the data set "troposphere")

