# package install and load
install.packages("spatstat", repos = "http://cran.us.r-project.org")
install.packages("smacpod", repos = "http://cran.us.r-project.org")
install.packages("tidyverse", repos = "http://cran.us.r-project.org")
install.packages("dyplr", repos = "http://cran.us.r-project.org")

library(spatstat)
library(smacpod)
library(tidyr)
library(dplyr)

# --------- 
# load datasets and combine
# drop nulls
cases <- read.csv("cases.csv")
controls <- read.csv("controls.csv")

stopifnot(colnames(cases) == colnames(controls))
combined <- rbind(cases, controls)
combined$case_control <- as.factor(combined$case_control)

original_rows <- nrow(combined)
combined <- combined %>%
  drop_na("final_latitude") %>%
  drop_na("final_longitude")
filtered_rows <- nrow(combined)
cat("Ommited", original_rows - filtered_rows, "(case) rows because they contained nulls.\n")

sample_n(combined, size = 5)

# -------------------
# cases analysis

# latitude is Y axis
# make pattern
case_pattern <- ppp(cases$final_longitude, cases$final_latitude, c(-89, -87), c(41, 43))

# visualize pattern
summary(case_pattern)

# plot Kest
# plot(Kest(case_pattern))

# plot envelopes
plot(envelope(case_pattern, Kest, nsim = 999))

# ------------------
# replicate for controls

# latitude is Y axis
# make pattern
control_pattern <- ppp(controls$final_longitude, controls$final_latitude, c(-89, -87), c(41, 43))

# visualize pattern
summary(control_pattern)

# plot Kest
# plot(Kest(control_pattern))

# plot envelopes
plot(envelope(control_pattern, Kest, nsim = 999))

# ----------------
# compare combined

combined_pattern <- ppp(combined$final_longitude, combined$final_latitude, c(-89, -87), c(41, 43), marks = combined$case_control)
marks(combined_pattern) <- combined$case_control

# use envelope and `kd` function from smacpod
plot(envelope(combined_pattern, kd, nsim = 999))


     