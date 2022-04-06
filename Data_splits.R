#Libraries needed ----

library(tidyverse)
library(tidymodels)
library(readr)
library(janitor)

#Seed----
set.seed(3013)

#Reading data----
credit_data <- read_csv("datasets/clean_data.csv")

#EDA-Modeling split 
credit_first_split <- credit_data %>%
  clean_names() %>%
  initial_split(prop = 0.7, strata = target)

credit_eda <- credit_first_split %>% testing()
credit_rest <- credit_first_split %>% training()

save(credit_eda, file = "datasets/credit_eda.rda")
save(credit_rest, file = "datasets/credit_rest.rda")

#Data wrangling ----

credit_rest <- credit_rest %>% 
  mutate(gender = factor(gender),
         own_car = factor(own_car),
         own_property = factor(own_property),
         work_phone = factor(work_phone),
         phone = factor(phone),
         email = factor(email),
         unemployed = factor(unemployed),
         income_type = factor(income_type),
         education_type = factor(education_type),
         family_status = factor(family_status),
         housing_type = factor(housing_type),
         occupation_type = factor(occupation_type),
         target = factor(target))



#Training-testing split ----
credit_modeling <- credit_rest %>% 
  initial_split(prop = 0.8, strata = target)

credit_training <- credit_modeling %>% training()
credit_testing <- credit_modeling %>% testing()

save(credit_training, file = "datasets/credit_training.rda")
save(credit_testing, file = "datasets/credit_testing.rda")

#Resampling ----

resamples <- credit_training %>% 
  vfold_cv(v = 5, repeats = 3, strata = target)

save(resamples, file = "datasets/resamples.rda")

#Finish script.


