# install packages
# install.packages("readr", repos = "http://cran.us.r-project.org")
# install.packages("dplyr", repos = "http://cran.us.r-project.org")
# install.packages("MatchIt", repos = "http://cran.us.r-project.org")
# install.packages("tidyverse", repos = "http://cran.us.r-project.org")

# load packages
library(readr)
library(dplyr)
library(MatchIt)
library(tidyr)

# read csv
df <- read.csv("./combined.csv")


# cleaning
dff <- 
    df %>% 
    select(CaseIdentifier, age, race, gender, group, death_year, casenumber, composite_latitude, composite_longitude) %>%
    filter(complete.cases(.)) %>%
    mutate(case = case_when(group == "xylazine" ~ 1, group == "fentanyl" ~ 0)) %>% 
    mutate_if(is.character, as.factor) %>%
    filter(!is.na(case))


# match-it function
m2 <- matchit(case ~ age + race + gender + death_year, data = dff, method = "nearest", distance = "glm", ratio = 3)
print(summary(m2))

# match table
a <- match.data(m2)
a2 <- 
    a %>% 
    left_join(dff %>% select(CaseIdentifier, composite_longitude, composite_latitude, casenumber)) %>% 
    select(matchnumber = subclass, CaseIdentifier, casenumber, age, race, gender, CaseIdentifier, composite_longitude, composite_latitude, group, death_year, case, distance, weights) %>% 
    arrange(matchnumber, desc(case))

# write
write.csv(a2, "xylazine_matched_fentanyl.csv", row.names = F)


## xylazine-alcohol

# cleaning
dff <- 
    df %>% 
    select(CaseIdentifier, age, race, gender, group, death_year, casenumber, composite_latitude, composite_longitude) %>%
    filter(complete.cases(.)) %>%
    mutate(case = case_when(group == "xylazine" ~ 1, group == "alcohol" ~ 0)) %>% 
    mutate_if(is.character, as.factor) %>%
    filter(!is.na(case))


# matchit function
m2 <- matchit(case ~ age + race + gender + death_year, data = dff, method = "nearest", distance = "glm", ratio = 2)
print(summary(m2))

# match table
a <- match.data(m2)
a2 <- 
  a %>% 
  left_join(dff %>% select(CaseIdentifier, composite_longitude, composite_latitude, casenumber)) %>% 
  select(matchnumber = subclass, CaseIdentifier, casenumber, age, race, gender, CaseIdentifier, composite_longitude, composite_latitude, group, death_year, case, distance, weights) %>% 
  arrange(matchnumber, desc(case))

# write
write.csv(a2, "xylazine_matched_alcohol.csv", row.names = F)



## xylazine-stimulant


# cleaning
dff <- 
    df %>% 
    select(CaseIdentifier, age, race, gender, group, death_year, casenumber, composite_latitude, composite_longitude) %>%
    filter(complete.cases(.)) %>%
    mutate(case = case_when(group == "xylazine" ~ 1, group == "stimulant" ~ 0)) %>% 
    mutate_if(is.character, as.factor) %>%
    filter(!is.na(case))


# matchit function
m2 <- matchit(case ~ age + race + gender + death_year, data = dff, method = "nearest", distance = "glm", ratio = 2)
print(summary(m2))

# match table
a <- match.data(m2)
a2 <- 
  a %>% 
  left_join(dff %>% select(CaseIdentifier, composite_longitude, composite_latitude, casenumber)) %>% 
  select(matchnumber = subclass, CaseIdentifier, casenumber, age, race, gender, CaseIdentifier, composite_longitude, composite_latitude, group, death_year, case, distance, weights) %>% 
  arrange(matchnumber, desc(case))

# write
write.csv(a2, "xylazine_matched_stimulant.csv", row.names = F)

