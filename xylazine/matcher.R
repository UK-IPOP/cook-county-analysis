# install packages
# install.packages("readr", repos = "http://cran.us.r-project.org")
# install.packages("dplyr", repos = "http://cran.us.r-project.org")
# install.packages("MatchIt", repos = "http://cran.us.r-project.org")

# load packages
library(readr)
library(dplyr)
library(MatchIt)

# read csv
df <- read.csv("./combined.csv")
df

# cleaning
df1 <- 
    df %>% 
    select(casenumber, age, race, gender, case_control) %>%
    filter(complete.cases(.)) %>%
    mutate(case = case_when(case_control == "xylazine" ~ 1, case_control == "fentanyl" ~ 0)) %>% 
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
    select(matchnumber = subclass, casenumber, age, race, gender, casenumber, final_longitude, final_latitude, case_control, case, distance, weights) %>% 
    arrange(matchnumber, desc(case))

# write
write.csv(a2, "xylazine_matched_fentanyl.csv", row.names = F)



# cleaning
df1 <- 
    df %>% 
    select(casenumber, age, race, gender, case_control) %>%
    filter(complete.cases(.)) %>%
    mutate(case = case_when(case_control == "xylazine" ~ 1, case_control == "alcohol" ~ 0)) %>% 
    mutate_if(is.character, as.factor) %>%
    filter(!is.na(case))


# matchit function
m2 <- matchit(case ~ age + race + gender, data = df1, method = "nearest", distance = "glm", ratio = 3)
print(summary(m2))

# match table
a <- match.data(m2)
a2 <- 
    a %>% 
    left_join(df %>% select(casenumber, final_longitude, final_latitude)) %>% 
    select(matchnumber = subclass, casenumber, age, race, gender, casenumber, final_longitude, final_latitude, case_control, case, distance, weights) %>% 
    arrange(matchnumber, desc(case))

# write
write.csv(a2, "xylazine_matched_alcohol.csv", row.names = F)




# cleaning
df1 <- 
    df %>% 
    select(casenumber, age, race, gender, case_control) %>%
    filter(complete.cases(.)) %>%
    mutate(case = case_when(case_control == "fentanyl" ~ 1, case_control == "alcohol" ~ 0)) %>% 
    mutate_if(is.character, as.factor) %>%
    filter(!is.na(case))


# matchit function
m2 <- matchit(case ~ age + race + gender, data = df1, method = "nearest", distance = "glm", ratio = 3)
print(summary(m2))

# match table
a <- match.data(m2)
a2 <- 
    a %>% 
    left_join(df %>% select(casenumber, final_longitude, final_latitude)) %>% 
    select(matchnumber = subclass, casenumber, age, race, gender, casenumber, final_longitude, final_latitude, case_control, case, distance, weights) %>% 
    arrange(matchnumber, desc(case))

# write
write.csv(a2, "fentanyl_matched_alcohol.csv", row.names = F)