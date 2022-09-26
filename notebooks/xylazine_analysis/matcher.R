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
df1 <- 
    df %>% 
    select(casenumber, age, race, gender, group) %>%
    filter(complete.cases(.)) %>%
    mutate(case = case_when(group == "xylazine" ~ 1, group == "fentanyl" ~ 0)) %>% 
    mutate_if(is.character, as.factor) %>%
    filter(!is.na(case))


# match-it function
m2 <- matchit(case ~ age + race + gender, data = df1, method = "nearest", distance = "glm", ratio = 3)
print(summary(m2))

# match table
a <- match.data(m2)
a2 <- 
    a %>% 
    left_join(df %>% select(casenumber, final_longitude, final_latitude)) %>% 
    select(matchnumber = subclass, casenumber, age, race, gender, casenumber, final_longitude, final_latitude, group, case, distance, weights) %>% 
    arrange(matchnumber, desc(case))

# write
write.csv(a2, "xylazine_matched_fentanyl.csv", row.names = F)



# cleaning
df2 <- 
    df %>% 
    select(casenumber, age, race, gender, group) %>%
    filter(complete.cases(.)) %>%
    mutate(case = case_when(group == "xylazine" ~ 1, group == "alcohol" ~ 0)) %>% 
    mutate_if(is.character, as.factor) %>%
    filter(!is.na(case))


# matchit function
m2 <- matchit(case ~ age + race + gender, data = df2, method = "nearest", distance = "glm", ratio = 3)
print(summary(m2))

# match table
a <- match.data(m2)
a2 <- 
    a %>% 
    left_join(df %>% select(casenumber, final_longitude, final_latitude)) %>% 
    select(matchnumber = subclass, casenumber, age, race, gender, casenumber, final_longitude, final_latitude, group, case, distance, weights) %>% 
    arrange(matchnumber, desc(case))

# write
write.csv(a2, "xylazine_matched_alcohol.csv", row.names = F)




# # cleaning
# df2 <- 
#     df %>% 
#     select(casenumber, age, race, gender, group) %>%
#     filter(complete.cases(.)) %>%
#     mutate(case = case_when(group == "fentanyl" ~ 1, group == "alcohol" ~ 0)) %>% 
#     mutate_if(is.character, as.factor) %>%
#     filter(!is.na(case))
# 
# 
# # matchit function
# m2 <- matchit(case ~ age + race + gender, data = df2, method = "nearest", distance = "glm", ratio = 3)
# print(summary(m2))
# 
# # match table
# a <- match.data(m2)
# a2 <- 
#     a %>% 
#     left_join(df %>% select(casenumber, final_longitude, final_latitude)) %>% 
#     select(matchnumber = subclass, casenumber, age, race, gender, casenumber, final_longitude, final_latitude, group, case, distance, weights) %>% 
#     arrange(matchnumber, desc(case))
# 
# # write
# write.csv(a2, "fentanyl_matched_alcohol.csv", row.names = F)