#### B2/ETX3 Tutorial ####

##### R Script 3: Assessing hypotheses and simulation-based approaches

#### Packages #####

#install.packages("pacman")
library(pacman)
p_load(here, readxl, ggplot2)


#### Data ####
bats = read.csv(here("Data/3/bats.csv"))
butterflies = read.csv(here("Data/3/butterflies.csv"))


##### Tasks #####


# 1. t-test
  # Test the hypothesis that bat abundance (N) differs between conservation areas and non-conservation ares
  # Use a t-test for that

  # 1.1 Save each group in an own variable (conservation area vs. non-conservation area)
  

  # 1.2 Check if the assumptions are fulfilled (normal distribution, homogeneity of variance)
    
    # 1.2.1 Normal distribution

    # 1.2.2 Homogeneity of variance


  # 1.3 Perform the adequate t-test and interpret the results



# 2. Permutation test
  # The data set for butterflies is too small to use a regular t-test 
  # Use a permutation test instead to see if there are significant differences of butterfly abundances
  # between conservation and non-conservation areas


# 3. Bootstrapping
  # Use bootstrapping to estimate the 95% confidence interval of the standard deviation of butterfly abundances in
  # non-conservation areas
  # (Hint: standart deviation of a vector can be calculated using the sd()-function)