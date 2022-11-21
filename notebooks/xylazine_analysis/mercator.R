
library(spatstat)
library(smacpod)
library(tidyr)
library(dplyr)

# --------- 

# load datasets and combine
# drop nulls
data <- read.csv("mercator_2.csv")

df <- tibble::as_tibble(data) %>%
  filter(Projected.Latitude. != "." & Projected.Longitude. != ".") %>%
  mutate(case_control = ifelse(group_case == "fentanyl", 2, 1)) %>% 
  mutate_at(c("Projected.Latitude.", "Projected.Longitude."), as.numeric) %>%
  rename(lat=Projected.Latitude., lon=Projected.Longitude.) %>%
  drop_na()


######
#comp

comp_pattern <- ppp(
  df$lon,
  df$lat,
  c(min(df$lon), max(df$lon)),
  c(min(df$lat), max(df$lat)),
  marks = factor(df$case_control),
  checkdup = FALSE
)

# use envelope and `kd` function from smacpod
comp_all <- envelope(comp_pattern, kd, nsim = 999, correction = "Ripley", rmax = 50000)
summary(comp_all)
plot(comp_all)


for (x in 2014:2018) {
  print(x)
  filt_df <- filter(df, death_year == x)
  
  pattern <- ppp(
    filt_df$lon,
    filt_df$lat,
    c(min(filt_df$lon), max(filt_df$lon)),
    c(min(filt_df$lat), max(filt_df$lat)),
    marks = factor(filt_df$case_control),
    checkdup = FALSE
  )
  
  # use envelope and `kd` function from smacpod
  # rmax to 50k for meters (about 30 miles)
  output <- envelope(pattern, kd, nsim = 999, correction = "best", rmax = 50000)
  # write.csv(output, file = sprintf("output_%s.csv", x))
  plot(output, main = sprintf("Output %s", x))
}
