#### B2/ETX3 Tutorial ####

##### R Script 3: Assessing hypotheses and simulation-based approaches

#### Packages #####

#install.packages("here")
library(here)
library(readxl)
library(ggplot2)

##### Data #####
ghg = read.csv(here("Data/1/ghg.csv"))

bats = read_excel("Data/3/abundance_data_full.xlsx", sheet = 1)
grasshoppers = read_excel("Data/3/abundance_data_full.xlsx", sheet = 4)
butterflies = read_excel("Data/3/abundance_data_full.xlsx", sheet = 7)

dragonflies = read.csv("Data/3/dragonflies.csv")
dragonflies_small = read_excel("Data/3/abundance_data_full.xlsx", sheet = 10)
dragonflies_small = dragonflies_small[c(1,4,5,6)]
write.csv(dragonflies_small, "Data/3/dragonflies_small_sample.csv", row.names = FALSE)


  # In this exercise we will be working with ecological data that measured the abundance and species richness of 
  # various organism groups in habitats around Landau
  # These parameters were measured at conservation areas and non-conservation areas
  # We want to find out if conservation areas have significantly different abundance and richness of species


##### Visualization/Plotting #####
ggplot(dragonflies, aes(Conservation_area, N)) + geom_boxplot()
ggplot(dragonflies, aes(Conservation_area, S)) + geom_boxplot()



##### t-test #####

  # Let's save our two groups in their own object
  df_abund_conserv = dragonflies$N[dragonflies$Conservation_area == "Yes"]
  df_abund_nonconserv = dragonflies$N[dragonflies$Conservation_area == "No"]
    # Abundance of dragonflies in conservation or non-conservation areas
  
  # Before conduction a t-test we must first check whether all assumptions of the test are fulfilled
  # (you can find more info on t-test assumptions on the GitHub)
  
  # 1. Independence of observations
    # We assume that the data was gathered independently

  # 2. Normal distribuation of both populations
    # There are various ways of checking for normal distributions

    # Shapiro-Wilk test:
    shapiro.test(df_abund_conserv)
    shapiro.test(df_abund_nonconserv)
    
      # Both Shapiro-Wilk tests have a p-value >0.05 so we cam assume that both populations
      # are normally distributed
    
    # In this case we can also use a visual assessment using density plots to see the data is normally distributed
    plot(density(df_abund_conserv))
    plot(density(df_abund_nonconserv))

    # Depending on our data we could also use histograms or favorably qq-plots when we have enough data points to check
    # for normality
    
  # 3. Homogeneity of variance
    
    # Can be checked either graphically
    ggplot(dragonflies, aes(x = Conservation_area, y = N)) + geom_boxplot()
    
      # Variances of both groups are very different (whisker length)

    # Or mathematically 
    var(df_abund_conserv)/var(df_abund_nonconserv)
      
      # Variances differ by about two powers of ten (10^2 = 100)

    # This assumption is not fulfilled!
    # Because of this we must use a non-parametric version of the t-test -> Welch's t-test
    # Luckily the "t.test()"-function in R uses the Welch's t-test by default
    # If you want R to assume equal variances you have to specify by adding the argument "var.equal = TRUE"
    # -> t.test(group1, group2, var.equal = TRUE) to perform a Student's t-test
    

    
    
    # Performing the t-test
    t.test(df_abund_nonconserv, df_abund_conserv) # Welch's two sample t-test
    
      # The t-test suggests a significant difference between the two groups
      # After calculating the standard deviations, we could report the result as follows:
    
      sd(df_abund_nonconserv) # SD of non-conservation areas is 1.16
      sd(df_abund_conserv) # SD of conservation areas is 12.0
      
      # The mean dragonfly abundance in non-conservation areas was 1.9 (SD = 1.16), whereas the mean in conservation areas
      # was 26.2 (SD = 12.0). 
      # A Welch two-samples t-test showed that the difference was statistically significant, 
      # t(8.15) = -6.0, p < 0.001.
    

##### Permutation ######

      # Suppose our sample is very small and we can not effectively use a standard t-test but still want two know
      # if two groups are significantly different
      # In such a case we could use a permutation test
      
      # Consider the following data:
      dragonflies_small = read.csv("Data/3/dragonflies_small_sample.csv")
      
      # Our sample size is very small and a standard t-test seems inappropriate
      
      # We conduct a Permutation test:
      
      # 0. Set seed (makes random operations reproducable for other people => good practice)
      set.seed(1337)
      # 1. Isolate the groups you want to compare
      df_abund_conserv_small = dragonflies_small$N[dragonflies_small$Conservation == 1]
      df_abund_nonconserv_small = dragonflies_small$N[dragonflies_small$Conservation == 0]
      
      # 2. Calculate the observed test statistic (e.g., the difference in means)
      observed_statistic <- mean(df_abund_conserv_small) - mean(df_abund_nonconserv_small)
      
      # 3. Combine the groups
      df_small_combined = c(df_abund_nonconserv_small, df_abund_conserv_small)
      
      # 4. Set the number of permutations
      num_permutations = 1000
      
      # 5. Create a vector to store the permuted statistic (vector length must be equal to number of permutations)
      permuted_statistics = numeric(num_permutations)
      
      # 6. Conduct permutation test (We're using a for-loop to do that. Especially in the beginning that's a bit
      # complicated. You can try to understand what's happening here if you're interested but for the tasks it is enough
      # to just copy the code for now)
      
      for (i in 1:num_permutations){
        
        # 6.1. Shuffle the data randomly
        shuffled_data = sample(df_small_combined)
        
        # 6.2. Calculate the statistic of the shuffled data (mean)
        permuted_statistic = mean(shuffled_data[1:3]) - mean(shuffled_data[4:6])
        
        # 6.3. Store the calculated statistic for each loop repetition
        permuted_statistics[i] = permuted_statistic
      }
      
      # 7. Calculate p-value
      p_value = sum(abs(permuted_statistics) >= abs(observed_statistic)) / num_permutations
      
      # 8. Display results
      cat("Observed Statistic:", observed_statistic, "\n")
      cat("Permutation p-value:", p_value, "\n")
      
        # The interpretation of the result would be as follows:
        # About 10 % of the randomly permutated samples had a difference in group means larger or equal to the
        # original two groups (mean difference = 26.3333).
        # This means that there is a ~10% chance that the difference is only due to coincidence.
        # In a classical approach we would only speak of a significant result when the chance of the result
        # being mere coincidence is <5%.
        # Hence in this case we would conclude that there is no significant difference between the groups
      
      
##### Bootstrapping #####

##### Cross-validation ######
      
      
 
      